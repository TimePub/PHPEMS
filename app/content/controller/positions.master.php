<?php
/*
 * Created on 2016-5-19
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
class action extends app
{
	public function display()
	{
		$action = $this->ev->url(3);
		$search = $this->ev->get('search');
		$this->u = '';
		if($search)
		{
			$this->tpl->assign('search',$search);
			foreach($search as $key => $arg)
			{
				$this->u .= "&search[{$key}]={$arg}";
			}
		}
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

	private function modifycontent()
	{
		if($this->ev->get('modifyblock'))
		{
			$posid = $this->ev->get('posid');
			$page = $this->ev->get('page');
			$args = $this->ev->get('args');
			$args['blockcontent'] = $args['blockcontent'];
			unset($args['blocktype']);
			$this->block->modifyBlock($posid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
			    "target" => "",
			    "rel" => "",
			    "callbackType" => "forward",
			    "forwardUrl" => "index.php?content-master-positions&page={$page}"
			);
			exit(json_encode($message));
		}
		else
		{
			$posid = $this->ev->get('posid');
			$page = $this->ev->get('page');
			$block = $this->block->getBlockById($posid);
			$block['blockcontent'] = $this->ev->stripSlashes($block['blockcontent']);
			$apps = $this->apps->getAppList();
			foreach($apps as $id => $app)
			{
				$tmp = $this->G->make('api',$app['appid']);
				if($tmp && method_exists($tmp,'parseBlock'))
				continue;
				else
				unset($apps[$id]);
			}
			$this->tpl->assign('block',$block);
			$this->tpl->assign('apps',$apps);
			$this->tpl->assign('page',$page);
			$this->tpl->display('positions_modify');
		}
	}

	private function add()
	{
		if($this->ev->get('addpos'))
		{
			$args = $this->ev->get('args');
			$args['blockcontent'] = $args['blockcontent'];
			$this->block->addBlock($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
			    "target" => "",
			    "rel" => "",
			    "callbackType" => "forward",
			    "forwardUrl" => "index.php?content-master-positions"
			);
			exit(json_encode($message));
		}
		else
		{
			$apps = $this->apps->getAppList();
			foreach($apps as $id => $app)
			{
				$tmp = $this->G->make('api',$app['appid']);
				if($tmp && method_exists($tmp,'parseBlock'))
				continue;
				else
				unset($apps[$id]);
			}
			$this->tpl->assign('apps',$apps);
			$this->tpl->display('positions_add');
		}
	}

	private function delcontent()
	{
		$pcid = $this->ev->get('pcid');
		$page = $this->ev->get('page');
		$this->position->delPosContent($pcid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
		    "target" => "",
		    "rel" => "",
		    "callbackType" => "forward",
		    "forwardUrl" => "index.php?content-master-positions&page={$page}{$this->u}"
		);
		exit(json_encode($message));
	}

	private function pos()
	{
		if($this->ev->get('addpos'))
		{
			$args = $this->ev->get('args');
			$this->position->addPos($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
			    "target" => "",
			    "rel" => "",
			    "callbackType" => "forward",
			    "forwardUrl" => "?content-master-positions-pos"
			);
			exit(json_encode($message));
		}
		else
		{
			$poses = $this->position->getPosList();
			$this->tpl->assign('poses',$poses);
			$this->tpl->display('pos');
		}
	}

	private function lite()
	{
		if($this->ev->get('modifycontentsequence'))
		{
			$page = $this->ev->get('page');
			if($this->ev->get('action') == 'delete')
			{
				$ids = $this->ev->get('delids');
				foreach($ids as $key => $id)
				{
					$this->position->delPosContent($key);
				}
			}
			else
			{
				$ids = $this->ev->get('ids');
				foreach($ids as $key => $id)
				{
					$this->position->modifyPosContent($key,array('pcsequence' => $id));
				}
			}
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?content-master-positions&page={$page}{$this->u}"
			);
			exit(json_encode($message));
		}
		else
		{
			$message = array(
				'statusCode' => 300,
				"message" => "无效访问"
			);
			exit(json_encode($message));
		}
	}

	private function index()
	{
		$page = $this->ev->get('page');
		$search = $this->ev->get('search');
		if($search['posid'])$args = array(array("AND","pcposid = :pcposid",'pcposid',$search['posid']));
		else $args = 1;
		$poses = $this->position->getPosList();
		$positions = $this->position->getPosContentList($args,$page,10);
		$this->tpl->assign('poses',$poses);
		$this->tpl->assign('positions',$positions);
		$this->tpl->assign('page',$page);
		$this->tpl->display('positions');
	}
}


?>
