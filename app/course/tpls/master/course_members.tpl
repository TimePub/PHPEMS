{x2;if:!$userhash}
{x2;include:header}
<body>
{x2;include:nav}
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-2" style="padding-top:10px;margin-bottom:0px;">
				{x2;include:menu}
			</div>
			<div class="col-xs-10" id="datacontent">
{x2;endif}
				<div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">
					<div class="col-xs-12">
						<ol class="breadcrumb">
							<li><a href="index.php?{x2;$_app}-master">{x2;$apps[$_app]['appname']}</a></li>
							<li class="active">成员列表</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;">
					<h4 class="title" style="padding:10px;">
						成员列表
						<a class="btn btn-primary pull-right" href="index.php?{x2;$_app}-master-course-addmember&courseid={x2;$courseid}">增加人员</a>
					</h4>
			        <form action="index.php?course-master-course-members&courseid={x2;$courseid}" method="post" class="form-inline">
						<table class="table">
							<thead>
								<tr>
									<th colspan="5">搜索</th>
								</tr>
							</thead>
							<tr>
								<td>
									用户ID：
								</td>
								<td class="input">
									<input name="search[userid]" class="form-control" size="25" type="text" class="number" value="{x2;$search['userid']}"/>
								</td>
								<td>
									用户名：
								</td>
								<td class="input">
									<input class="form-control" name="search[username]" size="25" type="text" value="{x2;$search['username']}"/>
								</td>
								<td>
									<button class="btn btn-primary" type="submit">搜索</button>
									<input type="hidden" value="1" name="search[argsmodel]" />
								</td>
							</tr>
						</table>
					</form>
			        <table class="table table-hover table-bordered">
						<thead>
							<tr class="info">
			                    <th>ID</th>
						        <th>用户名</th>
						        <th>开通时间</th>
						        <th>注册IP</th>
						        <th>积分点数</th>
						        <th>角色</th>
						        <th>到期时间</th>
						        <th>操作</th>
			                </tr>
			            </thead>
			            <tbody>
			            	{x2;tree:$members['data'],user,uid}
			            	<tr>
			                    <td>{x2;v:user['userid']}</td>
			                    <td>{x2;v:user['username']}</td>
								<td>{x2;date:v:user['octime'],'Y-m-d'}</td><td>{x2;v:user['userregip']}</td>
								<td>{x2;v:user['usercoin']}</td><td>{x2;$groups[v:user['usergroupid']]['groupname']}</td>
								<td>{x2;date:v:user['ocendtime'],'Y-m-d'}</td>
								<td>
								  	<div class="btn-group">
			                    		<a class="btn confirm" href="index.php?course-master-course-delopen&ocid={x2;v:user['ocid']}{x2;$u}" title="取消开通"><em class="glyphicon glyphicon-remove"></em></a>
									</div>
								</td>
			                </tr>
			                {x2;endtree}
			        	</tbody>
			        </table>
			        <ul class="pagination pull-right">
			            {x2;$members['pages']}
			        </ul>
				</div>
			</div>
{x2;if:!$userhash}
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>
{x2;endif}