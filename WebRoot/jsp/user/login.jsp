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
    <title><%=RequestUtil.getVarStringValue(request, "title") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    form {
    width: 400px;
    margin: 0 auto;
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
  <form name="loginForm">
    <div>
      <span>登录ID:</span>
      <input type="text" name="loginId" />
    </div>
    <div>
      <span>密码:</span>
      <input type="password" name="password" />
    </div>
    <div>
      <input type="submit" id="loginBtn" value="登录" class="btn btn-success" />
      <input type="reset" value="重置" class="btn btn-warning" />
    </div>
  </form>
</body>
<script type="text/javascript">
$(function(){
	$("#loginBtn").click(function(event){
		  $.NinTools.preventDefault(event);

		  var url = "do?action=user/user&start=login";
		  var data = {
				  loginId: loginForm.loginId.value,
				  password: loginForm.password.value
			};

			// AJAX 提交登录
			$.ajax({
				  url: url,
				  data: data,
				  type: "POST",
				  dataType: "json",
				  traditional: true, // 禁用jquery深度序列化参数对象以适用Servlet API
				  beforeSend: function(xhr) {},
				  complete: function(xhr, ts) {},
				  success: function(jsonObj) {
					   if("200" === jsonObj.code) {
						   self.location.href=jsonObj.forwardUrl;
						 }else {
							  alert("登录失败,登录Id或密码错误");
						 }
					}
			});
	});
});
</script>
</html>

