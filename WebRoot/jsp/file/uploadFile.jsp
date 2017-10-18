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
    <title>�ļ��ϴ�</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    div {
      width: 400px;
      text-align: center;
      margin: 10px auto;
    }
    form {
    width: 400px;
    text-align: center;
    }
    form>div {
    padding: 5px;
    }
    form>div>span {
      width: 70px;
      display: inline-block;
      text-align: right;
    }
    </style>
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
<div>
  <a href="#" id="logout">�˳�ϵͳ</a><br/><br/>
  <a href="doView?action=forward&start=toMain">����</a>
  <%-- ����IFrame,�����ύ�ļ��ϴ�,ʵ��ʵʱ�ļ��ϴ�Ч�� --%>
  <iframe id="iframe4UploadFile" name="iframe4UploadFile" style="display: none;"></iframe>
  <form name="fileUploadForm" action="douploaddatafile" method="post" enctype="multipart/form-data" target="iframe4UploadFile">
    <%-- �ļ��ϴ�������������֮��Ҫִ�еĺ���������action, ���� --%>
    <input type="hidden" name="action" value="user/file" />
    <%-- �ļ��ϴ�������������֮��Ҫִ�еĺ��������Ľڵ� --%>
    <input type="hidden" name="start" value="afterReceiverFile" />
    <input type="file" name="uploadFile" /><br/>
    <input type="submit" value="�ϴ�" />
  </form>
  
  <div id="fileUploadResult"></div>
</div>
</body>
<script type="text/javascript">
$(function(){
	// ��ȡ�ļ��ϴ��������
	$("#iframe4UploadFile").load(function(){
	    var jsonStr = self.frames['iframe4UploadFile'].document.body.innerHTML;
	    if(jsonStr != "") {
	    	var result = $.parseJSON(jsonStr);
	    	var strHTML = "<div style='color: red;'>�ϴ�ʧ��</div>";
	    	if("200" == result.code) {
	    		strHTML = "<div style='color: green;'>�ϴ����</div>";
	    		strHTML = strHTML + "fileName: " + result.data.fileName + "<br/>"
	              + "fileLength: " + result.data.fileLength + "<br/>"
	              + "content: <br/>" + result.data.content
		    } else {
		    	strHTML += result.msg;
			  }
	      $('#fileUploadResult').html(strHTML);
		  }
	  });

	$("#logout").click(function(event){
	      $.NinTools.preventDefault(event);

	      $.post("do?action=user/user&start=logout", null, function(result){
	        if("200" == result.code) {
	          self.location.href = result.forwardUrl;
	        }
	      }, "JSON");
	});
});
</script>
</html>
