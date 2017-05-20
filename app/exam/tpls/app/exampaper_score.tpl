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
  	  	  <div id="result">
            <h2 class="page_title"><img src="app/exam/styles/image/result_tit.jpg" alt="成绩单" /></h2>
            <h1>{x2;$sessionvars['examsession']}</h1>
            <div id="result_box">
            <h3>{x2;$sessionvars['examsessionscore']}分</h3>
            <div id="result_con">
           	  <div class="mb_10"><b class="blue">考试详情：</b></div>
              <p class="mb_10">总分：<b class="orange">{x2;$sessionvars['examsessionsetting']['examsetting']['score']}</b>分 合格分数线：<b class="orange">{x2;$sessionvars['examsessionsetting']['examsetting']['passscore']}</b>分 答卷耗时：<b class="orange">{x2;$sessionvars['examsessiontime']}</b>分钟</p>
                  <table width="100%">
                          <tr>
                            <th>题型</th>
                            <th>总题数</th>
                            <th>答对题数</th>
                            <th>总分</th>
                            <th>得分</th>
                          </tr>
                          {x2;tree:$number,num,nid}
                          {x2;if:v:num}
                          <tr>
                            <td>{x2;$questype[v:key]['questype']}</td>
                            <td>{x2;v:num}</td>
                            <td>{x2;$right[v:key]}</td>
                            <td>{x2;eval: echo number_format(v:num*$sessionvars['examsessionsetting']['examsetting']['questype'][v:key]['score'],1)}</td>
                            <td>{x2;eval: echo number_format($score[v:key],1)}</td>
                          </tr>
                          {x2;endif}
                          {x2;endtree}
                          <tr>
                            <td colspan="5" align="left">本次考试共<b class="orange">{x2;$allnumber}</b>道题，总分<b class="orange">{x2;$sessionvars['examsessionsetting']['examsetting']['score']}</b>分，您做对<b class="orange">{x2;$allright}</b>道题，得到<b class="orange">{x2;$sessionvars['examsessionscore']}</b>分</td>
                          </tr>
                       </table>
                       <div id="result_btn"><a href="?exam-app-exampaper-view">查看答案和解析</a><a href="index.php?exam-app-record&ehtype=1">进入我的错题</a></div>
                 </div>
            </div>
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