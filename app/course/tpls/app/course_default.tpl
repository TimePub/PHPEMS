{x2;if:!$userhash}
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
						<li><a href="index.php?course">课程</a></li>
						{x2;tree:$catbread,cb,cbid}
						<li><a href="index.php?course-app-category&catid={x2;v:cb['catid']}">{x2;v:cb['catname']}</a></li>
						{x2;endtree}
						<li class="active">{x2;$cat['catname']}</li>
					</ol>
				</div>
			</div>
		</div>
		<div class="main" id="datacontent">
{x2;endif}
			<div class="col-xs-7" style="padding-left:0px;position:relative;">
				<div class="box itembox" style="height:495px;width:685px;top:0px;" data-spy="affix" data-offset-top="245">
					<video style="margin-top:20px;" controls="true" width="100%" height="450">
						<source src="{x2;$content['course_files']}" type='video/mp4' />
					</video>
				</div>
			</div>
			<div class="col-xs-5 pull-right" style="padding-right:0px;">
				<div class="box itembox" style="padding-top:20px;">
					<h4 class="title">{x2;$course['cstitle']}</h4>
					{x2;realhtml:$course['csdescribe']}
				</div>
				{x2;tree:$contents['data'],content,cid}
				<div class="box itembox" style="padding-top:20px;">
					<div class="col-xs-6">
						<a target="datacontent" href="index.php?course-app-course&page={x2;$page}&csid={x2;$course['csid']}&contentid={x2;v:content['courseid']}" class="thumbnail pull-left ajax">
							<img src="{x2;v:content['coursethumb']}" alt="" width="100%">
						</a>
					</div>
					<div class="col-xs-6">
						<a target="datacontent" href="index.php?course-app-course&page={x2;$page}&csid={x2;$course['csid']}&contentid={x2;v:content['courseid']}" class="ajax"><h4 class="title">{x2;v:content['coursetitle']}</h4></a>
						<p>{x2;realhtml:v:content['coursedescribe']}</p>
						<p>
							<span class="pull-right">
								{x2;if:$content['courseid'] == v:content['courseid']}
								<a href="javascript:;" style="color:green;"><em class="glyphicon glyphicon-play"></em> 播放中</a>
								{x2;endif}
							</span>
						</p>
					</div>
				</div>
				{x2;endtree}
				<ul class="pagination pagination-right">{x2;$contents['pages']}</ul>
			</div>
{x2;if:!$userhash}
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>
{x2;endif}