{x2;include:header}
<div class="container-fluid">
	{x2;include:nav}
	<div class="row-fluid">&nbsp;</div>
	<div class="row-fluid">
		<div class="containbox">
			<div class="span12">
				<ul class="breadcrumb">
					<li><a href="index.php">主页</a> <span class="divider">/</span></li>
					{x2;tree:$catbread,cb,cbid}
					<li><a href="index.php?content-app-category&catid={x2;v:cb['catid']}">{x2;v:cb['catname']}</a> <span class="divider">/</span></li>
					{x2;endtree}
					<li class="active">{x2;$cat['catname']}</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="containbox">
			<div class="span9">
				<h3 class="themetitle text-center">
					{x2;$content['contenttitle']}
				</h3>
				<p class="text-center">{x2;date:$content['contentinputtime'],'Y-m-d'}</p>
				{x2;realhtml:$content['contenttext']}
			</div>
			<div class="span3">
				<h3 class="themetitle">
					<b class="icon-calendar"></b> 相关内容
				</h3>
				{x2;tree:$nearContent['pre'],content,cid}
				<div class="media">
					{x2;if:v:content['contentthumb']}
					<a class="pull-left" href="index.php?content-app-content&contentid={x2;v:content['contentid']}"> <img class="media-object" src="{x2;v:content['contentthumb']}"> </a>
					{x2;endif}
					<div class="media-body">
						<h3 class="media-heading"><a href="index.php?content-app-content&contentid={x2;v:content['contentid']}">{x2;v:content['contenttitle']}</a></h3>
						{x2;v:content['contentdescribe']}
					</div>
				</div>
				{x2;endtree}
				{x2;tree:$nearContent['next'],content,cid}
				<div class="media">
					{x2;if:v:content['contentthumb']}
					<a class="pull-left" href="index.php?content-app-content&contentid={x2;v:content['contentid']}"> <img class="media-object" src="{x2;v:content['contentthumb']}"> </a>
					{x2;endif}
					<div class="media-body">
						<h3 class="media-heading"><a href="index.php?content-app-content&contentid={x2;v:content['contentid']}">{x2;v:content['contenttitle']}</a></h3>
						{x2;v:content['contentdescribe']}
					</div>
				</div>
				{x2;endtree}
			</div>
		</div>
	</div>
	<div class="row-fluid">&nbsp;</div>
{x2;include:foot}