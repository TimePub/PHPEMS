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

	private function index()
	{
		$path = 'files/attach/images/content/'.date('Ymd').'/';
		$upfile = $this->ev->getFile('Filedata');
		if($upfile)
		$fileurl = $this->files->uploadFile($upfile,$path,NULL,NULL,$this->allowexts);
		if($fileurl)
		{
			$args = array();
			$args['attpath'] = $fileurl;
			$args['atttitle'] = $upfile['name'];
			$args['attext'] = $this->files->getFileExtName($upfile['name']);
			$args['attsize'] = $upfile['size'];
			$args['attuserid'] = $this->_user['sessionuserid'];
			$args['attcntype'] = $upfile['type'];
			$this->attach->addAttach($args);
			if($this->ev->get('imgwidth') || $this->ev->get('imgheight'))
			{
				if($this->files->thumb($fileurl,$fileurl.'.png',$this->ev->get('imgwidth'),$this->ev->get('imgheight')))
				$thumb = $fileurl.'.png';
				else
				$thumb = $fileurl;
			}
			else
			$thumb = $fileurl;
			exit(json_encode(array('status' => 'succ','thumb' => $thumb)));
		}
		else
		{
			exit(json_encode(array('status' => 'fail')));
		}
	}
}


?>
