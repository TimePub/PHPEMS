{x2;tree:$menu,menu,mid}
<h3 class="f14"><span title="展开与收缩" class="switchs cu"></span>{x2;v:menu['name']}</h3>
{x2;eval: v:tkey = v:key}
{x2;if:v:menu['menu']}
<ul style="display:block;">
{x2;tree:v:menu['menu'],cmenu,cmid}
<li class="sub_menu" id="_MP_{x2;v:tkey}_{x2;v:cmid}"><a style="outline:none;" hidefocus="true" href="javascript:_MP('_{x2;v:tkey}_{x2;v:cmid}','{x2;v:cmenu['url']}');">{x2;v:cmenu['name']}</a></li>
{x2;endtree}
</ul>
{x2;endif}
{x2;endtree}