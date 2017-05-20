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
            	<h2 class="page_title"><img src="app/exam/styles/image/exam_opened_basic.jpg" alt="开通考场" /><a class="btn" href="index.php?exam-app-basics-open" style="margin-left:18px;" title="添加新考场"><em class="icon-plus"></em></a></h2>
            </div>
            <div class="container-fluid" id="datacontent">
{x2;endif}
				<div class="row-fluid">
					<div class="span12">
			            <ul class="thumbnails">
							{x2;tree:$basics,basic,bid}
							<li class="span4" style="margin:0.25em;">
								<div class="thumbnail">
									<img alt="300x200" src="app/exam/styles/image/paper.png" style="width:160px;"/>
									<div class="caption">
										<p class="text-center">
											<a class="btn{x2;if:$data['currentbasic']['basicid'] != v:basic['basicid']} btn-primary{x2;endif}" href="javascript:;" onclick="javascript:$.get('?{x2;$_app}-app-index-setCurrentBasic&basicid={x2;v:basic['basicid']}&'+Math.random(),function(data){window.location.reload();});" title="{x2;v:basic['basic']}">{x2;substring:v:basic['basic'],28}</a>
										</p>
									</div>
								</div>
							</li>
							{x2;endtree}
						</ul>
					</div>
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