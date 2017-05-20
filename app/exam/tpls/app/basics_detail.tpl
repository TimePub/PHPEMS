{x2;if:!$userhash}
{x2;include:head}
<body>
<!--导航-->
{x2;include:nav}
<div id="main">
	<!--主体左侧-->
	{x2;include:left}
	<!--主体左侧 结束-->
	<!--主体右侧 -->
	<div id="right_760" class="right_760">
    	{x2;include:bread}
    	<div class="bor_top"></div>
    	<div class="bor_mid">
    		<div id="hide_left"><a href="javascript:pr()"></a></div>
            <div id="notice">
            	<h2 class="page_title"><img src="app/exam/styles/image/exam_notice_basic.jpg" alt="开通考场" /></h2>
            </div>
            <div class="container-fluid" id="datacontent">
{x2;endif}
				<div class="row-fluid">
					<div class="span6">
						<div class="thumbnail"><img alt="300x200" src="app/exam/styles/image/paper.png" /></div>
					</div>
					<div class="span6">
						<div class="caption">
							<h3>{x2;$basic['basic']}</h3>
							<p>&nbsp;</p>
							<p>科目：{x2;$subjects[$basic['basicsubjectid']]['subject']}</p>
							<p>地区：{x2;$areas[$basic['basicareaid']]['area']}</p>
							<p>您现有积分：{x2;$_user['usercoin']} （<a href="index.php?user-center-payfor">充值</a>）</p>
							{x2;if:$isopen}<p>到期时间：{x2;date:$isopen['obendtime'],'Y-m-d'}</p>{x2;endif}
						</div>
						<div>&nbsp;</div>
						{x2;if:!$isopen}
						<form action="index.php?exam-app-basics-openit" method="post">
							{x2;if:!$basic['basicdemo']}
								{x2;if:$price}
								<p>
									<select name="opentype" class="input-medium">
										{x2;tree:$price,p,pid}
										<option value="{x2;v:key}">{x2;v:p['price']}积分兑换{x2;v:p['time']}天</option>
										{x2;endtree}
									</select>
								</p>
								<p>
									<input value="{x2;$basic['basicid']}" name="basicid" type="hidden"/>
									<input class="btn btn-primary" value="开通" type="submit"/>
								</p>
								{x2;else}
								<p>
									<input class="btn" value="请管理员先在后台设置价格" type="button"/>
								</p>
								{x2;endif}
							{x2;else}
							<p>
								<input value="{x2;$basic['basicid']}" name="basicid" type="hidden"/>
								<input class="btn btn-primary" value="开通" type="submit"/>
							</p>
							{x2;endif}
						</form>
						{x2;else}
						<p>
							<input class="btn" value="已开通" type="button"/>
						</p>
						{x2;endif}
					</div>
				</div>
				<div class="pagination pagination-right">
					<ul>{x2;$basics['pages']}</ul>
		        </div>
{x2;if:!$userhash}
			</div>
    	</div>
    	<div class="bor_bottom"></div>
    </div>
	<!--主体右侧 结束-->
	<!--尾部-->
	{x2;include:foot}
    <!--尾部 结束-->
</div>
</body>
</html>
{x2;endif}