{x2;if:!$userhash}
{x2;include:header}
<body>
{x2;include:nav}
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span2">
			{x2;include:menu}
		</div>
		<div class="span10" id="datacontent">
{x2;endif}
			<ul class="breadcrumb">
				<li><a href="index.php?{x2;$_app}-master">{x2;$apps[$_app]['appname']}</a> <span class="divider">/</span></li>
				<li><a href="index.php?{x2;$_app}-master-basic&page={x2;$page}{x2;$u}">考场管理</a> <span class="divider">/</span></li>
				<li class="active">考试范围</li>
			</ul>
			<ul class="nav nav-tabs">
				<li class="active">
					<a href="#">考试范围</a>
				</li>
				<li class="dropdown pull-right">
					<a href="index.php?exam-master-basic&page={x2;$page}{x2;$u}">考场管理</a>
				</li>
			</ul>
	        <form action="?exam-master-basic-setexamrange" method="post" class="form-horizontal">
				<table class="table">
					<thead>
					<tr>
						<th colspan="8">{x2;$basic['basic']}</th>
					</tr>
					</thead>
					<tr>
						<td>
							考场ID：
						</td>
						<td>
							{x2;$basic['basicid']}
						</td>
						<td>
							科目：
						</td>
						<td>
							{x2;$subjects[$basic['basicsubjectid']]['subject']}
						</td>
						<td>
							地区：
						</td>
			        	<td>
			        		{x2;$areas[$basic['basicareaid']]['area']}
			        	</td>
			        	<td>
							API标识：
						</td>
						<td>
							{x2;$basic['basicapi']}
						</td>
					</tr>
				</table>
				<div class="control-group">
					<label class="control-label">章节选择：</label>
				</div>
				{x2;tree:$sections,section,sid}
				<div class="control-group">
					<label class="control-label">
				        {x2;v:section['section']}
				    </label>
				    <div class="controls" style="text-indent:10px;">
				    	{x2;tree:$knows[v:section['sectionid']],know,kid}
				    	<label class="checkbox inline"><input type="checkbox" value="{x2;v:know['knowsid']}" name="args[basicknows][{x2;v:section['sectionid']}][{x2;v:know['knowsid']}]" {x2;if:$basic['basicknows'][v:section['sectionid']][v:know['knowsid']] == v:know['knowsid']}checked{x2;endif}/>{x2;v:know['knows']}</label>
				    	{x2;endtree}
				    </div>
				</div>
				{x2;endif}
				<div class="control-group">
					<label for="basicexam_auto" class="control-label">绑定随机抽题试卷：</label>
					<div class="controls">
						<textarea id="basicexam_auto" name="args[basicexam][auto]" needle="needle" msg="您必须填写至少一个试卷">{x2;$basic['basicexam']['auto']}</textarea>
						<span class="help-block">请在试卷管理 > 随机组卷处查看试卷ID，将数字ID填写在这里，多个请用英文逗号（,）隔开。留空或填0时将无法进行该项考试。</span>
					</div>
				</div>
				<div class="control-group">
					<label for="basicexam_autotemplate" class="control-label">随机试卷模板：</label>
					<div class="controls">
						<select id="basicexam_autotemplate" name="args[basicexam][autotemplate]">
							{x2;tree:$tpls['ep'],tpl,tid}
			            	<option value="{x2;v:tpl}"{x2;if:$basic['basicexam']['autotemplate'] == v:tpl} selected{x2;endif}>{x2;v:tpl}</option>
			            	{x2;endtree}
		            	</select>
					</div>
				</div>
				<div class="control-group">
					<label for="basicexam_self" class="control-label">绑定手工组卷试卷：</label>
					<div class="controls">
						<textarea id="basicexam_self" name="args[basicexam][self]" needle="needle" msg="您必须填写至少一个试卷">{x2;$basic['basicexam']['self']}</textarea>
						<span class="help-block">请在试卷管理 > 手工组卷处查看试卷ID，将数字ID填写在这里，多个请用英文逗号（,）隔开。留空或填0时将无法进行该项考试。</span>
					</div>
				</div>
				<div class="control-group">
					<label for="basicexam_selftemplate" class="control-label">手工试卷模板：</label>
					<div class="controls">
						<select id="basicexam_selftemplate" name="args[basicexam][selftemplate]">
			            	{x2;tree:$tpls['pp'],tpl,tid}
			            	<option value="{x2;v:tpl}"{x2;if:$basic['basicexam']['selftemplate'] == v:tpl} selected{x2;endif}>{x2;v:tpl}</option>
			            	{x2;endtree}
			            </select>
					</div>
				</div>
				<div class="submit">
					<div class="controls">
						<button class="btn btn-primary" type="submit">提交</button>
						<input type="hidden" name="page" value="{x2;$page}"/>
						<input type="hidden" name="setexamrange" value="1"/>
						<input type="hidden" name="basicid" value="{x2;$basic['basicid']}"/>
						{x2;tree:$search,arg,aid}
						<input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>
						{x2;endtree}
					</div>
				</div>
			</form>
{x2;if:!$userhash}
		</div>
	</div>
</div>
</body>
</html>
{x2;endif}