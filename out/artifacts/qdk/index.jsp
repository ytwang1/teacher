<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    div {
    width: 400px;
    text-align: center;
    margin: 10px auto;
    }
    </style>
    <jsp:include page="jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
  <div>
    <a href="doView?action=public&start=toLogin">登录</a>
    <a href="doView?action=public&start=toRegist">注册</a>
    <a href="doView?action=forward&start=toError">常见错误模拟</a>
    <a href="doView?action=public&start=toServiceUsage">service用法</a>
  </div>
</body>
</html>

