<?php
/*
 * Created on 2011-12-18
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
class question_exam
{
	public $G;

	public function __construct(&$G)
	{
		$this->G = $G;
	}

	public function _init()
	{
		if(!$this->init)
		{
			$this->sql = $this->G->make('sql');
			$this->db = $this->G->make('db');
			$this->ev = $this->G->make('ev');
			$this->html = $this->G->make('html');
			$this->basic = $this->G->make('basic','exam');
			$this->exam = $this->G->make('exam','exam');
			$this->section = $this->G->make('section','exam');
			$this->tpl = $this->G->make('tpl');
			$this->selectorder = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N');
			$this->tpl->assign('selectorder',$this->selectorder);
			$this->init = 1;
		}
	}

	public function parse($question)
	{
		$questype = $this->basic->getQuestypeById($question['questiontype']);
		if($questype['questsort'])return $this->subjective($question);
		switch($questype['questchoice'])
		{
			case '1':
			case '4':
			return $this->objective($question);
			break;

			default:
			return $this->objective($question,true);
			break;
		}
	}

	public function subjective($question)
	{
		$r = array('title'=>$question['question'],'selectlist'=>false,'selects'=>'','answer'=>$question['questionanswer'],'describe'=>$question['questiondescribe']);
		return $r;
	}

	public function objective($question,$isMultiple = false)
	{
		$r = array('title'=>$question['question'],'describe'=>$question['questiondescribe'],'type' => $question['questiontype']);
		$question['questionselect'] = explode("\n",$question['questionselect']);
		if(!$question['questionselect'][0])
		{
			$question['questionselect'] = array('对','错');
		}
		$r['selectlist'] = $question['questionselect'];
		$values = array();
		foreach($question['questionselect'] as $id => $select)
		{
			//$values[] = array('key'=>$this->selectorder[$id].':'.$select,'value'=>$this->selectorder[$id]);
			$values[] = array('key'=>$this->selectorder[$id],'value'=>$this->selectorder[$id]);
		}
		if($isMultiple)
		{
			$args = array('pars'=>array(array('key'=>'name','value'=>'question['.$question['questionid'].']')),'values'=>$values);
			$r['selects'] = $this->html->checkBoxArray($args);
		}
		else
		{
			$args = array('pars'=>array(array('key'=>'name','value'=>'question['.$question['questionid'].']')),'values'=>$values);
			$r['selects'] = $this->html->radio($args);
		}
		$r['answer'] = explode("\n",$question['questionanswer']);
		sort($r['answer']);
		foreach($r['answer'] as $id=>$p)
		{
			$r['answer'][$id] = trim($p);
		}
		$r['answer'] = implode('',$r['answer']);
		return $r;
	}

	//获取某些指定知识点的试题列表
	public function getRandQuestionListByKnowid($knowid,$typeid)
	{
		$data = array('DISTINCT questions.questionid',array('questions','quest2knows'),array("quest2knows.qkknowsid IN ({$knowid})","quest2knows.qktype = 0","quest2knows.qkquestionid = questions.questionid","questions.questiontype = '{$typeid}'","questions.questionstatus = 1"),false,false,false);
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		$t = array();
		foreach($r as $p)
		{
			$t[] = $p['questionid'];
		}
		return $t;
	}

	//获取某些指定知识点的题帽题列表
	public function getRandQuestionRowsListByKnowid($knowid,$typeid,$number)
	{
		$data = array('DISTINCT questionrows.qrid',array('questionrows','quest2knows'),array("quest2knows.qkknowsid IN ({$knowid})","quest2knows.qktype = 1","quest2knows.qkquestionid = questionrows.qrid","questionrows.qrtype = '{$typeid}'","questionrows.qrnumber <= '{$number}'","questionrows.qrstatus = 1"),false,false,false);
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		$t = array();
		foreach($r as $p)
		{
			$t[] = $p['qrid'];
		}
		return $t;
	}

	//获取试题列表
	public function getRandQuestionList($args = 1)
	{
		if(!is_array($args))$args = array();
		$args[] = "questions.questionstatus = 1";
		$args[] = "quest2knows.qkquestionid = questions.questionid";
		$args[] = "quest2knows.qktype = 0";
		$data = array('DISTINCT questions.questionid',array('questions','quest2knows'),$args,false,false,false);
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		$t = array();
		foreach($r as $p)
		{
			$t[] = $p['questionid'];
		}
		return $t;
	}

	//获取特殊试题列表
	public function getRandQuestionRowsList($args = 1)
	{
		if(!is_array($args))$args = array();
		$args[] = "questionrows.qrstatus = 1";
		$args[] = "quest2knows.qkquestionid = questionrows.qrid";
		$args[] = "quest2knows.qktype = 1";
		$data = array('DISTINCT questionrows.qrid',array('questionrows','quest2knows'),$args,false,false,false);
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		$t = array();
		foreach($r as $p)
		{
			$t[] = $p['qrid'];
		}
		return $t;
	}

	//根据ID获取特殊试题编号
	public function getSpecialQuestionById($questionid)
	{
		$data = array('questionid','questions',array("questionparent = '{$questionid}'","questionstatus = 1"),false,"questionsequence ASC");
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		$t = array(0 => $questionid);
		foreach($r as $p)
		{
			$t[] = $p['questionid'];
		}
		return $t;
	}

	//根据科目和地区信息获取知识点
	public function getKnowsBySubjectAndAreaid($subjectid,$areaid)
	{
		$data = array('esknowsids','examsection',array("essubjectid = '{$subjectid}'","esareaid = '{$areaid}'"));
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		foreach($r as $p)
		{
			$t[] = $p['esknowsids'];
		}
		$n = implode(',',$t);
		$data = array("knowsid","knows",array("knowsid IN ({$n})","knowsstatus = 1"));
		$sql = $this->sql->makeSelect($data);
		$r = $this->db->fetchAll($sql);
		foreach($r as $p)
		{
			$m[] = $p['knowsid'];
		}
		return implode(',',$m);
	}

	//筛选随机试题
	public function selectQuestions($examid,$basic)
	{
		$exam = $this->exam->getExamSettingById($examid);
		$knowsids = '';
		foreach($basic['basicknows'] as $p)
		{
			$knowsids .= trim(implode(',',$p),', ').',';
		}
		$knowsids = trim($knowsids,', ');
		$settings = $exam['examsetting'];
		foreach($settings['questype'] as $key => $p)
		{
			$number = array('1'=>$p['easynumber'],'2'=>$p['middlenumber'],'3'=>$p['hardnumber']);
			arsort($number);
			$par = 0;
			foreach($number as $nkey => $t)
			{
				if(!$par)
				{
					$par++;
					$trand = rand(1,4);
					if($trand < 3)
					{
						$qrs = $this->getRandQuestionRowsList(array("quest2knows.qkknowsid IN ({$knowsids})","questionrows.qrlevel = '{$nkey}'","questionrows.qrtype = '{$key}'","questionrows.qrnumber <= '{$t}'"));
						if(count($qrs))
						{
							$qrid = $qrs[array_rand($qrs,1)];
							$questionrow[$key][] = $qrid;
							$qr = $this->exam->getQuestionRowsByArgs("qrid = '{$qrid}'");
							$t = intval($t - $qr['qrnumber']);
						}
					}
				}
				if($t)
				{
					$r = $this->getRandQuestionList(array("quest2knows.qkknowsid IN ({$knowsids})","questions.questionlevel = '{$nkey}'","questions.questiontype = '{$key}'"));
					if(is_array($r))
					{
						if((count($r) >= $t))
						{
							if($t <= 1)
							{
								$question[$key][] = $r[array_rand($r,1)];
							}
							else
							{
								$ts = array_rand($r,$t);
								foreach($ts as $tmp)
								{
									$question[$key][] = $r[$tmp];
								}
							}
						}
						else
						{
							foreach($r as $tmp)
							$question[$key][] = $tmp;
						}
					}
				}
				while($t)
				{
					$qrs = $this->getRandQuestionRowsList(array("quest2knows.qkknowsid IN ({$knowsids})","questionrows.qrlevel = '{$nkey}'","questionrows.qrtype = '{$key}'","questionrows.qrnumber <= '{$t}'"));
					if(count($qrs))
					{
						$qrid = $qrs[array_rand($qrs,1)];
						$questionrow[$key][] = $qrid;
						$qr = $this->exam->getQuestionRowsByArgs("qrid = '{$qrid}'");
						$t = intval($t - $qr['qrnumber']);
					}
					else
					break;
				}
			}
		}
		return array('question'=>$question,'questionrow'=>$questionrow,'setting'=>$exam);
	}

	//根据知识点获取试题列表
	public function selectQuestionsByKnows($knowsid,$qt = 0,$defaulttype = 2)
	{
		if(!$knowsid)$knowsid = '0';
		if(!$qt)$qt = array(2=>5,3=>4,5=>4,4=>2);
		$question = array();
		$questionrow = array();
		$t = rand(1,2);
		if($t<3 && $qt[$defaulttype] > 0)
		{
			$qrs = $this->getRandQuestionRowsListByKnowid($knowsid,$defaulttype,$qt[$defaulttype]);
			if(count($qrs))
			{
				$qrid = $qrs[array_rand($qrs,1)];
				$questionrow[$defaulttype] = $qrid;
				$qr = $this->exam->getQuestionRowsByArgs("qrid = '{$qrid}'");
				$qt[$defaulttype] = intval($qt[$defaulttype] - $qr['qrnumber']);
			}
		}
		$tn = 0;
		foreach($qt as $key => $number)
		{
			$number = intval($number);
			if($number)
			{
				$question[$key] = array();
				if($key != $defaulttype)
				{
					$r = $this->getRandQuestionListByKnowid($knowsid,$key);
					if(count($r) > $number)
					{
						if($number <= 1)
						{
							$question[$key] = array($r[array_rand($r,1)]);
						}
						else
						{
							$t = array_rand($r,$number);
							foreach($t as $tmp)
							{
								$question[$key][] = $r[$tmp];
							}
						}
					}
					else
					{
						$tn += $number - count($r);
						$question[$key] = $r;
					}
				}
			}
		}

		$tnumber = $tn + $qt[$defaulttype];
		if($tnumber)
		{
			$r = $this->getRandQuestionListByKnowid($knowsid,$defaulttype);
			if(count($r) > $tnumber)
			{
				if($tnumber <= 1)
				$question[$defaulttype] = array($r[array_rand($r,1)]);
				else
				{
					$t = array_rand($r,$tnumber);
					foreach($t as $tmp)
					{
						$question[$defaulttype][] = $r[$tmp];
					}
				}
			}
			else
			$question[$defaulttype] =  $r;
		}
		return array('question'=>$question,'questionrow'=>$questionrow);
	}
}
?>
