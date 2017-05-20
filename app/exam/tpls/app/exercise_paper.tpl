{x2;include:head}
<body onbeforeunload="javascript:saveanswer(false);">
<!--导航-->
{x2;include:nav}
<div id="main">
	<!--主体左侧-->
	{x2;eval: $nouseleft = 1}
	{x2;include:left}
	<!--主体左侧 结束-->
	<!--主体右侧 -->
	<div id="right_760" class="right_970">
    	{x2;include:bread}
    	<div class="bor_top"></div>
    	<div class="bor_mid">
    		<div id="hide_left"><a href="javascript:pr()"></a></div>
            <div id="exam_paper">
            <form action="index.php?exam-app-exercise-score" id="form1" name="form1" method="post">
            <!-- float start-->
            <div id="float" class="float_div1">
            	<h2 class="page_title" style="line-height:0.5em;">
                	<ul id="func_list">
               	  	    <li id="show_menu" class="menu">
               	  	      <div class="menu-hd"><span id="show-current"><a class="collapsible" href="#show_sz">显示设置</a></span></div>
               	  	      <div id="show_sz" class="menu-bd" style="display:none;">
               	  	        <dl>
               	  	          <dd><a href="#show_dt" onClick="javascript:initquestion();">单题显示</a></dd>
               	  	          <dd><a href="#show_tx" onClick="javascript:inittype();">题型显示</a></dd>
               	  	          <dd><a href="#show_zj" onClick="javascript:initpaper();">整卷显示</a></dd>
           	  	            </dl>
           	  	          </div>
       	  	      	  	</li>
                  	</ul><img src="app/exam/styles/image/qianghuaxunlian_tit.jpg" alt="强化训练" />
                  	<span id="time_top">考试剩余时间：<b><span id="timer_h">00</span>：<span id="timer_m">00</span>：<span id="timer_s">00</span></b></span>
                  </h2>
                </div>
				<!-- float end-->
       	    	<h1>{x2;$sessionvars['examsession']}</h1>
                <h5>总分：<span class="orange">100</span>分 合格分数线：<span class="orange">60</span>分 考试时间：<span class="orange">{x2;$sessionvars['examsessiontime']}</span>分钟 来源：东奥会计在线</h5>
                {x2;eval: v:oid = 0}
                {x2;tree:$questype,quest,qid}
                {x2;if:$sessionvars['examsessionquestion']['questions'][v:quest['questid']] || $sessionvars['examsessionquestion']['questionrows'][v:quest['questid']]}
                {x2;eval: v:oid++}
                <span class="questypearea" id="qtarea_{x2;v:quest['questid']}">
                <h4 class="qu_type">{x2;$ols[v:oid]}、{x2;v:quest['questype']}</h4>
                {x2;eval: v:tid = 0}
                {x2;tree:$sessionvars['examsessionquestion']['questions'][v:quest['questid']],question,qnid}
                {x2;eval: v:tid++}
                <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'" id="qtion_{x2;v:question['questionid']}">
                	<h3><span class="float_l">{x2;v:tid}</span>、{x2;eval: echo html_entity_decode(v:question['question'])}</h3>
                    <div>
						{x2;realhtml:v:question['questionselect']}
                    </div>
                    <span class="examquestionform" name="formquestion_{x2;v:question['questionid']}" id="formquestion_{x2;v:question['questionid']}" rel="nodo">
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        {x2;if:v:quest['questsort']}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:question['questionid']}');">收藏</a>】</span>
                        <p class=" float_l">本题答案：</p>
                        <div id="editor" class="clear">
                        	{x2;eval: $dataid = v:question['questionid']}
                        	{x2;include:plugin_editor}
                        </div>
                        {x2;else}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:question['questionid']}');">收藏</a>】</span>
                        <div class="option_single" id="radio">
                           {x2;if:v:quest['questchoice'] == 1 || v:quest['questchoice'] == 4}
		                        {x2;tree:$selectorder,so,sid}
		                        {x2;if:v:key == v:question['questionselectnumber']}
		                        {x2;eval: break;}
		                        {x2;endif}
		                        <label class="radio inline">{x2;v:so} <input type="radio" name="question[{x2;v:question['questionid']}]" rel="{x2;v:question['questionid']}" value="{x2;v:so}" {x2;if:v:so == $sessionvars['examsessionuseranswer'][v:question['questionid']]}checked{x2;endif}/></label>&nbsp;&nbsp;
		                        {x2;endtree}
	                        {x2;else}
		                        {x2;tree:$selectorder,so,sid}
		                        {x2;if:v:key >= v:question['questionselectnumber']}
		                        {x2;eval: break;}
		                        {x2;endif}
		                        <label class="checkbox inline">{x2;v:so} <input type="checkbox" name="question[{x2;v:question['questionid']}][]" rel="{x2;v:question['questionid']}" value="{x2;v:so}" {x2;if:in_array(v:so,$sessionvars['examsessionuseranswer'][v:question['questionid']])}checked{x2;endif}/></label>&nbsp;&nbsp;
		                        {x2;endtree}
	                        {x2;endif}


                         </div>
                        <div class="clear"></div>
                        {x2;endif}
                    </div>
                    </span>
                    <ul id="qu_type_next" class="clear" name="qbar" style="margin:10px auto;display:none">
						<li><a href="javascript:;" onClick="javascript:prevquestion();">上一题</a></li>
	                	<li><a href="javascript:;" onClick="javascript:nextquestion();">下一题</a></li>
                	</ul>
                </div>
                {x2;endtree}
                {x2;tree:$sessionvars['examsessionquestion']['questionrows'][v:quest['questid']],questionrow,qrid}
                {x2;eval: v:tid++}
                <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'" id="qrtion_{x2;v:questionrow['qrid']}">
                	<h3><span class="float_l">{x2;v:tid}、</span>{x2;eval: echo html_entity_decode(v:questionrow['qrquestion'])}</h3>
                	{x2;tree:v:questionrow['data'],data,did}
                	<h3>({x2;v:did}){x2;eval: echo html_entity_decode(v:data['question'])}</h3>
                    <div>
                    	{x2;realhtml:v:data['questionselect']}
                    </div>
                    <span class="examquestionform" name="formquestion_{x2;v:data['questionid']}" id="formquestion_{x2;v:data['questionid']}" rel="nodo">
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        {x2;if:v:quest['questsort']}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
                        <p class=" float_l">本题答案：</p>
                        <div id="editor" class="clear">
                        	{x2;eval: $dataid = v:data['questionid']}
                        	{x2;include:plugin_editor}
                        </div>
                        {x2;else}
                        <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
                        <div class="option_single" id="radio">
                            {x2;if:v:quest['questchoice'] == 1 || v:quest['questchoice'] == 4}
                            {x2;tree:$selectorder,so,sid}
                            {x2;if:v:key == v:data['questionselectnumber']}
                            {x2;eval: break;}
                            {x2;endif}
                            <label class="radio inline"><input autocomplete="off" type="radio" name="question[{x2;v:data['questionid']}]" value="{x2;v:so}" />{x2;v:so}</label>
                            {x2;endtree}
                            {x2;else}
                            {x2;tree:$selectorder,so,sid}
                            {x2;if:v:key >= v:data['questionselectnumber']}
                            {x2;eval: break;}
                            {x2;endif}
                            <label class="checkbox inline"><input autocomplete="off" type="checkbox" name="question[{x2;v:data['questionid']}][{x2;v:key}]" value="{x2;v:so}" />{x2;v:so}</label>
                            {x2;endtree}
                            {x2;endif}
                            <script type="text/javascript">{x2;if:v:quest['questchoice'] == 2 || v:quest['questchoice'] == 3}completeAnswers('question[{x2;v:data['questionid']}][]','{x2;eval: echo implode('',$sessionvars['examsessionuseranswer'][v:data['questionid']]);}');{x2;else}completeAnswers('question[{x2;v:data['questionid']}]','{x2;$sessionvars['examsessionuseranswer'][v:data['questionid']]}');{x2;endif}</script>
                        </div>
                        <div class="clear"></div>
                        {x2;endif}
                    </div>
                    </span>
                    {x2;endtree}
                    <ul id="qu_type_next" class="clear" name="qbar" style="margin:10px auto;display:none">
						<li><a href="javascript:;" onClick="javascript:prevquestion();">上一题</a></li>
	                	<li><a href="javascript:;" onClick="javascript:nextquestion();">下一题</a></li>
                	</ul>
                </div>
                {x2;endtree}
                <ul id="qu_type_next" class="clear" name="qtbar" style="margin:10px auto;display:none">
					<li><a href="javascript:;" onClick="javascript:prevtype();">上一题型</a></li>
                	<li><a href="javascript:;" onClick="javascript:nexttype();">下一题型</a></li>
                </ul>
            	</span>
                {x2;endif}
                {x2;endtree}
                <div id="amount">全卷已做 <b class="orange" id="yesdonumber">{x2;$donumber}</b> 题 / 共<b class="orange" id="allquestionnumber">0</b>题 剩余 <b class="orange" id="nodonumber">0</b> 题未作答</div>
                <div id="btn_exam_paper"><input type="hidden" name="insertscore" value="1"/><input type="button" value="" onClick="javascript:subpaper();"/></div>
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
    <!--自动保存提示-->
    <div id="save_prompt">
    	<h4>自动保存提示</h4>
        <p>系统将每隔<b class="red">5分钟</b>自动保存试卷及答案，答题过程中请勿刷新页面。<br />上次保存时间：<span id="lastsavetime">{x2;date:TIME,'H:i:s'}</span></p>
    </div>
    <!--自动保存提示 结束-->
</div>
<script type="text/javascript">
$(document).ready(function(){
		$.get('index.php?exam-app-index-ajax-lefttime&rand'+Math.random(),function(data){
			var setting = {
				time:{x2;$sessionvars['examsessiontime']},
				hbox:$("#timer_h"),
				mbox:$("#timer_m"),
				sbox:$("#timer_s"),
				finish:function(){$('#form1').submit();}
			}
			setting.lefttime = parseInt(data);
			countdown(setting);
		});

		$('#roll').hide();
		$('#allquestionnumber').html($('.examquestionform').length);
		$('#nodonumber').html($('#allquestionnumber').html() - $('#yesdonumber').html());
		common();
		$(":input").bind('blur',recordanswer);
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
		 recordanswer();
	});
function recordanswer(){
    var yesdonumber = 0;
    $(".qu_option").each(function(){
    	var _i = $("input",this);
    	for(i=0;i< _i.length;i++)
    	{
    		if($(_i.get(i)).attr('checked'))
    		{
    			yesdonumber++;
    			return ;
    		}
    	}
    	var _m = $("textarea",this);
    	if(_m.length == 1)
    	{
    		if(_m.val() && _m.val() != '')yesdonumber++;
    	}
    	else
    	{
    		_m.each(function(){if($(this).val() && $(this).val() != '')yesdonumber++;})
    	}
    });
    $('#yesdonumber').html(yesdonumber);
    $('#nodonumber').html(parseInt($('#allquestionnumber').html()) - parseInt($('#yesdonumber').html()));
}
var subpaper = function()
{
	$(".exameditors").each(function(){$(this).data('daeditor').save();});
	art.dialog({lock:true,resize:false,width:320,height:150,title:'交卷提醒',ok:function(){$('#form1').submit();},okval:'交卷',cancel:true,cancelval:'取消',content:'您确认要交卷吗？'});
}
function saveanswer(){
	var params = $(':input').serialize();
     $.ajax({
       url:'index.php?exam-app-exercise-ajax-saveUserAnswer',
       async:false,
       type:'post',
       dataType:'json',
       data:params
     });
}
</script>
<script type="text/javascript" src="app/exam/styles/js/paperview.js"></script>
</body>
</html>