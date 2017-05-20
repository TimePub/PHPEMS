{x2;if:!$search}
{x2;include:head}
{x2;endif}
		<div class="bloc">
		    <div class="title">
		    	隐私设置
		        <div class="tabs" id="tabs1" rel="cookie">
		            <a href="javascript:;" tab="#tab11">编辑用户</a>
		            <a href="javascript:;" tab="#tab13">修改密码</a>
		        </div>
		    </div>
		    <div class="content">
		        <div id="tab11">
		        	<form action="?user-app-privatement" method="post">
			        	{x2;tree:$forms,form,fid}
						<div class="input">
							<label for="{x2;v:form['id']}">{x2;v:form['title']}：</label>
							{x2;v:form['html']}
						</div>
						{x2;endtree}
						<div class="submit">
							<input type="submit" value="提交"/>
							<input type="reset" value="重置"/>
							<input type="hidden" name="userid" value="{x2;$user['userid']}"/>
							<input type="hidden" name="modifyuserinfo" value="1"/>
							<input type="hidden" name="page" value="{x2;$page}"/>
							{x2;tree:$search,arg,aid}
							<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>
							{x2;endtree}
						</div>
					</form>
		        </div>
		        <div id="tab13">
		        	<form action="?user-app-privatement" method="post">
			        	<div class="input">
			        		<label>旧密码：</label>
			        		<input id="oldpassowrd" type="password" name="oldpassword" needle="true" datatype="password" msg="密码字数必须在6位以上"/>
			        	</div>
			        	<div class="input">
			        		<label>新密码：</label>
			        		<input id="passowrd1" type="password" name="args[password]" needle="true" datatype="password" msg="密码字数必须在6位以上"/>
			        	</div>
			        	<div class="input">
			        		<label>重复密码：</label>
			        		<input type="password" name="args[password2]" needle="true" equ="passowrd1" msg="前后两次密码必须一致且不能为空"/>
			        	</div>
			        	<div class="submit">
							<input type="submit" value="提交"/>
							<input type="reset" value="重置"/>
							<input type="hidden" name="userid" value="{x2;$user['userid']}"/>
							<input type="hidden" name="modifyuserpassword" value="1"/>
							<input type="hidden" name="page" value="{x2;$page}"/>
							{x2;tree:$search,arg,aid}
							<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>
							{x2;endtree}
						</div>
					</form>
		        </div>
		    </div>
		</div>
{x2;if:!$search}
{x2;include:foot}
{x2;endif}