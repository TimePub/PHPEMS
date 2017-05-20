{x2;include:header}
<body>
{x2;include:nav}
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main">
			<div class="box itembox" style="margin-bottom:0px;">
				<div class="col-xs-12">
					<ol class="breadcrumb">
					  <li><a href="index.php">首页</a></li>
					  <li><a href="index.php?exam-app">考试</a></li>
					  <li><a href="index.php?exam-app-basics">{x2;$data['currentbasic']['basic']}</a></li>
					  <li><a href="index.php?exam-app-lesson">课后练习</a></li>
					  <li class="active">{x2;$knows['knows']}（{x2;$questype['questype']}）</li>
					</ol>
				</div>
			</div>
			<div class="box itembox" id="questionpanel" style="padding-top:20px;">
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
<script type="text/javascript">
$(document).ready(function(){
	submitAjax({"url":"index.php?exam-app-lesson-ajax-questions","target":"questionpanel"});
});
</script>
</body>
</html>