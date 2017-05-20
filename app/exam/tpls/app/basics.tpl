{x2;include:head}
<body>
<!--导航-->
{x2;include:nav}
<div id="main">
	{x2;include:left}
	<!--主体右侧 -->
	<div class="right_760">
    	{x2;include:bread}
    	<div class="bor_top"></div>
    	<div class="bor_mid">
            <div id="clue">
            	<div id="clue_bor_top"></div>
            	<div id="clue_content">
                	<h3>友情提示</h3>
                    <p>今天是<span class="orange">{x2;date:TIME,'Y'}</span>年<span class="orange">{x2;date:TIME,'m'}</span>月<span class="orange">{x2;date:TIME,'d'}</span>日 <span class="orange">星期{x2;eval: v:wk = date('w')}{x2;if:v:wk}{x2;$ols[v:wk]}{x2;else}日{x2;endif}</span><br />请您合理安排工作学习时间，祝您考试顺利。</p>
                </div>
            	<div id="clue_bor_bottom"></div>
            </div>
            <ul id="intro">
                <li><b>全真模拟：</b>全面模拟机考流程，给考生最贴近实际的机考体验。</li>
                <li><b>名师题库：</b>顶级名师团队精心编写，题型全面，覆盖各类考点。</li>
                <li><b>全新体验：</b>全新UI设计和交互体验，锻炼考生操作能力和速度。</li>
                <li id="begin_exam"><a href="index.php?exam-app-exampaper"><img src="app/exam/styles/image/btn_begin_exam.jpg" /></a></li>
            </ul>
    	</div>
    	<div class="bor_bottom"></div>
    </div>
	<!--主体右侧 结束-->
{x2;include:foot}
</body>
</html>
