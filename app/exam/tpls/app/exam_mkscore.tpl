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
            <form action="?exam-app-exam-makescore" method="post" id="form1" name="form1">
            <div id="exam_paper">
            	<h2 class="page_title">
                	<img src="app/exam/styles/image/simulation_tit.jpg" alt="查看答案" />
                  </h2>
       	    	<h1>{x2;$sessionvars['examsession']}</h1>
                <div id="self_explain">
                	<ul>
                    	<li><b>阅卷规则</b></li>
                    	<li>1、客观题系统将自动核对学员答案。</li>
                    	<li>2、主观题请参照系统给出的答案自行核对，并给出分数。</li>
                    	<li>3、自行评分完毕后请单击“自行判卷无误，提交”按钮，将即刻为您生成本次测验的成绩单。</li>
                    </ul>
                    <p>以下题为主观题请参照正确答案后自行给出分数</p>
                </div>
                {x2;eval: v:oid = 0}
                {x2;tree:$questype,quest,qid}
                {x2;if:v:quest['questsort']}
                {x2;if:$sessionvars['examsessionquestion']['questions'][v:quest['questid']] || $sessionvars['examsessionquestion']['questionrows'][v:quest['questid']]}
                {x2;eval: v:oid++}
                <h4 class="qu_type">{x2;$ols[v:oid]}、{x2;v:quest['questype']}（{x2;$sessionvars['examsessionsetting']['questype'][v:quest['questid']]['describe']}）</h4>
                {x2;eval: v:tid = 0}
                {x2;tree:$sessionvars['examsessionquestion']['questions'][v:quest['questid']],question,qnid}
                {x2;eval: v:tid++}
                <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'">
                	<h3><span class="float_l">{x2;v:tid}、</span>{x2;eval: echo html_entity_decode(v:question['question'])}</h3>
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        <span class="font_12 float_r">【<a href="javascript:favorquestion('{x2;v:question['questionid']}');">收藏</a>】</span>
                        <p class="float_l">查看参考答案：</p>
                        <div class="clear"></div>
                    </div>
                    <div class="answer">
                    	<ul>
                        	<li class="red">【正确答案】</li>
                            <li class="ml_10 mb_10">{x2;realhtml:v:question['questionanswer']}</li>
                        	<li class="blue">【您的答案】</li>
                            <li class="ml_10 mb_10">{x2;realhtml:$sessionvars['examsessionuseranswer'][v:question['questionid']]}</li>
                        	<li>【所在章】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        	<li>【知识点】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
                        	<li>【答案解析】</li>
                        	<li class="ml_10">{x2;realhtml:v:question['questiondescribe']}</li>
                        </ul>
                    </div>
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        <div id="self_option">【请根据参考答案给出分值】<input type="text" name="score[{x2;v:question['questionid']}]" value=""><span class="ml_10 red font_12">提示：本题共{x2;$sessionvars['examsessionsetting']['examsetting']['questype'][v:quest['questid']]['score']}分，可输入0.5的倍数。</span></div>
                    </div>
                </div>
                {x2;endtree}
                {x2;tree:$sessionvars['examsessionquestion']['questionrows'][v:quest['questid']],questionrow,qrid}
                {x2;eval: v:tid++}
                <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'">
                	<h3>{x2;v:tid}、{x2;eval: echo html_entity_decode(v:questionrow['qrquestion'])}</h3>
                	{x2;tree:v:questionrow['data'],data,did}
                	<h3>({x2;v:did}){x2;eval: echo html_entity_decode(v:data['question'])}</h3>
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        <span class="font_12 float_r">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
                        <p class=" float_l">查看参考答案：</p>
                        <div class="clear"></div>
                    </div>
                    <div class="answer">
                    	<ul>
                        	<li class="red">【正确答案】</li>
                            <li class="ml_10 mb_10">{x2;realhtml:v:data['questionanswer']}</li>
                        	<li class="blue">【您的答案】</li>
                            <li class="ml_10 mb_10">{x2;realhtml:$sessionvars['examsessionuseranswer'][v:data['questionid']]}</li>
                        	<li>【所在章】{x2;tree:v:questionrow['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        	<li>【知识点】{x2;tree:v:questionrow['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
                        	<li>【答案解析】</li>
                        	<li class="ml_10">{x2;realhtml:v:data['questiondescribe']}</li>
                        </ul>
                    </div>
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        <div id="self_option">【请根据参考答案给出分值】<input type="text" name="score[{x2;v:data['questionid']}]" value=""><span class="ml_10 red font_12">提示：本题共{x2;$sessionvars['examsessionsetting']['examsetting']['questype'][v:quest['questid']]['score']}分，可输入0.5的倍数。</span></div>
                    </div>
                    {x2;endtree}
                </div>
                {x2;endtree}
                {x2;endif}
                {x2;endif}
                {x2;endtree}
                <div id="self_option_btn"><input type="hidden" value="1" name="makescore"/><input type="submit" value="自行判分完毕，提交分数"/></div>
          </div>
          </form>
    	</div>
    	<div class="bor_bottom"></div>
    </div>
	<!--主体右侧 结束-->
	<!--尾部-->
    {x2;include:foot}
    <!--尾部 结束-->
    <!--返回顶部-->
    <div id="roll">
      <div id="roll_top"></div>
    </div>
    <!--返回顶部 结束-->
</div>
<script type="text/javascript">
$(document).ready(function(){
		$('#roll').hide();
		$(window).scroll(function() {
			if($(window).scrollTop() >= 100){
				$('#roll').fadeIn(400);
		    }
		    else
		    {
		    $('#roll').fadeOut(200);
		    }
		 });
		 $('#roll_top').click(function(){$('html,body').animate({scrollTop: '0px'}, 800);});
	});
</script>
</body>
</html>