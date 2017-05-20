<?php
/*
 * Created on 2013-12-26
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
class app
{
	public $G;

	public function __construct(&$G)
	{
		$this->G = $G;
		$this->ev = $this->G->make('ev');
		$this->tpl = $this->G->make('tpl');
		$this->sql = $this->G->make('sql');
		$this->db = $this->G->make('db');
		$this->pg = $this->G->make('pg');
		$this->module = $this->G->make('module');
		$this->session = $this->G->make('session');
		$this->user = $this->G->make('user','user');
		$groups = $this->user->getUserGroups();
		$this->tpl->assign('groups',$groups);
		$this->tpl->assign('userhash',$this->ev->get('userhash'));
		$this->order = $this->G->make('orders','bank');
		$this->tasks = $this->G->make('tasks','user');
	}

	public function run()
	{
		include_once("../wxpay/WxPayPubHelper/wxpay.cls.php");
		$JS_API_CALL_URL = 'http://tiku.yanlewx.com/wxpay.php';
		$NOTIFY_URL = 'http://tiku.yanlewx.com/api/wxnotify.php';

		//使用通用通知接口
		$notify = new Notify_pub();

		//存储微信的回调
		$xml = $GLOBALS['HTTP_RAW_POST_DATA'];
		$tmpxml = simplexml_load_string($xml);
		$ordersn = (string)$tmpxml->out_trade_no;
		$notify->setConstValue();

		$notify->saveData($xml);
		if($notify->checkSign() == FALSE){
			$notify->setReturnParameter("return_code","FAIL");//返回状态码
			$notify->setReturnParameter("return_msg","签名失败");//返回信息
		}else{
			$notify->setReturnParameter("return_code","SUCCESS");//设置返回码
		}

		$returnXml = $notify->returnXml();
		echo $returnXml;
		if($notify->checkSign() == TRUE)
		{
			if ($notify->data["return_code"] == "FAIL") {
				//此处应该更新一下订单状态，商户自行增删操作
			}
			elseif($notify->data["result_code"] == "FAIL"){
				//此处应该更新一下订单状态，商户自行增删操作
				//file_put_contents('../data/orderback4.txt','2');
			}
			else{
				$ordersn = $notify->data["out_trade_no"];
				$orders = $this->G->make('orders');
				$order = $orders->getOrderById($ordersn);
				if($order['orderstatus'] == 2)
				{
					exit;
				}
				else
				{
					$orders->modifyOrderById($ordersn,array('orderstatus' => 2));
					$user = $this->user->getUserById($order['orderuserid']);
					$args['usercoin'] = $user['usercoin']+$order['orderprice']*10;
					$this->user->modifyUserInfo($args,$order['orderuserid']);
				}
				//在这里增加支付成功后的处理函数
			}
		}
	}
}
include '../lib/api.cls.php';
$ginkgo = new ginkgo;
$ginkgo->run();

?>