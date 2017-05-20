<?php

class log_course
{
	public $G;

	public function __construct(&$G)
	{
		$this->G = $G;
	}

	public function _init()
	{
		$this->categories = NULL;
		$this->tidycategories = NULL;
		$this->pdosql = $this->G->make('pdosql');
		$this->db = $this->G->make('pepdo');
		$this->pg = $this->G->make('pg');
		$this->ev = $this->G->make('ev');
	}

	public function getLogByArgs($args)
	{
		$data = array(false,'log',$args);
		$sql = $this->pdosql->makeSelect($data);
		return $this->db->fetch($sql);
	}

	public function addLog($args)
	{
		$args['logtime'] = TIME;
		return $this->db->insertElement(array('table' => 'log','query' => $args));
	}

	//public function
}

?>
