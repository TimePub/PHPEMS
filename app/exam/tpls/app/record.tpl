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
  	  	  <div id="answer_note">
                <h2 class="page_title">
       	    	  <ul id="note_type">
                    	<li><a href="?exam-app-record"{x2;if:$ehtype == 0} class="on"{x2;endif}>强化训练</a></li>
                    	<li><a href="?exam-app-record&ehtype=1"{x2;if:$ehtype == 1} class="on"{x2;endif}>随机考试</a></li>
                    	<li><a href="?exam-app-record&ehtype=2"{x2;if:$ehtype == 2} class="on"{x2;endif}>模拟考试</a></li>
                    </ul><img src="app/exam/styles/image/wrong_note_tit.jpg" alt="答题记录" /></h2>
	   			{x2;if:$ehtype == 0}
	   			<div id="note_type_tit"><span class="font_12 float_r"><span class="red">提示：</span>我的错题中的强化训练最多记录最新20条信息。</span><b>强化训练</b></div>
				{x2;elseif:$ehtype == 1}
				<div id="note_type_tit"><span class="font_12 float_r">您一共完成了<b class="red">{x2;$exams['number']}</b>次考试， 平均分为：<b class="red">{x2;$avgscore}</b>分 继续努力吧！</span><b>随机考试</b></div>
				{x2;elseif:$ehtype == 2}
				<div id="note_type_tit"><span class="font_12 float_r">您一共完成了<b class="red">{x2;$exams['number']}</b>次考试， 平均分为：<b class="red">{x2;$avgscore}</b>分 继续努力吧！</span><b>模拟考试</b></div>
				{x2;endif}
				<table width="100%">
                        <tr>
                          <th width="280">答题记录</th>
                          <th>答题时间</th>
                          <th>错题数量</th>
                          <th>查看错题</th>
                          <th>删除记录</th>
                        </tr>
                        {x2;tree:$exams['data'],exam,eid}
                        <tr>
                          <td align="left">{x2;v:exam['ehexam']}</td>
                          <td>{x2;date:v:exam['ehstarttime'],'Y-m-d'}</td>
                          <td><b class="red">{x2;v:exam['errornumber']}</b></td>
                          <td class="mani_btn"><a href="?exam-app-record-wrongs&ehid={x2;v:exam['ehid']}">错题</a></td>
                          <td class="mani_btn">
                            <a href="javascript:;" onclick="javascript:confdelinfo({x2;v:exam['ehid']})">删除</a>
                          </td>
                        </tr>
                        {x2;endtree}
                     </table>
                     {x2;if:$exams['pages'] && $ehtype}
					<div class="pagination pagination-right">
			            <ul>{x2;$exams['pages']}</ul>
			        </div>
                     {x2;endif}
            </div>
    	</div>
    	<div class="bor_bottom"></div>
    </div>
	<!--主体右侧 结束-->
	<!--尾部-->
    {x2;include:foot}
    <!--尾部 结束-->
</div>
<script>
var delhistory = function(ehid)
{
 	$.get("?exam-app-history-del&ehid="+ehid+"&rand"+Math.random(),function(data){window.location.reload();});
}
var confdelinfo = function(url)
{
	art.dialog({
		ok: function(){delhistory(url);},
		okval: '确定',
		title:'删除答题记录',
		cancel: true,
		cancelval: '取消',
		content: '您确定要删除这个记录吗？'
	});
}
</script>
</body>
</html>