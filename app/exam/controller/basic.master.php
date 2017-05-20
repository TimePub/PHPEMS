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
		$u = '';
		if($search)
		{
			$this->tpl->assign('search',$search);
			foreach($search as $key => $arg)
			{
				$u .= "&search[{$key}]={$arg}";
			}
		}
		$this->tpl->assign('u',$u);
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

	private function getsubjectquestype()
	{
		$subjectid = $this->ev->get('subjectid');
		$subject = $this->basic->getSubjectById($subjectid);
		$r = array();
		if($subject['subjectsetting']['questypes'])
		{
			foreach($subject['subjectsetting']['questypes'] as $key => $p)
			{
				if($p)$r[] = $key;
			}
		}
		exit(json_encode($r));
	}

	private function getbasicmembernumber()
	{
		$basicid = $this->ev->get('basicid');
		$number = $this->basic->getOpenBasicNumber($basicid);
		echo $number;
	}

	private function output()
	{
		$args = array(array("AND","quest2knows.qkquestionid = questions.questionid"),array("AND","questions.questionstatus = '1'"),array("AND","questions.questionparent = 0"),array("AND","quest2knows.qktype = 0") );
		$tmpknows = '0';
		if($this->ev->get('subjectid'))
		{
			$knows = $this->section->getAllKnowsBySubject($this->ev->get('subjectid'));
			foreach($knows as $p)
			{
				if($p['knowsid'])$tmpknows .= ','.$p['knowsid'];
			}
			$args[] = array("AND","find_in_set(quest2knows.qkknowsid,:qkknowsid)",'qkknowsid',$tmpknows);
		}
		elseif($this->ev->get('sectionid'))
		{
			$knows = $this->section->getKnowsListByArgs(array(array("AND","knowsstatus = 1"),array("AND","knowssectionid = :knowssectionid",'knowssectionid',$this->ev->get('sectionid'))));
			foreach($knows as $p)
			{
				if($p['knowsid'])$tmpknows .= ','.$p['knowsid'];
			}
			$args[] = array("AND","find_in_set(quest2knows.qkknowsid,:qkknowsid)",'qkknowsid',$tmpknows);
		}
		elseif($this->ev->get('knowsid'))
		{
			$knowsid = $this->ev->get('knowsid');
			$args[] = array("AND","find_in_set(quest2knows.qkknowsid,:qkknowsid)",'qkknowsid',$knowsid);
		}
		else
		{
			$message = array(
				'statusCode' => 300,
				"message" => "参数错误"
			);
			$this->G->R($message);
		}
		$questions = $this->exam->getQuestionListByArgs($args);
		$fname = 'data/score/'.$this->ev->get('subjectid').'-'.$this->ev->get('sectionid').'-'.$this->ev->get('knowsid').'-questions.csv';
		$r = array();
		foreach($questions as $p)
		{
			$r[] = array('questiontype' => $p['questiontype'],'question' => iconv("UTF-8","GBK",html_entity_decode($p['question'])),'questionselect' => iconv("UTF-8","GBK",html_entity_decode($p['questionselect'])),'questionselectnumber' => iconv("UTF-8","GBK",$p['questionselectnumber']),'questionanswer' => iconv("UTF-8","GBK",html_entity_decode($p['questionanswer'])),'questiondescribe' => iconv("UTF-8","GBK",html_entity_decode($p['questiondescribe'])),'knowsid' => $p['qkknowsid'],'questionlevel' => $p['questionlevel']);
		}
		if($this->files->outCsv($fname,$r))
		$message = array(
			'statusCode' => 200,
			"message" => "试题导出成功，转入下载页面，如果浏览器没有相应，请<a href=\"{$fname}\">点此下载</a>",
		    "callbackType" => 'forward',
		    "forwardUrl" => "{$fname}"
		);
		else
		$message = array(
			'statusCode' => 300,
			"message" => "试题导出失败"
		);
		$this->G->R($message);
	}

	private function section()
	{
		$subjectid = $this->ev->get('subjectid');
		$subjects = $this->basic->getSubjectList();
		$page = $this->ev->get('page');
		$page = $page > 0?$page:1;
		$sections = $this->section->getSectionList($page,10,array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$subjectid)));
		$this->tpl->assign('sections',$sections);
		$this->tpl->assign('subjectid',$subjectid);
		$this->tpl->assign('subjects',$subjects);
		$this->tpl->display('basic_section');
	}

	private function addsection()
	{
		if($this->ev->get('insertsection'))
		{
			$args = $this->ev->get('args');
			$section = $this->section->getSectionByArgs(array(array("AND","section = :section",'section',$args['section']),array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$args['sectionsubjectid'])));
			if($section)
			{
				$message = array(
					'statusCode' => 300,
					"message" => "操作失败，该科目下已经存在同名的章节"
				);
			}
			else
			{
				$this->section->addSection($args);
				$message = array(
					'statusCode' => 200,
					"message" => "操作成功",
					"callbackType" => "forward",
				    "forwardUrl" => "index.php?exam-master-basic-section&subjectid={$args['sectionsubjectid']}"
				);
			}
			$this->G->R($message);
		}
		else
		{
			$subjectid = $this->ev->get('subjectid');
			$subjects = $this->basic->getSubjectList();
			$this->tpl->assign('subjectid',$subjectid);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->display('basic_addsection');
		}
	}

	private function modifysection()
	{
		if($this->ev->get('modifysection'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$sectionid = $this->ev->get('sectionid');
			$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$sectionid)));
			$tpsection = $this->section->getSectionByArgs(array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$section['sectionsubjectid']),array("AND","section = :section",'section',$args['section']),array("AND","sectionid != :sectionid",'sectionid',$sectionid)));
			if($tpsection)
			{
				$message = array(
					'statusCode' => 300,
					"message" => "操作失败，本科目下已经存在这个章节",
				    "forwardUrl" => "index.php?exam-master-basic-section&subjectid={$section['sectionsubjectid']}&page={$page}"
				);
			}
			else
			{
				$this->section->modifySection($sectionid,$args);
				$message = array(
					'statusCode' => 200,
					"message" => "操作成功",
					"callbackType" => "forward",
				    "forwardUrl" => "index.php?exam-master-basic-section&subjectid={$section['sectionsubjectid']}&page={$page}"
				);
			}
			$this->G->R($message);
		}
		else
		{
			$page = $this->ev->get('page');
			$sectionid = $this->ev->get('sectionid');
			$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$sectionid)));
			$subjects = $this->basic->getSubjectList();
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->assign('section',$section);
			$this->tpl->display('basic_modifysection');
		}
	}

	private function delsection()
	{
		$sectionid = $this->ev->get('sectionid');
		$page = $this->ev->get('page');
		$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$sectionid)));
		$this->section->delSection($sectionid);
		$message = array(
			"statusCode" => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "index.php?exam-master-basic-section&subjectid={$section['sectionsubjectid']}&page={$page}"
		);
		$this->G->R($message);
	}

	private function point()
	{
		$page = $this->ev->get('page');
		$page = $page > 0?$page:1;
		$sectionid = $this->ev->get('sectionid');
		$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$sectionid)));
		if(!$section['sectionid'])
		{
			header('location:index.php?exam-master-subject');
			exit;
		}
		else
		{
			$subjects = $this->basic->getSubjectList();
			$knows = $this->section->getKnowsList($page,10,array(array("AND","knowssectionid = :sectionid",'sectionid',$sectionid),array("AND","knowsstatus = 1")));
			$this->tpl->assign('section',$section);
			$this->tpl->assign('knows',$knows);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->display('basic_point');
		}
	}

	private function addpoint()
	{
		if($this->ev->get('insertknows'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$knows = explode(",",$args['knows']);
			foreach($knows as $know)
			{
				if($know)
				{
					$data = $this->section->getKnowsByArgs(array(array("AND","knowsstatus = 1"),array("AND","knows = :knows",'knows',$know),array("AND","knowssectionid = :knowssectionid",'knowssectionid',$args['knowssectionid'])));
					if($data)
					{
						$errmsg .= $know.',';
					}
					else
					$this->section->addKnows(array("knowssectionid" => $args['knowssectionid'],"knows" => $know));
				}
			}
			$errmsg = trim($errmsg,' ,');
			if($errmsg)$errmsg = $errmsg.'等知识点已经存在，程序自动忽略！';
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功！".$errmsg,
			    "forwardUrl" => "index.php?exam-master-basic-point&sectionid={$args['knowssectionid']}"
			);
			$this->G->R($message);
		}
		else
		{
			$page = $this->ev->get('page');
			$page = $page > 0?$page:1;
			$sectionid = $this->ev->get('sectionid');
			$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$sectionid)));
			if(!$section['sectionid'])
			{
				header('location:index.php?exam-master-subject');
				exit;
			}
			else
			{
				$subjects = $this->basic->getSubjectList();
				$knows = $this->section->getKnowsList($page,10,array(array("AND","knowssectionid = :sectionid",'sectionid',$sectionid),array("AND","knowsstatus = 1")));
				$this->tpl->assign('section',$section);
				$this->tpl->assign('subjects',$subjects);
				$this->tpl->display('basic_addpoint');
			}
		}
	}

	private function modifypoint()
	{
		if($this->ev->get('modifypoint'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$knowsid = $this->ev->get('knowsid');
			$knows = $this->section->getKnowsByArgs(array(array("AND","knowsid = :knowsid",'knowsid',$knowsid)));
			$tpknows = $this->section->getKnowsByArgs(array(array("AND","knowssectionid = :knowssectionid",'knowssectionid',$knows['knowssectionid']),array("AND","knows = :knows",'knows',$args['knows']),array("AND","knowsid != :",'knowsid',$knowsid)));
			if($tpknows)
			{
				$message = array(
					"statusCode" => 300,
					"message" => "操作失败，该章节下已经存在同名的知识点"
				);
			}
			else
			{
				$this->section->modifyKnows($knowsid,$args);
				$message = array(
					"statusCode" => 200,
					"message" => "操作成功",
					"callbackType" => "forward",
				    "forwardUrl" => "index.php?exam-master-basic-point&sectionid={$knows['knowssectionid']}&page={$page}"
				);
			}
			$this->G->R($message);
		}
		else
		{
			$page = $this->ev->get('page');
			$knowsid = $this->ev->get('knowsid');
			$knows = $this->section->getKnowsByArgs(array(array("AND","knowsid = :knowsid",'knowsid',$knowsid)));
			$section = $this->section->getSectionByArgs(array(array("AND","sectionid = :sectionid",'sectionid',$knows['knowssectionid'])));
			$this->tpl->assign('section',$section);
			$this->tpl->assign('knows',$knows);
			$this->tpl->display('basic_modifypoint');
		}
	}

	private function delpoint()
	{
		$knowsid = $this->ev->get('knowsid');
		$sectionid = $this->ev->get('sectionid');
		$page = $this->ev->get('page');
		$this->section->delKnows($knowsid);
		$message = array(
			"statusCode" => 200,
			"message" => "操作成功！",
			"callbackType" => "forward",
		    "forwardUrl" => "reload"
		);
		$this->G->R($message);
	}

	private function subject()
	{
		$subjects = $this->basic->getSubjectList();
		$this->tpl->assign('subjects',$subjects);
		$this->tpl->display('basic_subject');
	}

	private function addsubject()
	{
		if($this->ev->get('insertsubject'))
		{
			$args = array('subject' => $this->ev->get('subject'),'subjectsetting' => $this->ev->get('setting'));
			$data = $this->basic->getSubjectByName($args['subject']);
			if($data)
			{
				$message = array(
				'statusCode' => 300,
				"message" => "操作失败，该科目已经存在"
				);
				$this->G->R($message);
			}
			$this->basic->addSubject($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-subject"
			);
			$this->G->R($message);
		}
		else
		{
			$subjects = $this->basic->getSubjectList();
			$questypes = $this->basic->getQuestypeList();
			$this->tpl->assign('questypes',$questypes);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->display('basic_addsubject');
		}
	}

	private function modifysubject()
	{
		if($this->ev->get('modifysubject'))
		{
			$args = $this->ev->get('args');
			$subjectid = $this->ev->get('subjectid');
			$this->basic->modifySubject($subjectid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-subject"
			);
			$this->G->R($message);
		}
		else
		{
			$subjectid = $this->ev->get('subjectid');
			$subject = $this->basic->getSubjectById($subjectid);
			$questypes = $this->basic->getQuestypeList();
			$this->tpl->assign('questypes',$questypes);
			$this->tpl->assign('subject',$subject);
			$this->tpl->display('basic_modifysubject');
		}
	}

	private function delsubject()
	{
		$subjectid = $this->ev->get('subjectid');
		$section = $this->section->getSectionByArgs(array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$subjectid)));
		if($section)
		$message = array(
			'statusCode' => 300,
			"message" => "操作失败，请删除该科目下所有章节后再删除本科目"
		);
		else
		{
			$this->basic->delSubject($subjectid);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-subject"
			);
		}
		$this->G->R($message);
	}

	private function questype()
	{
		$questypes = $this->basic->getQuestypeList();
		$this->tpl->assign('questypes',$questypes);
		$this->tpl->display('basic_questype');
	}

	private function addquestype()
	{
		if($this->ev->get('insertquestype'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$this->basic->addQuestype($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-questype&page={$page}"
			);
			$this->G->R($message);
		}
		else
		{
			$this->tpl->display('basic_addquestype');
		}
	}

	private function modifyquestype()
	{
		if($this->ev->get('modifyquestype'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$questid = $this->ev->get('questid');
			$this->basic->modifyQuestype($questid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-questype&page={$page}"
			);
			$this->G->R($message);
		}
		else
		{
			$questid = $this->ev->get('questid');
			$quest = $this->basic->getQuestypeById($questid);
			$this->tpl->assign('quest',$quest);
			$this->tpl->display('basic_modifyquest');
		}
	}

	private function delquestype()
	{
		$questid = $this->ev->get('questid');
		$page = $this->ev->get('page');
		$this->basic->delQuestype($questid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "index.php?exam-master-basic-questype&page={$page}"
		);
		$this->G->R($message);
	}

	private function delarea()
	{
		$areaid = intval($this->ev->get('areaid'));
		$this->area->delArea($areaid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "index.php?exam-master-basic-area&page={$page}{$u}"
		);
		$this->G->R($message);
	}

	private function modifyarea()
	{
		if($this->ev->get('modifyarea'))
		{
			$args = $this->ev->get('args');
			$areaid = $this->ev->get('areaid');
			$this->area->modifyArea($areaid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-area&page={$page}{$u}"
			);
			$this->G->R($message);
		}
		else
		{
			$page = intval($this->ev->get('page'));
			$areaid = intval($this->ev->get('areaid'));
			$area = $this->area->getAreaById($areaid);
			$this->tpl->assign('page',$page);
			$this->tpl->assign('area',$area);
			$this->tpl->display('basic_modifyarea');
		}
	}

	private function addarea()
	{
		if($this->ev->get('insertarea'))
		{
			$args = $this->ev->get('args');
			$id = $this->area->addArea($args);
			if(!$id)
			$message = array(
				'statusCode' => 300,
				"message" => "操作失败，区号已存在"
			);
			else
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-area&page={$page}{$u}"
			);
			$this->G->R($message);
		}
		else
		{
			$this->tpl->display('basic_addarea');
		}
	}

	private function area()
	{
		$page = $this->ev->get('page');
		$page = $page > 1?$page:1;
		$areas = $this->area->getAreaListByPage($page,10);
		$this->tpl->assign('page',$page);
		$this->tpl->assign('areas',$areas);
		$this->tpl->display('basic_area');
	}

	private function delbasic()
	{
		$page = $this->ev->get('page');
		$basicid = $this->ev->get('basicid');
		$this->basic->delBasic($basicid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "index.php?exam-master-basic&page={$page}{$u}"
		);
		$this->G->R($message);
	}

	private function batdelbasic()
	{
		$page = $this->ev->get('page');
		$basicid = $this->ev->get('basicid');
		$this->basic->delBasic($basicid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "index.php?exam-master-basic&page={$page}{$u}"
		);
		$this->G->R($message);
	}

	private function modifybasic()
	{
		$page = $this->ev->get('page');
		if($this->ev->get('modifybasic'))
		{
			$basicid = $this->ev->get('basicid');
			$args = $this->ev->get('args');
			$this->basic->setBasicConfig($basicid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic&page={$page}{$u}"
			);
			$this->G->R($message);
		}
		else
		{
			$basicid = $this->ev->get('basicid');
			$basic = $this->basic->getBasicById($basicid);
			$subjects = $this->basic->getSubjectList();
			$areas = $this->area->getAreaList();
			$this->tpl->assign('areas',$areas);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->assign('basic',$basic);
			$this->tpl->display('basic_modify');
		}
	}

	private function offpaper()
	{
		$page = $this->ev->get('page');
		$basicid = $this->ev->get('basicid');
		$args = array();
		$args[] = array("AND","examsessionbasic = :examsessionbasic",'examsessionbasic',$basicid);
		$args[] = array("AND","examsessiontype = 2");
		$sessionusers = $this->exam->getExamSessionByArgs($args,$page);
		$this->tpl->assign('sessionusers',$sessionusers);
		$this->tpl->display('basic_offpaper');
	}

	private function savepaper()
	{
		$sessionid = $this->ev->get('examsessionid');
		$questype = $this->basic->getQuestypeList();
		$sessionvars = $this->exam->getExamSessionBySessionid($sessionid);
		$question = $sessionvars['examsessionuseranswer'];
		$needhand = 0;
		foreach($sessionvars['examsessionquestion']['questions'] as $key => $tmp)
		{
			if(!$questype[$key]['questsort'])
			{
				foreach($tmp as $p)
				{
					if(is_array($sessionvars['examsessionuseranswer'][$p['questionid']]))
					{
						$nanswer = '';
						$answer = $sessionvars['examsessionuseranswer'][$p['questionid']];
						asort($answer);
						$nanswer = implode("",$answer);
						if($nanswer == $p['questionanswer'])$score = $sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'];
						else
						{
							if($questype[$key]['questchoice'] == 3)
							{
								$alen = strlen($p['questionanswer']);
								$rlen = 0;
								foreach($answer as $t)
								{
									if(strpos($p['questionanswer'],$t) === false)
									{
										$rlen = 0;
										break;
									}
									else
									{
										$rlen ++;
									}
								}
								$score = floatval($sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'] * $rlen/$alen);
							}
							else $score = 0;
						}
					}
					else
					{
						$answer = $sessionvars['examsessionuseranswer'][$p['questionid']];
						if($answer == $p['questionanswer'])$score = $sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'];
						else $score = 0;
					}
					$scorelist[$p['questionid']] = $score;
				}
			}
			else
			{
				if(is_array($tmp) && count($tmp))
				$needhand = 1;
			}
		}
		foreach($sessionvars['examsessionquestion']['questionrows'] as $key => $tmp)
		{
			if(!$questype[$key]['questsort'])
			{
				foreach($tmp as $tmp2)
				{
					foreach($tmp2['data'] as $p)
					{
						if(is_array($sessionvars['examsessionuseranswer'][$p['questionid']]))
						{
							$answer = $sessionvars['examsessionuseranswer'][$p['questionid']];
							asort($answer);
							$nanswer = implode("",$answer);
							if($nanswer == $p['questionanswer'])$score = $sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'];
							else
							{
								if($questype[$key]['questchoice'] == 3)
								{
									$alen = strlen($p['questionanswer']);
									$rlen = 0;
									foreach($answer as $t)
									{
										if(strpos($p['questionanswer'],$t) === false)
										{
											$rlen = 0;
											break;
										}
										else
										{
											$rlen ++;
										}
									}
									$score = $sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'] * $rlen/$alen;
								}
								else $score = 0;
							}
						}
						else
						{
							$answer = $sessionvars['examsessionuseranswer'][$p['questionid']];
							if($answer == $p['questionanswer'])$score = $sessionvars['examsessionsetting']['examsetting']['questype'][$key]['score'];
							else $score = 0;
						}
						$scorelist[$p['questionid']] = $score;
					}
				}
			}
			else
			{
				if(!$needhand)
				{
					if(is_array($tmp) && count($tmp))
					$needhand = 1;
				}
			}
		}
		$args['examsessionuseranswer'] = $question;
		$args['examsessionscorelist'] = $scorelist;
		$args['examsessionscore'] = array_sum($scorelist);
		$this->exam->modifyExamSession($args,$sessionid);
		$this->favor->addExamHistory($sessionid);
		$message = array(
			'statusCode' => 200,
			"message" => "操作成功",
			"callbackType" => "forward",
		    "forwardUrl" => "reload"
		);
		$this->G->R($message);
	}

	private function setexamrange()
	{
		$page = $this->ev->get('page');
		$basicid = $this->ev->get('basicid');
		if($this->ev->get('setexamrange'))
		{
			$args = $this->ev->get('args');
			$args['basicsection'] = array();
			if(is_array($args['basicknows']))
			foreach($args['basicknows'] as $key => $p)
			{
				$args['basicsection'][] = $key;
			}
			$args['basicexam']['opentime']['start'] = strtotime($args['basicexam']['opentime']['start']);
			$args['basicexam']['opentime']['end'] = strtotime($args['basicexam']['opentime']['end']);
			$args['basicsection'] = $args['basicsection'];
			$args['basicknows'] = $args['basicknows'];
			$args['basicexam'] = $args['basicexam'];
			$this->basic->setBasicConfig($basicid,$args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic&page={$page}{$u}"
			);
			$this->G->R($message);
		}
		else
		{
			$basic = $this->basic->getBasicById($basicid);
			$subjects = $this->basic->getSubjectList();
			$areas = $this->area->getAreaList();
			$tmpknows = $this->section->getAllKnowsBySubject($basic['basicsubjectid']);
			$knows = array();
			$sections = $this->section->getSectionListByArgs(array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$basic['basicsubjectid'])));
			foreach($tmpknows as $p)
			{
				$knows[$p['knowssectionid']][] = $p;
			}
			$tpls = array();
			foreach(glob("app/exam/tpls/app/exampaper_paper*.tpl") as $p)
			{
				$tpls['ep'][] = substr(basename($p),0,-4);
			}
			foreach(glob("app/exam/tpls/app/exam_paper*.tpl") as $p)
			{
				$tpls['pp'][] = substr(basename($p),0,-4);
			}
			$this->tpl->assign('tpls',$tpls);
			$this->tpl->assign('basic',$basic);
			$this->tpl->assign('areas',$areas);
			$this->tpl->assign('sections',$sections);
			$this->tpl->assign('knows',$knows);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->display('basic_examrange');
		}
	}

	private function add()
	{
		if($this->ev->get('insertbasic'))
		{
			$args = $this->ev->get('args');
			$page = $this->ev->get('page');
			$id = $this->basic->addBasic($args);
			$message = array(
				'statusCode' => 200,
				"message" => "操作成功",
				"callbackType" => "forward",
			    "forwardUrl" => "index.php?exam-master-basic-setexamrange&basicid={$id}&page={$page}{$u}"
			);
			$this->G->R($message);
		}
		else
		{
			$subjects = $this->basic->getSubjectList();
			$areas = $this->area->getAreaList();
			$this->tpl->assign('areas',$areas);
			$this->tpl->assign('subjects',$subjects);
			$this->tpl->display('basic_add');
		}
	}

	private function index()
	{
		$page = $this->ev->get('page');
		$search = $this->ev->get('search');
		$page = $page > 1?$page:1;
		$subjects = $this->basic->getSubjectList();
		if(!$search)
		$args = 1;
		else
		$args = array();
		if($search['basicid'])$args[] = array("AND","basicid = :basicid",'basicid',$search['basicid']);
		else
		{
			if($search['keyword'])$args[] = array("AND","basic LIKE :basic",'basic',"%{$search['keyword']}%");
			if($search['basicareaid'])$args[] = array("AND","basicareaid = :basicareaid",'basicareaid',$search['basicareaid']);
			if($search['basicsubjectid'])$args[] = array("AND","basicsubjectid = :basicsubjectid",'basicsubjectid',$search['basicsubjectid']);
			if($search['basicapi'])$args[] = array("AND","basicapi = :basicapi",'basicapi',$search['basicapi']);
			if($search['basicclosed'])
			{
				if($search['basicclosed'] == 1)$basicclosed = 1;
				else
				$basicclosed = 0;
				$args[] = array("AND","basicclosed = :basicclosed",'basicclosed',$basicclosed);
			}
		}
		$basics = $this->basic->getBasicList($page,10,$args);
		$areas = $this->area->getAreaList();
		$this->tpl->assign('areas',$areas);
		$this->tpl->assign('subjects',$subjects);
		$this->tpl->assign('basics',$basics);
		$this->tpl->display('basic');
	}
}


?>
