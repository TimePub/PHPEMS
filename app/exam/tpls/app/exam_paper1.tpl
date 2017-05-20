{x2;include:head}
<body style="overflow:visible;" onbeforeunload="javascript:saveanswer(false);">
<link media="all" rel="stylesheet" href="app/exam/styles/assets/css/item.css" type="text/css">
<link rel="stylesheet" type="text/css" href="app/exam/styles/assets/css/site.css">
<link rel="stylesheet" href="app/exam/styles/assets/js/mathquill/mathquill.css" type="text/css">
<script type="text/javascript" src="app/exam/styles/assets/js/mathquill/mathquill.min.js"></script>
<script type="text/javascript" src="app/exam/styles/assets/js/editor.js"></script>
<style type="text/css">
.toolbar .btns {
    float: right;
}
.toolbar .btns span {
    border-left: 1px dotted #CCCCCC;
    cursor: pointer;
    margin-left: 8px;
    padding-left: 8px;
}
</style>
<!--导航-->
{x2;include:nav}
<!--头部-->
<div id="head">
	<div id="banner"><img src="app/exam/styles/image/head_banner.jpg" border="0" usemap="#Map" longdesc="注册会计师机考模拟系统" />
      <map name="Map" id="Map">
        <area shape="rect" coords="20,25,181,75" href="http://www.dongao.com/" title="东奥会计在线" />
      </map>
	</div>
</div>
<!--主体-->
<div id="main">
	<!--主体左侧-->
	{x2;include:left}
	<!--主体左侧 结束-->
	<!--主体右侧 -->
	<div id="right_760" class="right_970">
    	{x2;include:bread}
    	<div class="bor_top"></div>
    	<div class="bor_mid">
    		<div id="hide_left"><a href="javascript:pr()"></a></div>
    		<form action="?exam-app-exam-subpaper" method="post" id="form1" name="form1">
            <div id="exam_paper">
            	<h2 class="page_title">
                	<ul id="func_list">
               	  	    <li><a id="showCalc" href="javascript:void(0)">计算器</a></li>
               	  	    <li id="anew_menu" class="menu">
               	  	      <div class="menu-hd"><span id="anew-current"><a href="?exam-app-exam">重新抽卷</a></span></div>
           	  	      	</li>
                  	</ul><img src="app/exam/styles/image/simulation_tit.jpg" alt="模拟机考" />
                    <span id="time_top">考试剩余时间：<b><span id="timer_h">00</span>：<span id="timer_m">00</span>：<span id="timer_s">00</span></b></span>
                  </h2>
       	    	<h1>{x2;$sessionvars['examsession']}</h1>
                <h5>总分：<span class="orange">{x2;$sessionvars['examsessionsetting']['score']}</span>分 合格分数线：<span class="orange">{x2;$sessionvars['examsessionsetting']['passscore']}</span>分 考试时间：<span class="orange">{x2;$sessionvars['examsessionsetting']['examtime']}</span>分钟 来源：{x2;$sessionvars['examsessionsetting']['comfrom']}</h5>
                <ul id="qu_type_btn" style="width:450px;display:none;">
                	<li><a href="" class="on">单项选择题（0/10）</a></li>
                	<li><a href="">多项选择题（0/12）</a></li>
                	<li><a href="">判断题（0/10）</a></li>
                </ul>
                <h4 class="qu_type">{x2;$ols[$o]}、{x2;$questype[$cquestype]['questype']}<span>（{x2;$sessionvars['examsessionsetting']['questype'][$cquestype]['describe']}。）</span></h4>
                <div id="data_area" class="mb_10">
                	<div class="hd"><span class="float_r font_12"><a href=""><i class="icon_copy"></i>复制</a><a href=""><i class="icon_mark"></i>标记</a><a href=""><i class="icon_mark_c"></i>取消标记</a><a href=""><i class="icon_zoomin"></i>放大窗口</a></span><b>资料区</b></div>
                    <div class="bd">
                    {x2;$questionid}、
                    {x2;if:$currentquestion['type']}
                    	{x2;realhtml:$currentquestion['question']['qrquestion']}
                    {x2;else}
                    	{x2;realhtml:$currentquestion['question']['question']}
                    {x2;endif}
                    </div>
                </div>
                {x2;if:$currentquestion['type']}
                {x2;if:$questype[$currentquestion['question']['qrtype']]['questsort']}
                <div id="data_que">
                	<ul>
                    	{x2;tree:$currentquestion['question']['data'],data,did}
                    	<li id="yq{x2;v:did}"{x2;if:v:did == 1} class="up"{x2;endif}><a onClick="setTab('yq',{x2;v:did},20)">要求{x2;v:did}</a></li>
                    	{x2;endtree}
                    </ul>
                    <div class="conbox clear">
                    {x2;tree:$currentquestion['question']['data'],data,did}
                   	  	<div id="tag_yq_{x2;v:did}"{x2;if:v:did > 1} style="display:none;"{x2;endif}>
                        	<p>
                   	  			{x2;realhtml:v:data['question']}
                   	  		</p>
                        	{x2;eval: $dataid = v:data['questionid']}
                        	{x2;include:plugin_editor}
                   	 	</div>
                   	{x2;endtree}
                    </div>
              </div>
              {x2;else}
              {x2;tree:$currentquestion['question']['data'],data,did}
              <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'">
                	<h3><span class="float_l">{x2;v:did}、</span>{x2;realhtml:v:data['question']}</h3>
                    <div>
                    	{x2;realhtml:v:data['questionselect']}
                    </div>
                    <div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
                        <span class="font_12 float_r">【<a id="signQuestion_{x2;v:data['questionid']}" href="javascript:signQuestion({x2;v:data['questionid']},'?{x2;eval: echo v:this->G->make('strings')->enstr(v:_SERVER['QUERY_STRING'])}');">{x2;if:$sessionvars['examsessionsign'][v:data['questionid']]}取消标注{x2;else}标注本题{x2;endif}</a>】</span>
				    	<span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;v:data['questionid']}');">收藏</a>】</span>
				    	<div class="option_single" id="radio">
                        	<p class=" float_l">本题答案：</p>
                            {x2;if:$questype[$cquestype]['questchoice'] == 1}
                            {x2;tree:$selectorder,so,sid}
                            {x2;if:v:key == v:data['questionselectnumber']}
                            {x2;eval: break;}
                            {x2;endif}
                            <label><input type="radio" name="question[{x2;v:data['questionid']}]" value="{x2;v:so}" />{x2;v:so}</label>
                            {x2;endtree}
                            {x2;else}
                            {x2;tree:$selectorder,so,sid}
                            {x2;if:v:key >= v:data['questionselectnumber']}
                            {x2;eval: break;}
                            {x2;endif}
                            <label><input type="checkbox" name="question[{x2;v:data['questionid']}][]" value="{x2;v:so}" />{x2;v:so}</label>
                            {x2;endtree}
                            {x2;endif}
                            <script type="text/javascript">{x2;if:$questype[v:data['questiontype']]['questchoice'] == 2 || $questype[v:data['questiontype']]['questchoice'] == 3}completeAnswers('question[{x2;v:data['questionid']}][]','{x2;eval: echo implode('',$sessionvars['examsessionuseranswer'][v:data['questionid']]);}');{x2;else}completeAnswers('question[{x2;v:data['questionid']}]','{x2;$sessionvars['examsessionuseranswer'][v:data['questionid']]}');{x2;endif}</script>
                    	</div>
                        <div class="clear"></div>
                    </div>
              </div>
              {x2;endtree}
              {x2;endif}
              {x2;else}
              <div class="qu_content" onMouseOver="this.className='qu_content_hover'" onMouseOut="this.className='qu_content'">
				<ul>
					{x2;realhtml:$currentquestion['question']['questionselect']}
				</ul>
				<div class="qu_option" onMouseOver="this.className='qu_option_hover'" onMouseOut="this.className='qu_option'">
				    {x2;if:$questype[$cquestype]['questsort']}
				    <span class="font_12 float_r">【<a id="signQuestion_{x2;$currentquestion['question']['questionid']}" href="javascript:signQuestion({x2;$currentquestion['question']['questionid']},'?{x2;eval: echo v:this->G->make('strings')->enstr(v:_SERVER['QUERY_STRING'])}');">{x2;if:$sessionvars['examsessionsign'][$currentquestion['question']['questionid']]}取消标注{x2;else}标注本题{x2;endif}</a>】</span>
				    <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;$currentquestion['question']['questionid']}');">收藏</a>】</span>
				    <p class=" float_l">本题答案：</p>
				    <div id="editor" class="clear">
				    	{x2;eval: $dataid = $currentquestion['question']['questionid']}
				    	{x2;include:plugin_editor}
				    </div>
				    {x2;else}
				    <span class="font_12 float_r">【<a id="signQuestion_{x2;$currentquestion['question']['questionid']}" href="javascript:signQuestion({x2;$currentquestion['question']['questionid']},'?{x2;eval: echo v:this->G->make('strings')->enstr(v:_SERVER['QUERY_STRING'])}');">{x2;if:$sessionvars['examsessionsign'][$currentquestion['question']['questionid']]}取消标注{x2;else}标注本题{x2;endif}</a>】</span>
				    <span class="font_12 float_r cz">【<a href="javascript:favorquestion('{x2;$currentquestion['question']['questionid']}');">收藏</a>】</span>
					<div class="option_single" id="radio">
				    	<p class=" float_l">本题答案：</p>
				        {x2;if:$questype[$cquestype]['questchoice'] == 1}
                        {x2;tree:$selectorder,so,sid}
                        {x2;if:v:key == $currentquestion['question']['questionselectnumber']}
                        {x2;eval: break;}
                        {x2;endif}
                        <label><input type="radio" name="question[{x2;$currentquestion['question']['questionid']}]" value="{x2;v:so}" />{x2;v:so}</label>
                        {x2;endtree}
                        {x2;else}
                        {x2;tree:$selectorder,so,sid}
                        {x2;if:v:key >= $currentquestion['question']['questionselectnumber']}
                        {x2;eval: break;}
                        {x2;endif}
                        <label><input type="checkbox" name="question[{x2;$currentquestion['question']['questionid']}][]" value="{x2;v:so}" />{x2;v:so}</label>
                        {x2;endtree}
                        {x2;endif}
				        <script type="text/javascript">{x2;if:$questype[$cquestype]['questchoice'] == 2 || $questype[$cquestype]['questchoice'] == 3}completeAnswers('question[{x2;$currentquestion['question']['questionid']}][]','{x2;eval: echo implode('',$sessionvars['examsessionuseranswer'][$currentquestion['question']['questionid']]);}');{x2;else}completeAnswers('question[{x2;$currentquestion['question']['questionid']}]','{x2;$sessionvars['examsessionuseranswer'][$currentquestion['question']['questionid']]}');{x2;endif}</script>
                    </div>
				    <div class="clear"></div>
				    {x2;endif}
				</div>
		      </div>
              <div class="clear">&nbsp;</div>
              {x2;endif}
          	   <ul id="qu_type_next" class="clear">
					<li><a href="javascript:showStudentInfo();">考生信息</a></li>
                	<li><a href="?exam-app-exam-exampaper&questype={x2;$cquestype}&questionid={x2;$prev}">上一题</a></li>
                	<li><a href="?exam-app-exam-exampaper&questype={x2;$cquestype}&questionid={x2;$next}">下一题</a></li>
                	<li><a href="?exam-app-exam-sign">试题列表</a></li>
               </ul>
               <div id="btn_exam_paper_over"><input type="hidden" name="insertscore" value="1"/><input type="button" value="" onClick="javascript:subpaper();"/></div>
                    <!--考生信息-->
                    <div id="kaoshengxinxi" class="kaoshengxinxi_t" style="display:none;">
                        <h4>考生信息</h4>
                        <table>
                      <tr>
                        <td width="70">姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
                        <td><span>张三</span></td>
                        <td rowspan="6" width="150"><img src="app/exam/styles/image/photo.jpg" /></td>
                      </tr>
                      <tr>
                        <td>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                        <td><span>男</span></td>
                      </tr>
                      <tr>
                        <td>准考证号：</td>
                        <td><span>1234</span></td>
                      </tr>
                      <tr>
                        <td>证件号码：</td>
                        <td><span>11010819831015269X</span></td>
                      </tr>
                      <tr>
                        <td>考试科目：</td>
                        <td><span>{x2;$data['currentsubject']['subject']}</span></td>
                      </tr>
                      <tr>
                        <td>考试时间：</td>
                        <td><span>{x2;date:$sessionvars['examsessionstarttime'],'Y-m-d'}</span></td>
                      </tr>
                    </table>
                </div>
                    <!--考生信息 结束-->
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
	$.get('?exam-app-index-ajax-lefttime&rand'+Math.random(),function(data){
		var setting = {
			time:{x2;$sessionvars['examsessiontime']},
			hbox:$("#timer_h"),
			mbox:$("#timer_m"),
			sbox:$("#timer_s"),
			finish:function(){window.location='?exam-app-exam-subpaper';}
		}
		setting.lefttime = parseInt(data);
		countdown(setting);
	});
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
function setTab(name,cursel,n){
  for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var yq=document.getElementById("tag_"+name+"_"+i);
  menu.className=i==cursel?"up":"";
  yq.style.display=i==cursel?"block":"none";
 }
}
function showStudentInfo(){
	art.dialog({content:$('#kaoshengxinxi').html(),title:'考生信息'});
}
var subpaper = function()
{
	$(".exameditors").each(function(){$(this).data('daeditor').save();});
	art.dialog({lock:true,resize:false,width:320,height:150,title:'交卷提醒',ok:function(){$('#form1').submit();},okval:'交卷',cancel:true,cancelval:'取消',content:'您确认要交卷吗？'});
}
function saveanswer(url){
	$(".exameditors").each(function(){$(this).data('daeditor').save();});
	var params = $(':input').serialize();
     $.ajax({
       url:'?exam-app-exam-ajax-saveUserAnswer',
       type:'post',
       dataType:'json',
       data:params,
       success:function(data){$('#yesdonumber').html(data);$('#nodonumber').html($('#allquestionnumber').html() - $('#yesdonumber').html());var myDate = new Date();$('#lastsavetime').html(myDate.toLocaleTimeString()); if(url)window.location.href=url;}
     });
}
</script>

</body>
</html>