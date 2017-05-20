{x2;if:!$userhash}
{x2;include:head}
<body>
<!--导航-->
{x2;include:nav}
<div id="main">
	<!--主体右侧 -->
	<div id="right_970" class="right_970">
    	<div class="bor_top"></div>
    	<div class="bor_mid">
            <div class="container-fluid" id="datacontent">
{x2;endif}
				<div class="row-fluid">
					<div class="span12">
			            <ul class="thumbnails">
							<li class="span3">
								<div class="thumbnail">
									<img alt="300x200" src="app/exam/styles/image/paper.png" style="width:160px;"/>
									<div class="caption">
										<p class="text-center">
											<a class="btn btn-warning" href="index.php?exam-app-basics-open" title="开通新考场">开通新考场</a>
										</p>
									</div>
								</div>
							</li>
						</ul>
						<div id="notice">
			            	<h2 class="page_title"><img src="app/exam/styles/image/exam_opened_basic.jpg" alt="我的考场" /></h2>
			            </div>
			            <ul class="thumbnails">
							{x2;tree:$basics,basic,bid}
							<li class="span3">
								<div class="thumbnail">
									<img alt="300x200" src="{x2;if:v:basic['basicthumb']}{x2;v:basic['basicthumb']}{x2;else}app/exam/styles/image/paper.png{x2;endif}" style="width:160px;"/>
									<div class="caption">
										<p class="text-center">
											<a class="ajax btn btn-primary" href="index.php?{x2;$_app}-app-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" title="{x2;v:basic['basic']}">{x2;substring:v:basic['basic'],28}</a>
										</p>
									</div>
								</div>
							</li>
							{x2;if:v:bid % 4 == 0}
							</ul>
							<ul class="thumbnails">
							{x2;endif}
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