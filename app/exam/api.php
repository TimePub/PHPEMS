<?php

class app
{
	public $G;
	//联系密钥
	private $sc = 'testSys&dongao';

	public function __construct(&$G)
	{
		$this->G = $G;
		$this->ev = $this->G->make('ev');
		$this->tpl = $this->G->make('tpl');
		$this->sql = $this->G->make('sql');
		$this->db = $this->G->make('db');
		$this->pg = $this->G->make('pg');
		$this->html = $this->G->make('html');
		$this->session = $this->G->make('session');
		$this->exam = $this->G->make('exam','exam');
	}

	public function index()
	{
		header("location:".'index.php?'.$this->G->app.'-app');
	}

	//通过接口进行登录
	public function login()
	{
		$sign = $this->ev->get('sign');
		$sign2 = $this->ev->get('sign2');
		$curId = $this->ev->get('curId');
		$userid = $this->ev->get('userId');
		$username = $this->ev->get('userName');
		$examid = $this->ev->get('examSysId');
		$allExamSysIds = $this->ev->get('allExamSysIds');
		if(!$allExamSysIds)$allExamSysIds = $examid;
		$ts = $this->ev->get('ts');
		$rand =rand(1,6);
		if($rand == 5)
		{
			$this->session->clearOutTimeUser();
			$this->exam->clearOutTimeExamSession();
		}
		//if($sign == md5($userid.$examid.$this->sc.$ts) && $sign2 == md5($this->sc.$allExamSysIds))
		if($sign == md5($userid.$examid.$this->sc.$ts))
		{
			$current = $this->G->make('basic','exam')->getBasicByExamid($curId);
			if(is_array($current))$subject = current($current);
			$this->session->setSessionUser(array('sessionuserid'=>$userid,'sessionpassword'=>md5(rand(100,999)),'sessioncurrent'=>$subject['subjectid'],'sessionpars' => $examid,'sessionip'=>$this->ev->getClientIp(),'sessiongroupid'=>0,'sessionlogintime'=>TIME,'sessionusername'=>$username));
			header("location:".'index.php?'.$this->G->app.'-app');
		}
		else
		//header("location:".'http://member.dongao.com/login.html');
		header("location:".'?exam');
		exit(0);
	}

	//退出登录
	public function logout()
	{
		$this->session->clearSessionUser();
		header("location:".'index.php?'.$this->G->app.'-app');
	}
}

?>