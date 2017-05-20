{x2;include:head}
<body>
<!--导航-->
{x2;include:nav}
<!--主体-->
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
            <div id="exam_paper">
            <form action="?exam-app-exercise-score" id="form1" name="form1" method="post">
            	<h2 class="page_title">
                	<img src="app/exam/styles/image/exam_tit.jpg" alt="考试须知" />
                    <!--分数-->
                    <div id="fenshu">
                        {x2;if:$sessionvars['examsessionscore'] >= 100}
                        <div class="n{x2;eval: echo intval($sessionvars['examsessionscore']/100%10)}"></div>
                        {x2;endif}
                        {x2;if:$sessionvars['examsessionscore'] >= 10}
                        <div class="n{x2;eval: echo intval($sessionvars['examsessionscore']/10%10)}"></div>
                        {x2;endif}
                        <div class="n{x2;eval: echo intval($sessionvars['examsessionscore']%10)}"></div>
                        {x2;if:$sessionvars['examsessionscore']*10%10 > 0}
                        <div class="ndot"></div>
                        <div style="display:none;" class="n{x2;eval: echo intval($sessionvars['examsessionscore']*10%10)}"></div>
                        {x2;endif}
                    </div>
                    <!--分数 结束-->
                  </h2>
       	    	<h1>{x2;$sessionvars['examsession']}</h1>
                <h5>总分：<span class="orange">100</span>分 合格分数线：<span class="orange">{x2;$sessionvars['examsessionscore']}</span>分 考试时间：<span class="orange">{x2;$sessionvars['examsessiontime']}</span>分钟 来源：东奥会计在线</h5>
                {x2;eval: v:oid = 0}
                {x2;tree:$questype,quest,qid}
                {x2;if:$sessionvars['examsessionquestion']['questions'][v:quest['questid']] || $sessionvars['examsessionquestion']['questionrows'][v:quest['questid']]}
                {x2;eval: v:oid++}
                <h4 class="qu_type">{x2;$ols[v:oid]}、{x2;v:quest['questype']}</h4>
                {x2;eval: v:tid = 0}
                {x2;tree:$sessionvars['examsessionquestion']['questions'][v:quest['questid']],question,qnid}
                {x2;eval: v:tid++}
                <div class="qu_content" onmouseover="this.className='qu_content_hover'" onmouseout="this.className='qu_content'">
                	<h3>{x2;v:tid}、{x2;eval: echo html_entity_decode(v:question['question'])}</h3>
                    <ul>
                    	{x2;realhtml:v:question['questionselect']}
                    </ul>
                    <span class="examquestionform" name="formquestion_{x2;v:question['questionid']}" id="formquestion_{x2;v:question['questionid']}" rel="nodo">
                    <div class="qu_option" onmouseover="this.className='qu_option_hover'" onmouseout="this.className='qu_option'">
                        <div class="float_r ml_10{x2;if:$sessionvars['examsessionscorelist'][v:question['questionid']] == 1} answer_icon_r{x2;else} answer_icon_w{x2;endif}"></div>
                        {x2;if:v:quest['questsort']}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:question['questionid']}');">收藏</a>】</span>
                        <span class="font_12 float_r cz">【<a href="javascript:question_error('{x2;v:question['questionid']}');">错题举报</a>】</span>
                        <p class=" float_l">本题答案：</p>
                        <div class="clear"></div>
                        {x2;else}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:question['questionid']}');">收藏</a>】</span>
                        <span class="font_12 float_r cz">【<a href="javascript:question_error('{x2;v:question['questionid']}');">错题举报</a>】</span>
						<div class="option_single" id="radio">
                        	<p class=" float_l">本题答案：</p>
                        </div>
                        <div class="clear"></div>
                        {x2;endif}
                    </div>
                    <div class="answer">
                    	<ul>
                        	<li class="red">【正确答案】{x2;realhtml:v:question['questionanswer']}</li>
                        	<li><span class="blue">【您的答案】</span>{x2;if:is_array($sessionvars['examsessionuseranswer'][v:question['questionid']])}{x2;eval: echo implode('',$sessionvars['examsessionuseranswer'][v:question['questionid']])}{x2;else}{x2;realhtml:$sessionvars['examsessionuseranswer'][v:question['questionid']]}{x2;endif}</li>
                        	<li>【所在章】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        	<li>【知识点】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
                        	<li>【答案解析】</li>
                        	<li class="ml_10">{x2;realhtml:v:question['questiondescribe']}</li>
                        </ul>
                    </div>
                    </span>
                </div>
                {x2;endtree}
                {x2;tree:$sessionvars['examsessionquestion']['questionrows'][v:quest['questid']],questionrow,qrid}
                {x2;eval: v:tid++}
                <div class="qu_content" onmouseover="this.className='qu_content_hover'" onmouseout="this.className='qu_content'">
                	<h3>{x2;v:tid}、{x2;eval: echo html_entity_decode(v:questionrow['qrquestion'])}</h3>
                	{x2;tree:v:questionrow['data'],data,did}
                	<h3>({x2;v:did}){x2;eval: echo html_entity_decode(v:data['question'])}</h3>
                    <ul>
                    	{x2;realhtml:v:data['questionselect']}
                    </ul>
                    <span class="examquestionform" name="formquestion_{x2;v:data['questionid']}" id="formquestion_{x2;v:data['questionid']}" rel="nodo">
                    <div class="qu_option" onmouseover="this.className='qu_option_hover'" onmouseout="this.className='qu_option'">
    					<div class="float_r ml_10{x2;if:$sessionvars['examsessionscorelist'][v:data['questionid']] == 1} answer_icon_r{x2;else} answer_icon_w{x2;endif}"></div>
                        {x2;if:v:quest['questsort']}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
                        <span class="font_12 float_r cz">【<a href="javascript:question_error('{x2;v:data['questionid']}');">错题举报</a>】</span>
                        <p class=" float_l">本题答案：</p>
                        <div class="clear"></div>
                        {x2;else}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
                        <span class="font_12 float_r cz">【<a href="javascript:question_error('{x2;v:data['questionid']}');">错题举报</a>】</span>
						<div class="option_single" id="radio">
                        	<p class=" float_l">本题答案：</p>
                        </div>
                        <div class="clear"></div>
                        {x2;endif}
                    </div>
                    <div class="answer">
                    	<ul>
                        	<li class="red">【正确答案】</li>
                            <li class="ml_10 mb_10">{x2;realhtml:v:data['questionanswer']}</li>
                        	<li class="blue">【您的答案】</li>
                            <li class="ml_10 mb_10">{x2;if:is_array($sessionvars['examsessionuseranswer'][v:data['questionid']])}{x2;eval: echo implode('',$sessionvars['examsessionuseranswer'][v:data['questionid']])}{x2;else}{x2;realhtml:$sessionvars['examsessionuseranswer'][v:data['questionid']]}{x2;endif}</li>
                        	<li>【所在章】{x2;tree:v:questionrow['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        	<li>【知识点】{x2;tree:v:questionrow['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
                        	<li>【答案解析】</li>
                        	<li class="ml_10">{x2;realhtml:v:data['questiondescribe']}</li>
                        </ul>
                    </div>
                    </span>
                    {x2;endtree}
                </div>
                {x2;endtree}
                {x2;endif}
                {x2;endtree}
            </form>
          	</div>
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