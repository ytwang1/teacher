/**
 * 基于jQuery的通用工具库
 * 依赖库: jQuey, ejs, jquery.NinLayer.js
 */

jQuery.NinTools = {
	
	/**
	 * 禁用submit按钮或a标签等dom元素的单击事件的默认处理程序
	 **/
	preventDefault: function(event) {
		if(event && event.preventDefault) {
			event.preventDefault();
		} else {
			window.event.returnValue = false;
		}
	},
	
	
	/**
	 * 检查字符串是否包含空白字符
	 * 若包含空白字符则返回 true, 否则返回 false;
	 * 如果参数 str 不是string类型将返回 undefined
	 **/
	isStrContainBlankChar: function(str) {
		if(typeof str === "string") {
			var reg = /\s+|^$/;
			return reg.test(str);
		}
		return undefined;
	},
	
	
	/**
	 * 基于ejs的前端渲染插件
	 * 其中, 回调方法 callback(jsonObj) 中的jsonObj必须符合json规范, 一下是数据格式的基本定义,
	 * {"code":"200", "data":{"list":[{}], "page":"", .....}}
	 * 建议只在该基本数据定义的基础上做扩展而非修改
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
