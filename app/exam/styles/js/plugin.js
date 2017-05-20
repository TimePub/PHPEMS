function common(){
	var getSectionContent = function(data){
		//$('#'+data.attr('more')).load('?exam-app-exercise-ajax-getQuestionNumber&sectionid='+data.val()+'&rand='+Math.random());
		var obj = '#'+data.attr('more');
		$.get('index.php?exam-app-exercise-ajax-getQuestionNumber&sectionid='+data.val()+'&rand='+Math.random(),function(d){$(obj).html(d);});
	}
	var combox = function(){
		$(".combox").bind("change",function(){
			if($(this).attr("ref") && $(this).attr("ref") != ""){
				if($(this).attr("refUrl") != ""){
					var url = $(this).attr("refUrl").replace(/{value}/,$(this).val());
					var t = $(this).attr('tmp');
					url = url.replace(/{tmp}/,$('#'+t).val());
					var obj = '#'+$(this).attr("ref");
					$.get(url+'&rand='+Math.random(),function(d){$(obj).html(d);});
					if($(this).attr("callback") && $(this).attr("callback") != "")
					eval($(this).attr("callback"))($(this));
				}
			}
		})
	}
	combox();
}
function completeAnswers(name,answer){
	$("[name='"+name+"']").each(function(){if(answer.indexOf($(this).val()) >= 0)$(this).attr('checked',true);});
}

function favorquestion(questionid){
	$.get("index.php?exam-app-favor-ajax-addfavor&questionid="+questionid+'&'+Math.random(),function(){alert('收藏成功');});
}

function signQuestion(questionid,url){
	$.get("index.php?exam-app-index-ajax-sign&url="+url+"&questionid="+questionid+'&'+Math.random(),function(data){if(parseInt(data) == 1){$('#signQuestion_'+questionid).html('取消标注');}else{$('#signQuestion_'+questionid).html('标注本题');}});
}

function setTab(name,cursel,n){
	for(i=1;i<=n;i++){
		var menu=document.getElementById(name+i);
		var yq=document.getElementById("tag_"+name+"_"+i);
		menu.className=i==cursel?"up":"";
		yq.style.display=i==cursel?"block":"none";
	}
}

function question_error(questionid){
	var dialog = art.dialog({
		id: 'error',
		fixed: true,
		title: '该题有错？请详细填写以下内容：',
		okVal: '提交问题',
		ok: function () {
						var type = $('#error_type').val();
						var info = $('#error_info').val();
						if (type == 0) {
							$('#type').show();
							return false;
						}
						if (info.length == 0) {
							$('#info').show();
							return false;
						}
						if (info.length  > 500) {
							$('#info').html('字数超出限制').show();
							return false;
						}
						$.post("?exam-app-submitError",{'id':questionid,'type':type,'info':info},function(result){
							var msg;
							if (result == 0) {
								msg = '已提交成功，我们会尽快处理，谢谢！';
							} else if (result == 1) {
								msg = '已经提交成功！';
							} else if (result == 3) {
								msg = '非法ID，试题已过期或不存在此试题！';
							} else {
								msg = '提交失败！';
							}
							alert(msg);
						});
		                return true;
					}
	});
	$.ajax({
	    url: '?exam-app-ajaxError',
	    success: function (data) {
	        dialog.content(data);
	    },
	    cache: false
	});
}

function check_type(obj){
	if ($(obj).val() > 0) {
		$('#type').hide();
	}
	return;
}

function check_info(obj){
	if ($(obj).val().length > 0 && $(obj).val().length  <= 500) {
		$('#info').hide();
	}
	if ($(obj).val().length  > 500) {
		$('#info').html('字数超出限制').show();
		return false;
	}
	return;
}

function pr()
{
var L=document.getElementById("main_left");
var R=document.getElementById("right_760");
if (L.className=="main_left")
	{
		L.className="main_left0";
		R.className="right_970";
	}
else
	{
		L.className="main_left";
		R.className="right_760";
	}
}