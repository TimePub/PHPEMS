<div class="row-fluid top">
	<div class="container-fluid">
		<div class="span7"><a name="top"></a><h2><img src="app/user/styles/img/theme/logo.png" /> 模拟考试系统</h2></div>
		<div class="span5">
			<ul class="unstyled" id="userNav">
				<li>
					<div class="btn-group pull-right">
						<button class="btn dropdown-toggle" data-toggle="dropdown"><em class="icon-user"></em> {x2;$_user['username']} <span class="caret"></span></button>
						<ul class="dropdown-menu">
							{x2;if:$_user['teacher_subjects']}
							<li><a href="index.php?exam-teach">教师管理</a></li>
							{x2;endif}
							<li><a href="index.php?user-app-center">个人中心</a></li>
							<li><a href="index.php?user-app-logout">退出</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>