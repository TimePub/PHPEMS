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
				<h3 class="themetitle">
					<b class="icon-eye-open"></b> {x2;$cat['catname']}
				</h3>
				<p>{x2;realhtml:$cat['catdes']}</p>
			</div>
			<div class="span3">
				<h3 class="themetitle">
					<b class="icon-calendar"></b> 分类列表
				</h3>
				{x2;if:$catchildren}
				{x2;tree:$catchildren,cat,cid}
				<div class="media">
					{x2;if:v:cat['catimg']}
					<a class="pull-left" href="index.php?content-app-category&catid={x2;v:cat['catid']}"> <img class="media-object" src="{x2;v:cat['catimg']}"> </a>
					{x2;endif}
					<div class="media-body">
						<h3 class="media-heading"><a href="index.php?content-app-category&catid={x2;v:cat['catid']}">{x2;v:cat['catname']}</a></h3>
						{x2;realsubstring:v:cat['catdes'],120}
					</div>
				</div>
				{x2;endtree}
				{x2;else}
				{x2;tree:$catbrother,cat,cid}
				<div class="media">
					{x2;if:v:cat['catimg']}
					<a class="pull-left" href="index.php?content-app-category&catid={x2;v:cat['catid']}"> <img class="media-object" src="{x2;v:cat['catimg']}"> </a>
					{x2;endif}
					<div class="media-body">
						<h3 class="media-heading"><a href="index.php?content-app-category&catid={x2;v:cat['catid']}">{x2;v:cat['catname']}</a></h3>
						{x2;realsubstring:v:cat['catdes'],120}
					</div>
				</div>
				{x2;endtree}
				{x2;endif}
			</div>
		</div>
	</div>
	<div class="row-fluid">&nbsp;</div>
{x2;include:foot}