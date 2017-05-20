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

	private function test()
	{
		$r = array(
			'discount' => '0.00',
			'payment_type' => '1',
			'subject' => '国通商城商品',
			'trade_no' => '2016101421001004900291069193',
			'buyer_email' => '1039930842@qq.com',
			'gmt_create' => '2016-10-14 14:23:33',
			'notify_type' => 'trade_status_sync',
			'quantity' => '1',
			'out_trade_no' => '20161014142314143719',
			'seller_id' => '2088221435509601',
			'notify_time' => '2016-10-14 14:23:34',
			'body' => 'lala',
			'trade_status' => 'TRADE_SUCCESS',
			'is_total_fee_adjust' => 'N',
			'total_fee' => '0.01',
			'gmt_payment' => '2016-10-14 14:23:34',
			'seller_email' => 'gtmal@gtmal.com',
			'price' => '0.01',
			'buyer_id' => '2088612495080904',
			'notify_id' => 'fb71aa8f38787bd873267ee4e70e899my2',
			'use_coupon' => 'N',
			'sign_type' => 'RSA',
			'sign' => 'CCSJ1kQdT0+EPENBGCuHiaPzqex1NIvXIVMovx77t7h8PVRuJEquOT8lM8WMDyuy057vUpjimXe3QrqTGmIKUsifiu7aiDktNGz0XHs2YiHnuq746GZc1hVSZe6z0G5keHgcd2BS758d/XiBVpWNlxqTI2uhO3Tf/a6dytO174U='
		);

		$url = "http://m.gtmal.com/api/alipayapi.php";
		$post_data = $r;
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		// post数据
		curl_setopt($ch, CURLOPT_POST, 1);
		// post的变量
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
		$output = curl_exec($ch);
		curl_close($ch);
		//打印获得的数据
		exit;
		$http = $this->G->make('http');
		$http->post('http://m.gtmal.com/api/alipayapi.php',$r);
		echo $http->data;
	}

	private function qrcode()
	{
		header("Content-type: image/png");
		require_once("lib/include/phpqrcode.php");
		$data = urldecode($this->ev->get('data'));
		QRcode::png($data);
	}

	private function index()
	{
		//
	}
}


?>
