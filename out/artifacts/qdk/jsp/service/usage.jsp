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
    <title>service�÷�</title>
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
<span class="green">WEB-INF/service</span>&nbsp;Ŀ¼�µ�action������������QDK��Ŀ�ṩ�����ӿڣ����������action��java���е�2�ֵ��÷�ʽ��<br/>
�����ø���Ŀ���������ṩ�Ľӿ�����ʾ(�����ȡһƪblog)��<br/><br/>
1.��&nbsp;qdkConfig.properties&nbsp;�����ļ������ע��������������QDK WEB��Ŀ<br/>
<span class="green">app.serviceList</span>=self<br/>
������&nbsp;<span class="green">app.serviceList</span>&nbsp;��Ӷ���������񣬶��������&nbsp;<span class="green">,</span>&nbsp;�ָ����������ú�����Դ�������ơ�<br/>
<span class="green">self</span>&nbsp;�����������ID����Ҫ��֮����ݸ�ID������ϸ���������ã����£�<br>
<span class="green">service.self.ak</span>=netinnet_qdk_start-dev&nbsp;(��Ŀ��Ψһ��ʶAKֵ����ѡ�����������Ŀ��&nbsp;<span class="green">app.AK</span>&nbsp;����)<br/>
<span class="green">service.self.url</span>=http://127.0.0.1/QDKDemo&nbsp;(�������������Ŀֱ����ַ)<br/>
<span class="green">service.self.version</span>=1.0.0&nbsp;(���÷���ʱĬ��ʹ�õķ���汾)<br/><br/>
2.&nbsp;action&nbsp; ����service<br/>
temp.returnData=doService:self?action=serviceTest&start=randomBlog&nbsp;(self��ע������������ID)<br/>
<input id="invokeByAction" type="button" value="action����" /><br/><br/>
2.&nbsp;java����&nbsp; ����service<br/>
String strReturnData = DoServiceUtil.doService("self?action=serviceTest&start=randomBlog");<br/>
<input id="invokeByJavacode" type="button" value="java�������" /><br/><br/>
</body>
<script type="text/javascript">
$(function(){
	// action ����
	$("#invokeByAction").click(function(){
		  var url = "do?action=invokeService&start=invokeByAction";

		  getRandomBlogAjax(url);
	});

	// java�������
	$("#invokeByJavacode").click(function(){
	      var url = "do?action=invokeService&start=invokeByJavacode";

	      getRandomBlogAjax(url);
	  });

	  // �첽��ȡһƪ�������
	  var getRandomBlogAjax = function(url) {
		  $.post(url, null, function(result){
	      if(result.data.blogs.length > 0) {
	        var blog = result.data.blogs[0];
	        alert("id: " + blog.id + "\n" +
	              "title: " + blog.title + "\n" +
	              "content: " + blog.content);
	      } else {
	          alert("û���õ�����");
	      }
     }, "json");
		};
});
</script>
</html>

