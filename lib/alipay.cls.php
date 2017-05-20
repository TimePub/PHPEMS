<?php

require_once "lib/include/alipay.func.php";
require_once "lib/include/alipay_submit.class.php";
require_once "lib/include/alipay_notify.class.php";

class alipay
{
	public $G;

	public $config = array();

	private $table;

    public function __construct()
    {
    	$this->setDefaultConfig();
    }

    private function setDefaultConfig()
    {
    	$this->config['partner'] = '2088*****';
		//安全检验码，以数字和字母组成的32位字符
		$this->config['key'] = 'wqui***';
		//签名方式 不需修改
		$this->config['sign_type'] = strtoupper('MD5');
		//字符编码格式 目前支持 gbk 或 utf-8
		$this->config['input_charset'] = strtolower('utf-8');
		//ca证书路径地址，用于curl中ssl校验
		$this->config['cacert'] = 'cacert.pem';
		//访问模式,根据自己的服务器是否支持ssl访问，若支持请选择https；若不支持请选择http
		$this->config['transport'] = 'http';
		//支付宝收款帐号
		$this->config['account'] = 'hbhaida@gmail.com';
    }

    public function setConfig($config)
    {
    	foreach($config as $key => $v)
    	$this->config[$key] = $v;
    }

    public function alinotify()
    {
    	$alinotify = new AlipayNotify($this->config);
    	return $alinotify->verifyNotify();
    }

    public function outPayForUrl($order,$notify_url,$return_url)
    {
    	$alipaySubmit = new AlipaySubmit($this->config);
    	//支付类型
        $payment_type = "1";

        //卖家支付宝帐户
        $seller_email = $this->config['account'];
        //必填
        //商户订单号
        $out_trade_no = $order['ordersn'];
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        $subject = $order['ordertitle'];
        //必填

        //付款金额
        $price = $order['orderprice'];
        //必填

        //商品数量
        $quantity = "1";
        //必填，建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品

        //物流费用
        $logistics_fee = "0.00";
        //必填，即运费

        //物流类型
        $logistics_type = "EXPRESS";
        //必填，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）

        //物流支付方式
        $logistics_payment = "SELLER_PAY";
        //必填，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）

        //订单描述
        $body = "考试系统积分充值";//$order['orderdescribe']

        //商品展示地址
        $show_url = WP.'index.php?item-app-order&ordersn='.$order['ordersn'];;
        //需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html

        //收货人姓名
        $receive_name = "考试系统会员账号";//$order['orderreceive_name']
        //如：张三

        //收货人地址
        $receive_address = "考试系统会员账号";//$order['orderreceive_address']
        //如：XX省XXX市XXX区XXX路XXX小区XXX栋XXX单元XXX号

        //收货人邮编
        $receive_zip = "123456";//$order['orderreceive_zip']
        //如：123456

        //收货人电话号码
        $receive_phone = "010-12341234";//$order['orderreceive_phone']
        //如：0571-88158090

        //收货人手机号码
        $receive_mobile = "13012341234";//$order['orderreceive_mobile']
        //如：13312341234

        //构造要请求的参数数组，无需改动
        $parameter = array(
                "service" => "trade_create_by_buyer",
                "partner" => trim($this->config['partner']),
                "payment_type"  => $payment_type,
                "notify_url"    => $notify_url,
                "return_url"    => $return_url,
                "seller_email"  => $seller_email,
                "out_trade_no"  => $out_trade_no,
                "subject"   => $subject,
                "price" => $price,
                "quantity"  => $quantity,
                "logistics_fee" => $logistics_fee,
                "logistics_type"    => $logistics_type,
                "logistics_payment" => $logistics_payment,
                "body"  => $body,
                "show_url"  => $show_url,
                "receive_name"  => $receive_name,
                "receive_address"   => $receive_address,
                "receive_zip"   => $receive_zip,
                "receive_phone" => $receive_phone,
                "receive_mobile"    => $receive_mobile,
                "_input_charset"    => trim(strtolower($this->config['input_charset']))
        );
		$url = $alipaySubmit->alipay_gateway_new.$alipaySubmit->buildRequestParaToString($parameter);
		unset($alipaySubmit);
		return $url;
    }
}

?>