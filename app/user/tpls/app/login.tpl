<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="title" content="无纸化模拟考试系统">
<meta name="description" content="无纸化模拟考试系统">
<meta name="keywords" content="无纸化模拟考试系统">
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>无纸化模拟考试系统</title>
<!–[if lt IE9]>
<script src="app/core/styles/js/html5.js"></script>
<![endif]–>
<!-- Le styles -->
<link href="app/core/styles/css/bootstrap-combined.min.css" rel="stylesheet">
<link href="app/core/styles/css/layoutit.css" rel="stylesheet">
<link href="app/core/styles/css/plugin.css" rel="stylesheet">
<link href="app/core/styles/css/datepicker.css" rel="stylesheet">
<script type="text/javascript" src="app/core/styles/js/jquery.min.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
<script src="app/core/styles/js/html5shiv.js"></script>
<script type="text/javascript" src="app/core/styles/js/jquery-1.9.1.min.js"></script>
<![endif]-->
<script type="text/javascript" src="app/core/styles/js/jquery-ui.js"></script>
<script type="text/javascript" src="app/core/styles/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="app/core/styles/js/bootstrap.min.js"></script>

<script type="text/javascript" src="app/core/styles/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="app/core/styles/js/swfu/swfupload.js"></script>
<script type="text/javascript" src="app/core/styles/js/plugin.js"></script>
</head>
<body>
<div class="container" style="margin-top:4em;">
	<div class="row">
		<div style="margin:auto;width:600px;">
			<div class="greyrow borderbox">
				<form class="form-horizontal" method="post" action="index.php?user-app-login">
					<fieldset>
						<legend><img src="app/core/styles/images/private.png" style="margin:auto 1em;"/>用户登录</legend>
						<div class="blocker" id="aas">&nbsp;</div>
						<div class="control-group">
							<label class="control-label" for="inputEmail">用户名</label>
							<div class="controls">
								<input id="inputEmail" type="text" name="args[username]"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputPassword">密码</label>
							<div class="controls">
								<input id="inputPassword" type="password" name="args[userpassword]"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="randCode"><a href="index.php?user-app-register">注册用户</a></label>
							<div class="controls">
								<input type="hidden" value="1" name="userlogin"/>
								<button class="btn" type="submit">登陆</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
