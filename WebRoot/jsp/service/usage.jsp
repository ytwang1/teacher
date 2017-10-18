<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="cn.netinnet.qdk.util.RequestUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=GBK"/>
    <title>service用法</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <style type="text/css">
    body {
      font-size: 18px;
      line-height: 28px;
    }
    .green {
      color: green;
    }
    </style>
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
<span class="green">WEB-INF/service</span>&nbsp;目录下的action是用来向其他QDK项目提供操作接口，这里介绍在action中java类中的2种调用方式。<br/>
这里用该项目调用自身提供的接口来演示(随机抽取一篇blog)。<br/><br/>
1.在&nbsp;qdkConfig.properties&nbsp;配置文件中添加注册依赖的其他新QDK WEB项目<br/>
<span class="green">app.serviceList</span>=self<br/>
可以在&nbsp;<span class="green">app.serviceList</span>&nbsp;添加多个依赖服务，多个服务用&nbsp;<span class="green">,</span>&nbsp;分隔，具体配置和数据源配置类似。<br/>
<span class="green">self</span>&nbsp;是依赖服务的ID，需要在之后根据该ID进行详细的属性配置，如下：<br>
<span class="green">service.self.ak</span>=netinnet_qdk_start-dev&nbsp;(项目的唯一标识AK值，必选项，见所依赖项目的&nbsp;<span class="green">app.AK</span>&nbsp;设置)<br/>
<span class="green">service.self.url</span>=http://127.0.0.1/QDKDemo&nbsp;(所依赖服务的项目直连地址)<br/>
<span class="green">service.self.version</span>=1.0.0&nbsp;(调用服务时默认使用的服务版本)<br/><br/>
2.&nbsp;action&nbsp; 调用service<br/>
temp.returnData=doService:self?action=serviceTest&start=randomBlog&nbsp;(self是注册的依赖服务的ID)<br/>
<input id="invokeByAction" type="button" value="action调用" /><br/><br/>
2.&nbsp;java代码&nbsp; 调用service<br/>
String strReturnData = DoServiceUtil.doService("self?action=serviceTest&start=randomBlog");<br/>
<input id="invokeByJavacode" type="button" value="java代码调用" /><br/><br/>
</body>
<script type="text/javascript">
$(function(){
	// action 调用
	$("#invokeByAction").click(function(){
		  var url = "do?action=invokeService&start=invokeByAction";

		  getRandomBlogAjax(url);
	});

	// java代码调用
	$("#invokeByJavacode").click(function(){
	      var url = "do?action=invokeService&start=invokeByJavacode";

	      getRandomBlogAjax(url);
	  });

	  // 异步获取一篇随机博文
	  var getRandomBlogAjax = function(url) {
		  $.post(url, null, function(result){
	      if(result.data.blogs.length > 0) {
	        var blog = result.data.blogs[0];
	        alert("id: " + blog.id + "\n" +
	              "title: " + blog.title + "\n" +
	              "content: " + blog.content);
	      } else {
	          alert("没有拿到博文");
	      }
     }, "json");
		};
});
</script>
</html>

