/**
 * ����jQuery��ͨ�ù��߿�
 * ������: jQuey, ejs, jquery.NinLayer.js
 */

jQuery.NinTools = {
	
	/**
	 * ����submit��ť��a��ǩ��domԪ�صĵ����¼���Ĭ�ϴ������
	 **/
	preventDefault: function(event) {
		if(event && event.preventDefault) {
			event.preventDefault();
		} else {
			window.event.returnValue = false;
		}
	},
	
	
	/**
	 * ����ַ����Ƿ�����հ��ַ�
	 * �������հ��ַ��򷵻� true, ���򷵻� false;
	 * ������� str ����string���ͽ����� undefined
	 **/
	isStrContainBlankChar: function(str) {
		if(typeof str === "string") {
			var reg = /\s+|^$/;
			return reg.test(str);
		}
		return undefined;
	},
	
	
	/**
	 * ����ejs��ǰ����Ⱦ���
	 * ����, �ص����� callback(jsonObj) �е�jsonObj�������json�淶, һ�������ݸ�ʽ�Ļ�������,
	 * {"code":"200", "data":{"list":[{}], "page":"", .....}}
	 * ����ֻ�ڸû������ݶ���Ļ���������չ�����޸�
	 **/
	rendering: function(options, callbackFun) {
		var defaults = { 
				renderEl : "", 
				templete : "temp", 
				data : {}, 
				url : "", 
				dataType:"json", 
				type : "POST",
				traditional: true
		};  
	    $.extend(defaults,options);
	    
	    var temp = $("#"+defaults.templete).html();
	    var loadingEl = defaults.loadingEl || defaults.renderEl;
	    
	    $.ajax({
			type: defaults.type,
			url: defaults.url,
			data: defaults.data,
			traditional: defaults.traditional,
			dataType:defaults.dataType,
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			beforeSend: function(xhr) {
		    	if($.fn.ninLayIn) {
		    		$("#"+loadingEl).ninLayIn({html:"<div class='loading'></div>loading...",duration:0,bgColor: ["#fff",0.4]});
		    	}
	    	},
	    	complete: function(xhr, ts) {
	    		if($.fn.ninLayIn) $("#"+loadingEl).ninLayOut();
	    	},
			success:function(data){
				if(data && data.code=="200"){
					var html = new EJS({"text":temp,"type":"["}).render(data.data);
				    $("#"+defaults.renderEl).html(html);
				    
				    if(typeof(callbackFun)==='function') callbackFun.call(null, data);
				}
			}
		});
	}
};
