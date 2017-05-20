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
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

	private function coursejs()
	{
		$contentid = $this->ev->get('contentid');
		$r = $this->log->getLogByArgs(array(array('AND',"loguserid = :loguserid",'loguserid',$this->_user['sessionuserid']),array('AND',"logcourseid = :logcourseid",'logcourseid',$contentid)));
		if((TIME - $r['logtime']) > 10)echo "document.write('[已学习]');";
	}

	private function opencourse()
	{
		$csid = $this->ev->get('csid');
		$course = $this->course->getCourseById($csid);
		if($this->ev->get('opencs'))
		{
			$userid = $this->_user['sessionuserid'];
			if($this->course->getOpenCourseByUseridAndCsid($userid,$csid))
			{
				$message = array(
					'statusCode' => 300,
					"message" => "您已经开通了本课程"
				);
			}
			if($course['csdemo'])
			{
				$time = 365*24*3600;
			}
			else
			{
				$opentype = intval($this->ev->get('opentype'));
				$price = 0;
				if(trim($course['csprice']))
				{
					$price = array();
					$course['csprice'] = explode("\n",$course['csprice']);
					foreach($course['csprice'] as $p)
					{
						if($p)
						{
							$p = explode(":",$p);
							$price[] = array('time'=>intval($p[0]),'price'=>intval($p[1]));
						}
					}
				}
				if(!$price[$opentype])$t = $price[0];
				else
				$t = $price[$opentype];
				$time = $t['time']*24*3600;
				$score = $t['price'];
				$user = $this->user->getUserById($this->_user['sessionuserid']);
				if($user['usercoin'] < $score)
				{
					$message = array(
						'statusCode' => 300,
						"message" => "操作失败，您的积分不够"
					);
					$this->G->R($message);
				}
				else
				{
					$args = array("usercoin" => $user['usercoin'] - $score);
					$this->user->modifyUserInfo($args,$this->_user['sessionuserid']);
				}
			}
			$args = array('ocuserid'=>$userid,'occourseid'=>$csid,'ocendtime'=>TIME + $time);
			$this->course->openCourse($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?course-app-course&csid=".$csid
			);
			$this->G->R($message);
		}
		else
		{
			$price = 0;
			if(trim($course['csprice']))
			{
				$price = array();
				$course['csprice'] = explode("\n",$course['csprice']);
				foreach($course['csprice'] as $p)
				{
					if($p)
					{
						$p = explode(":",$p);
						$price[] = array('time'=>$p[0],'price'=>$p[1]);
					}
				}
				$this->tpl->assign('price',$price);
			}
			$isopen = $this->course->getOpenCourseByUseridAndCsid($this->_user['sessionuserid'],$csid);
			$this->tpl->assign('isopen',$isopen);
			$this->tpl->assign('course',$course);
			$this->tpl->display('opencourse');
			print_r($isopen);
		}
	}

	private function index()
	{
		$page = $this->ev->get('page');
		$csid = $this->ev->get('csid');
		$contentid = $this->ev->get('contentid');
		$course = $this->course->getCourseById($csid);
		if($course['csprice'])
		{
			$userid = $this->_user['sessionuserid'];
			if(!$this->course->getOpenCourseByUseridAndCsid($userid,$csid))
			{
				header("location:index.php?course-app-course-opencourse&csid=".$csid);
				exit;
			}
		}
		$catbread = $this->category->getCategoryPos($course['cscatid']);
		$cat = $this->category->getCategoryById($course['cscatid']);
		$catbrother = $this->category->getCategoriesByArgs(array(array('AND',"catparent = :catparent",'catparent',$cat['catparent']),array('AND',"catinmenu = '0'")));
		$nearCourse = $this->course->getNearCourseById($csid,$course['cscatid']);
		$contents = $this->content->getCourseList(array(array("AND","coursecsid = :coursecsid",'coursecsid',$csid)));
		if($contentid)$content = $this->content->getCourseById($contentid);
		else
		$content = current($contents['data']);
		$r = $this->log->getLogByArgs(array(array('AND',"loguserid = :loguserid",'loguserid',$this->_user['sessionuserid']),array('AND',"logcourseid = :logcourseid",'logcourseid',$contents['courseid'])));
		if(!$r)$this->log->addLog(array('loguserid' => $this->_user['sessionuserid'],'logcourseid' => $contentid));
		$this->tpl->assign('cat',$cat);
		$this->tpl->assign('nearCourse',$nearCourse);
		$this->tpl->assign('page',$page);
		$this->tpl->assign('catbread',$catbread);
		$this->tpl->assign('course',$course);
		$this->tpl->assign('contents',$contents);
		$this->tpl->assign('content',$content);
		$this->tpl->assign('catbrother',$catbrother);
		$this->tpl->display('course_default');
	}
}


?>
