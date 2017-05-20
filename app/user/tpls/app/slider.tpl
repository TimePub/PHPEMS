	<!--HEAD-->
	<div id="head">
		<div class="left">
			<a href="#" class="button profile"><img src="app/core/styles/img/icons/top/huser.png" alt="" /></a>
			欢迎您，
			<a href="#">{x2;$_user['username']}</a>
		</div>
		<div class="right">
			<a href="?user-app">个人中心</a>
			 |
			<a href="?core-master-logout">注销</a>
			<form action="#" id="search" class="search placeholder" style="display:none">
				<label>Looking for something ?</label>
				<input type="text" value="" name="q" class="text"/>
				<input type="submit" value="rechercher" class="submit"/>
			</form>
		</div>
	</div>
<!--SIDEBAR-->
	<div id="sidebar">
		<ul>
			<li><a href="index.php?{x2;$_app}-app"><img src="app/core/styles/img/icons/menu/home.png" alt="" /> 用户中心首页</a></li>
			<li><a href="index.php?{x2;$_app}-app-privatement" class="ajax"><img src="app/core/styles/img/icons/menu/user.png" alt="" /> 密码资料修改</a></li>
		</ul>
		<a href="#collapse" id="menucollapse">&#9664;</a>
	</div>