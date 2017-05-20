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
            <div id="exam_paper">
              <div id="answer_note" class="float_div1">
           	  <h2 class="page_title">
               	<ul id="note_type">
                    </ul><img src="app/exam/styles/image/house_tit.jpg" alt="我的收藏" />
                </h2>
                </div>
                <div class="clear"></div>
                  <div id="house">
                  	<form id="searchform" class="form-inline">
                        <span>题型：<select name="search[questype]" style="width:240px;">
                        	<option value="0">请选择题型</option>
                        	{x2;tree:$questype,quest,qid}
                    		<option value="{x2;v:quest['questid']}"{x2;if:$search['questype'] == v:quest['questid']} selected{x2;endif}>{x2;v:quest['questype']}</option>
                    		{x2;endtree}
                        </select></span>
                        <input type="hidden" value="{x2;$type}" name="type" />
                        <input type="button" value="搜 索" id="search_btn" onclick="javascript:window.location='index.php?exam-app-favor&'+$(':input').serialize();"/>
                    </form>
                  </div>
                  {x2;if:$type}
                  	{x2;eval:v:ishead = 0}
                  	{x2;eval:v:ispre = 0}
                  	{x2;tree:$favors['data'],question,qid}
                  	{x2;if:v:pre != v:question['questionparent']}
                	{x2;eval:v:ishead = 0}
                	{x2;endif}
                	{x2;if:!v:ishead}
                	<div class="qu_content" onmouseover="this.className='qu_content_hover'" onmouseout="this.className='qu_content'">
                	<h3>题帽：{x2;realhtml:v:question['qrquestion']}</h3>
                	</div>
                	{x2;endif}
	               	<div class="qu_content" onmouseover="this.className='qu_content_hover'" onmouseout="this.className='qu_content'">
	                	<h3>{x2;eval: echo ($page-1)*20+v:qid}、{x2;realhtml:v:question['question']}</h3>
	                    <ul>
	                    	{x2;realhtml:v:question['questionselect']}
	                    </ul>
	                    <div class="answer">
	                    	<ul>
	                        	<li class="red">【正确答案】{x2;realhtml:v:question['questionanswer']}</li>
	                        	<li>【所在章】{x2;tree:v:question['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        		<li>【知识点】{x2;tree:v:question['qrknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
	                        	<li>【答案解析】</li>
	                        	<li class="ml_10">{x2;realhtml:v:question['questiondescribe']}</li>
	                        </ul>
	                    </div>
	                </div>
	                {x2;eval:v:ishead++}
	                {x2;eval:v:pre=v:question['questionparent']}
	                {x2;endtree}
                  {x2;else}
	                {x2;tree:$favors['data'],question,qid}
	               	<div class="qu_content" onmouseover="this.className='qu_content_hover'" onmouseout="this.className='qu_content'">
	                	<h3>{x2;eval: echo ($page-1)*20+v:qid}、{x2;realhtml:v:question['question']}</h3>
	                    <ul>
	                    	{x2;realhtml:v:question['questionselect']}
	                    </ul>
	                    <div class="answer">
	                    	<ul>
	                        	<li class="red">【正确答案】{x2;realhtml:v:question['questionanswer']}</li>
	                        	<li>【所在章】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalsections[$globalknows[v:knowsid['knowsid']]['knowssectionid']]['section']}&nbsp;{x2;endtree}</li>
                        		<li>【知识点】{x2;tree:v:question['questionknowsid'],knowsid,kid}&nbsp;&nbsp;{x2;$globalknows[v:knowsid['knowsid']]['knows']}&nbsp;{x2;endtree}</li>
	                        	<li>【答案解析】</li>
	                        	<li class="ml_10">{x2;realhtml:v:question['questiondescribe']}</li>
	                        </ul>
	                    </div>
	                </div>
	                {x2;endtree}
                {x2;endif}
                <div class="pagination pagination-right">
		            <ul>{x2;$favors['pages']}</ul>
		        </div>
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
<script>
$(document).ready(function(){
		$('#roll').hide();
		common();
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
<script src="app/exam/styles/js/lib.js" type="text/javascript"></script>
</body>
</html>