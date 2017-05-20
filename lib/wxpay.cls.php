<?php

require_once "lib/include/WxPay.Config.php";
require_once "lib/include/WxPay.Exception.php";
require_once "lib/include/WxPay.Data.php";
require_once "lib/include/WxPay.Api.php";

class wxpay
{
	public $G;

	public $config = array();

    public function __construct($G)
    {
    	$this->G = $G;
    }

    public function GetPrePayUrl($productId)
	{
		$biz = new WxPayBizPayUrl();
		$biz->SetProduct_id($productId);
		$values = WxpayApi::bizpayurl($biz);
		$url = "weixin://wxpay/bizpayurl?" . $this->ToUrlParams($values);
		return $url;
	}

	/**
	 *
	 * 参数数组转换为url参数
	 * @param array $urlObj
	 */
	private function ToUrlParams($urlObj)
	{
		$buff = "";
		foreach ($urlObj as $k => $v)
		{
			$buff .= $k . "=" . $v . "&";
		}

		$buff = trim($buff, "&");
		return $buff;
	}

	/**
	 *
	 * 生成直接支付url，支付url有效期为2小时,模式二
	 * @param UnifiedOrderInput $input
	 */
	public function GetPayUrl($input)
	{
		if($input->GetTrade_type() == "NATIVE")
		{
			$result = WxPayApi::unifiedOrder($input);
			return $result;
		}
	}

	public function outUrl1($order)
	{
		return $this->GetPrePayUrl($order['ordersn']);
	}

	public function outUrl2($order)
	{
		$input = new WxPayUnifiedOrder();
		$input->SetBody($order['ordertitle']);
		$input->SetAttach($order['ordertitle']);
		//$input->SetOut_trade_no(WxPayConfig::MCHID.date("YmdHis"));
		$input->SetOut_trade_no($order['ordersn']);
		$input->SetTotal_fee($order['orderpirce']);
		$input->SetTotal_fee("1");
		$input->SetTime_start(date("YmdHis"));
		$input->SetTime_expire(date("YmdHis", time() + 600));
		$input->SetGoods_tag($order['ordertitle']);
		$input->SetNotify_url("http://127.0.0.1/pe4.0/api/wxnotify.php");
		$input->SetTrade_type("NATIVE");
		$input->SetProduct_id($order['ordersn']);
		$result = $this->GetPayUrl($input);
		return $result;
		//$result["code_url"];
	}
}

?>