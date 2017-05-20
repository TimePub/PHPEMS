<script type="text/javascript">
$(document).ready(function(){
	initData = $.parseJSON(storage.getItem('questions'));
	if(initData){
		for(var p in initData){
			if(p!='set')
			formData[p]=initData[p];
		}

		var textarea = $('#form1 textarea');
		$.each(textarea,function(){
			var _this = $(this);
			_this.val(initData[_this.attr('name')]);
			CKEDITOR.instances[_this.attr('id')].setData(initData[_this.attr('name')]);
			markQuestion(_this.attr('rel'),true);
		});

		var texts = $('#form1 :input[type=text]');
		$.each(texts,function(){
			var _this = $(this);
			_this.val(initData[_this.attr('name')]);
			markQuestion(_this.attr('rel'),true);
		});

		var radios = $('#form1 :input[type=radio]');
		$.each(radios,function(){
			var _= this, v = initData[_.name];
			var _this = $(this);
			if(v!=''&&v==_.value){
				_.checked = true;
			}else{
				_.checked=false;
			}
			markQuestion(_this.attr('rel'));
		});

		var checkboxs=$('#form1 :input[type=checkbox]');
		$.each(checkboxs,function(){
			var _=this,v=initData[_.name];
			var _this = $(this);
			if(v!=''&&v==_.value){
				_.checked=true;
			}else{
				_.checked=false;
			}
			markQuestion(_this.attr('rel'));
		});
	}

	$('#form1 :input[type=text]').change(function(){
		var _this=$(this);
		var p=[];
		p.push(_this.attr('name'));
		p.push(_this.val());
		set.apply(formData,p);
		markQuestion(_this.attr('rel'));
	});

	$('#form1 :input[type=radio]').change(function(){
		var _=this;
		var _this=$(this);
		var p=[];
		p.push(_.name);
		if(_.checked){
			p.push(_.value);
			set.apply(formData,p);
		}else{
			p.push('');
			set.apply(formData,p);
		}
		markQuestion(_this.attr('rel'));
	});

	$('#form1 textarea').change(function(){
		var _= this;
		var _this=$(this);
		var p=[];
		p.push(_.name);
		p.push(_.value);
		set.apply(formData,p);
		markQuestion(_this.attr('rel'));
	});

	$('#form1 :input[type=checkbox]').change(function(){
		var _= this;
		var _this = $(this);
		var p=[];
		p.push(_.name);
		if(_.checked){
			p.push(_.value);
			set.apply(formData,p);
		}else{
			p.push('');
			set.apply(formData,p);
		}
		markQuestion(_this.attr('rel'));
	});
});
</script>