{x2;if:!$search}
{x2;include:head}
{x2;endif}
		<div class="bloc">
		    <div class="title">
		        分类列表
		        <div class="tabs" id="tabs1">
		            <a href="javascript:;" tab="#tab11">{x2;if:$parent}【{x2;$categories[$parent]['catname']}】子{x2;else}一级{x2;endif}分类列表</a>
		            <a href="javascript:;" tab="#tab22">添加分类</a>
		        </div>
		    </div>
		    <div class="content">
		        <div id="tab11">
			        <table class="noalt">
			            <thead>
			            	<th width="120">&nbsp;&nbsp;&nbsp;&nbsp;缩略图</th>
			            	<th>详情</th>
			            	<th width="80">操作</th>
			            </thead>
			            <tbody>
							{x2;tree:$categorys['data'],category,cid}
			            	<tr>
			                    <td class="picture"><a class="ajax" href="?{x2;$_app}-master-category&parent={x2;v:category['catid']}"><img src="{x2;if:v:category['catimg']}{x2;v:category['catimg']}{x2;else}app/core/styles/img/anonymous.png{x2;endif}" alt="" height="60" width="80"/></a></td>
			                    <td>
			                        <p>
			                            <strong>{x2;v:category['catname']}</strong><br/>
			                            ID:{x2;v:category['catid']}<br/>
			                            <em><a class="ajax" href="?{x2;$_app}-master-category&parent={x2;v:category['catid']}">查看子分类</a> 排序：{x2;v:category['catlite']}</em><br/>
			                            {x2;substring:strip_tags(html_entity_decode(v:category['catdes'])),135}
			                        </p>
			                    </td>
			                    <td class="actions">
			                    	<a href="?{x2;$_app}-master-contents&catid={x2;v:category['catid']}" title="查看所属内容"><img src="app/core/styles/img/icons/menu/dark/contacts.png" alt="" /></a>
			                    	<a class="ajax" href="?{x2;$_app}-master-category-edit&parent={x2;$parent}&page={x2;$page}&catid={x2;v:category['catid']}" title="修改分类"><img src="app/core/styles/img/icons/menu/dark/settings.png" alt="" /></a>
			                    	<a class="ajax" href="?{x2;$_app}-master-category-del&parent={x2;$parent}&page={x2;$page}&catid={x2;v:category['catid']}" title="删除分类"><img src="app/core/styles/img/icons/menu/dark/basket.png" alt="" /></a>
			                    </td>
			                </tr>
			                {x2;endtree}
			        	</tbody>
			        </table>
			        <div class="pagination">
			            {x2;$categorys['pages']}
			        </div>
				</div>
				<div id="tab22">
					<form action="?content-master-category-add" method="post">
				        <div class="input">
				            <label for="input1">分类名称：</label>
				            <input type="text" id="input1" name="args[catname]" datatype="userName" needle="needle" msg="您必须输入中英文字符的分类名称">
				        </div>
				        <div class="input">
				            <label for="input2">分类排序：</label>
				            <input type="text" id="input2" name="args[catlite]" value="0">
				        </div>
				        <div class="input">
				            <label>外链地址：</label>
				            <input type="text" name="args[caturl]" value="">
				        </div>
				        <div class="input">
				            <label>使用外链地址：</label>
				            <input type="radio"  name="args[catuseurl]" value="1">使用
				            <input type="radio"  name="args[catuseurl]" value="0" checked>不使用
				            <div class="intro">填写外链地址后，该分类会直接转到外链地址</div>
				        </div>
				        <div class="input">
				            <label for="input3">分类图片：</label>
				            <input type="text" class="uploadimg inline" name="args[catimg]" id="thumb" thumb="true"/>
							<span class="button"><a id="thumb_button"></a></span>
							<div class="intro" id="thumb_msg">&nbsp;</div>
				        </div>
				        <div class="input">
				            <label>发布用户：</label>
				            <input type="text" name="args[catmanager][pubusers]">
				            <div class="intro">填写用户ID，用英文逗号隔开</div>
				        </div>
				        <div class="input">
				            <label>发布用户组：</label>
				            <input type="text" name="args[catmanager][pubgroups]">
				            <div class="intro">填写角色ID，用英文逗号隔开</div>
				        </div>
				        <div class="input">
				            <label>审核用户：</label>
				            <input type="text" name="args[catmanager][passusers]">
				            <div class="intro">填写用户ID，用英文逗号隔开</div>
				        </div>
				        <div class="input">
				            <label>审核用户组：</label>
				            <input type="text" name="args[catmanager][passgroups]">
				            <div class="intro">填写角色ID，用英文逗号隔开</div>
				        </div>
				        <div class="input">
				            <label for="input2">分类模版：</label>
				            <select name="args[cattpl]">
				            	{x2;tree:$tpls,tpl,tid}
				            	<option value="{x2;v:tpl}">{x2;v:tpl}</option>
				            	{x2;endtree}
				            </select>
				        </div>
				        <div class="input textarea">
				            <label for="textarea1">分类简介</label>
		            		<textarea class="juickeditor" name="args[catdes]" rows="7" cols="4"></textarea>
				        </div>
				        <div class="submit">
				            <input type="submit" value=" 添 加 ">
				            <input type="hidden" name="page" value="{x2;$page}">
				            <input type="hidden" name="addcategory" value="1">
				            <input type="hidden" name="args[catparent]" value="{x2;$parent}">
				        </div>
				    </form>
				</div>
		    </div>
		</div>
{x2;if:!$search}
{x2;include:foot}
{x2;endif}