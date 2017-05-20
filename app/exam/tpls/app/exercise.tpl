{x2;include:head}
<body>
<!--导航-->
{x2;include:nav}
<div id="main">
	{x2;include:left}
	<!--主体右侧 -->
	<div id="right_760" class="right_760">
    	{x2;include:bread}
    	<div class="bor_top"></div>
    	<div class="bor_mid">
    		<div id="hide_left"><a href="javascript:pr()"></a></div>
            <div id="notice">
            	<h2 class="page_title"><img src="app/exam/styles/image/exer_notice_tit.jpg" alt="练习须知" /></h2>
                <ul>
                	<li><b>1、</b>在您看完“练习须知”后，配置练习规则，点击“开始练习”按钮进入答题界面，考试开始计时。</li>
                	<li><b>2、</b>在练习过程中，您可以通过顶部的考试时间来掌握自己的做题时间。</li>
                	<li><b>3、</b>提交试卷后，可以通过“查看答案和解析”功能进行总结学习。</li>
                    <li><b>4、</b>综合阶段请按题型提供最大题数输入。如：题型显示“共11题”，则直接输入11，即可抽出整张试卷练习。</li>
                </ul>
                <form action="?exam-app-exercise" id="exer" method="post">
                	<h4>配卷规则</h4>
                    <form>
                    	<ol>
                        	<li>
                            	<span class="red">*</span>
                                <span>章
                                	<select id="thesectionid" name="args[sectionid]" class="combox" ref="theknowsid" refUrl="?exam-app-index-ajax-getknowsbysectionid&sectionid={value}" more="questionnumbers" callback="getSectionContent">
                                		<option value="0">请选择章节</option>
                                		{x2;tree:$sections,section,sid}
                                		<option value="{x2;v:section['sectionid']}">{x2;v:section['section']}</option>
                                		{x2;endtree}
                                	</select>
                                </span>
                                <span>知识点：
                                	<select name="args[knowsid]" id="theknowsid" class="combox" ref="questionnumbers" refUrl="?exam-app-exercise-ajax-getQuestionNumber&sectionid={tmp}&knowsid={value}" tmp="thesectionid">
                                		<option value="0">请先选择知识点</option>
                                	</select>
                                </span>
                                <span id="section_error" class="red font_12 main_left0">请选择章节</span>
                            </li>
                        	<li>
                            	<span class="red">*</span>
                                <span>试卷名称：<input id="exam_name" type="text" name="args[title]" /></span><span style="font-size:12px;">请填适合在答题记录中查找的试卷名称</span>
                                <span id="exam_name_error" class="red font_12 main_left0">请填写试卷名称</span>
                            </li>
                        	<li>
                                <span class="red">*</span>
                                <span>做题时间：<input id="exam_time" type="text" name="args[time]"  value='60'/> 分钟，</span><span style="font-size:12px;">请填写本题练习的时长</span>
                                <span id="exam_time_error" class="red font_12 main_left0">请填写做题时间</span>
                            </li>
                        	<li>
                            <span class="red">*</span>
                            <span>题&nbsp;&nbsp;&nbsp;&nbsp;型：如果您不希望做某种题型，请在选题数值框内填0。</span>
                            <span id="question_count_error" class="red font_12 main_left0">请至少选择一道题</span>
                            </li>
                        </ol>
                        <ol id="questionnumbers">
                            {x2;tree:$questype,quest,qid}
                            <li class="text_in">
                            	{x2;v:quest['questype']}（共{x2;$numbers[v:quest['questid']]}题），选 <input id="question_{x2;v:quest}" type="text" class="exer_amount" name="args[number][{x2;v:quest}]" onChange="javascript:check_num(this);" onBlur="" rel="{x2;$numbers[v:quest]}"/> 题
                            	<span id="question_{x2;v:quest['questid']}_error" class="red font_12 main_left0">选择的题数不能超过{x2;$numbers[v:quest]}</span>
                            </li>
                        	{x2;endtree}
                        </ol>
                        <div id="begin_exer"><input type="hidden" name="setExecriseConfig" value="1" /><input onclick="javascript:return check_form();" type="submit" value="" /></div>
                    </form>
                </div>
            </div>
    	</div>
    	<div class="bor_bottom"></div>
    </div>
	<!--主体右侧 结束-->
{x2;include:foot}
<script type="text/javascript">
$(document).ready(function(){
	common();
	$("#thesectionid").change(function(){
		$('#section_error').hide();
	});
	$("#exam_name").change(function(){
		$('#exam_name_error').hide();
	});
	$("#exam_time").change(function(){
		$('#exam_time_error').hide();
	});
});
function check_form(){
	var check = true;
	var section = $("#thesectionid").val();
	if ( section == 0 ){
		$('#section_error').show();
		check = false;
	}
	var exam_name = $("#exam_name").val();
	if ( exam_name == "" ){
		$('#exam_name_error').show();
		check = false;
	}
	var exam_time = $("#exam_time").val();
	if ( isNaN(exam_time) || exam_time== 0 ){
		$('#exam_time_error').show();
		check = false;
	}
	var arr = 0;
	$("#questionnumbers").children('li').each(function(){
		var max = $(this).children('input').attr('rel');
		var id = $(this).children('input').attr('id')
		var num = $(this).children('input').val();
		num = (isNaN(num) || num=="") ? 0 : num;
		arr += Number(num);
		if(Number(num) > Number(max)){
			$("#"+id+"_error").show();
			check = false;
			return;
		}
	});
	if( arr == 0 ){
		$("#question_count_error").show();
		check = false;
	}
	return check;
}

function check_num(obj){
	var max = $(obj).attr('rel');
	var id = $(obj).attr('id');
	var num = $(obj).val();
	num = (isNaN(num) || num=="") ? 0 : num;
	if(Number(num) > 0){
		$("#question_count_error").hide();
	}
	if(Number(num) > Number(max)){
		$("#"+id+"_error").show();
		return false;
	}else{
		$("#"+id+"_error").hide();
		return true;
	}
}
</script>
</body>
</html>