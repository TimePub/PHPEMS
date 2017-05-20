<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="title" content="2014甘肃网络安全攻防竞赛平台">
<meta name="description" content="2014甘肃网络安全攻防竞赛平台">
<meta name="keywords" content="2014甘肃网络安全攻防竞赛平台">
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>PHPEMS在线考试系统</title>
<!--
<link href="app/core/styles/css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="app/core/styles/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="app/core/styles/js/bootstrap.min.js"></script>
<script type="text/javascript" src="app/core/styles/js/unslider.min.js"></script>
<script type="text/javascript" src="app/core/styles/js/highcharts.js"></script>
<link href="app/content/styles/css/theme.css" rel="stylesheet" type="text/css" />
-->
<link href="app/core/styles/css/bootstrap.css" rel="stylesheet">
<link href="app/core/styles/css/plugin.css" rel="stylesheet">
<link href="app/content/styles/css/theme.css" rel="stylesheet" type="text/css" />
<link href="app/core/styles/css/datetimepicker.css" rel="stylesheet">
<script type="text/javascript" src="app/core/styles/js/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="app/exam/styles/css/mathquill.css" type="text/css">
<script type="text/javascript" src="app/core/styles/js/jquery-ui.js"></script>
<script type="text/javascript" src="app/core/styles/js/jquery.json.js"></script>
<script type="text/javascript" src="app/core/styles/js/bootstrap.min.js"></script>
<script type="text/javascript" src="app/core/styles/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="app/core/styles/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="app/core/styles/js/swfu/swfupload.js"></script>
<script type="text/javascript" src="app/core/styles/js/plugin.js"></script>
<script type="text/javascript" src="app/core/styles/js/unslider.min.js"></script>
<script type="text/javascript" src="app/core/styles/js/highcharts.js"></script>
</head>
<body>
<div class="row-fluid" style="background-color:#ececec;border-bottom: 1px solid #D9D9D9;height:110px;">
	<div class="container-fluid" style="background-color:#ececec;">
		<div class="span6" style="padding-top:25px;">
			<h2><img src="app/user/styles/img/theme/logo.png" /> 模拟考试系统</h2>
		</div>
		<div class="span6">
			<div class="text-right" style="margin-top:8px;font-size:0.85em;padding-right:2em;margin-bottom:12px;">
				{x2;if:$_user['userid']}
				您好（{x2;$_user['username']}）&nbsp;&nbsp;<a href="index.php?user-center"><em class="icon-user"></em> 用户中心</a>{x2;if:$_user['teacher_subjects']}&nbsp;&nbsp;<em class="icon-edit"></em> <a href="index.php?exam-teach">教师管理</a>{x2;elseif:$_user['groupid'] == 1}&nbsp;&nbsp;<em class="icon-edit"></em> <a href="index.php?core-master">后台管理</a>{x2;endif}&nbsp;&nbsp;<a href="index.php?user-app-logout"><em class="icon-lock"></em> 退出</a>
				{x2;else}
				<a href="javascript:;" onclick="javascript:$.loginbox.show();"><em class="icon-lock"></em> 登录</a>&nbsp;&nbsp;<a href="index.php?user-center"><em class="icon-user"></em> 注册</a>
				{x2;endif}
			</div>
			<div class="navbar">
				<div class="">
					<div class="nav-collapse collapse navbar-responsive-collapse">
						<ul class="nav pull-right">
							<li>
								<a href="index.php">主页</a>
							</li>
							<li>
								<a href="index.php?exam">在线考试</a>
							</li>
							<li>
								<a href="category.html">企业文化</a>
							</li>
							<li>
								<a href="category.html">管理团队</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row-fluid" id="content">
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="banner" style="margin:10px auto 20px auto;">
				<ul class="unstyled">
					<li style="background-image: url('styles/img/sunset.png');">
						<div class="inner">
						</div>
					</li>
					<li style="background-image: url('styles/img/sunset.png');">
						<div class="inner">
						</div>
					</li>
					<li style="background-image: url('styles/img/sunset.png');">
						<div class="inner">
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span8">
				<div class="tabbable marginblock" id="tabs-424787">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-190221" data-toggle="tab">沪市A股</a>
						</li>
						<li>
							<a href="#panel-727496" data-toggle="tab">深市B股</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="panel-190221">
							{x2;sql:"select 1+1",data}
							{x2;eval: print_r(v:data)}
							<p style="max-width:900px;height:220px;overflow:hidden;" class="span12" name="季度线K1" data-x="Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec" data-y="7.0|6.9|9.5|14.5|18.2|21.5|25.2|26.5|23.3|18.3|13.9|9.6"></p>
						</div>
						<div class="tab-pane" id="panel-727496">
							<p style="max-width:900px;height:220px;overflow:hidden;" class="span12" name="季度线K2" data-x="Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec" data-y="7.0|6.9|9.5|14.5|18.2|21.5|25.2|26.5|23.3|18.3|13.9|9.6"></p>
						</div>
					</div>
				</div>
				<div class="row-fluid marginblock">
					<div class="span6">
						<div class="tabbable" id="tabs-424787211">
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#panel-190221211" data-toggle="tab">沪市A股</a>
								</li>
							</ul>
						</div>
						<ul class="lists">
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
						</ul>
					</div>
					<div class="span6">
						<div class="tabbable" id="tabs-424787212">
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#panel-190221212" data-toggle="tab">沪市A股</a>
								</li>
							</ul>
						</div>
						<ul class="lists">
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row-fluid marginblock">
					<p><img src="http://www.kffund.cn/images/ccfx.jpg" /></p>
				</div>
				<div class="row-fluid marginblock">
					<div class="span6">
						<div class="tabbable" id="tabs-4247872111">
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#panel-1902212111" data-toggle="tab">沪市A股</a>
								</li>
							</ul>
						</div>
						<ul class="lists">
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
						</ul>
					</div>
					<div class="span6">
						<div class="tabbable" id="tabs-4247872122">
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#panel-1902212122" data-toggle="tab">沪市A股</a>
								</li>
							</ul>
						</div>
						<ul class="lists">
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
							<li>
								<a href="content.html">期货资管网7月期货私募基金业绩</a><a class="pull-right">08-15</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="span4">
				<div class="tabbable" id="tabs-4247872">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-1902212" data-toggle="tab">沪市A股</a>
						</li>
					</ul>
				</div>
				<ul class="lists marginblock">
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
				</ul>
				<div class="marginblock">
					<p><img src="http://www.kffund.cn/images/phone_23.jpg" /></p>
				</div>
				<div class="tabbable" id="tabs-42478720">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-19022120" data-toggle="tab">沪市A股</a>
						</li>
					</ul>
				</div>
				<ul class="lists marginblock">
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
				</ul>
				<div class="tabbable" id="tabs-42478720">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-19022120" data-toggle="tab">沪市A股</a>
						</li>
					</ul>
				</div>
				<ul class="lists marginblock">
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
					<li>
						<a href="content.html">期货资管网7月期货私募基金</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="row-fluid" style="background-color:#F8F8F8;border-top: 1px solid #E3E3E3;">
	<div class="container-fluid" style="background-color:#F8F8F8;font-size:0.85em;">
		<div class="span3 pull-right">
			<img alt="140x140" src="app/user/styles/img/theme/logo2.png" style="margin-top:20px;"/>
		</div>
		<div class="span9">
			<p>&nbsp;</p>
			<p>Copyright © 2006-2013 KFFUND. 深圳市凯丰投资管理有限公司 版权所有 粤ICP备13052586</p>
		</div>
	</div>
</div>
<Script>
$(function() {
    $('.banner').unslider({dots: true});
});
</script>
</body>
</html>