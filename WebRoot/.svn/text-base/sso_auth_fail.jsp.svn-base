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
    <title>fail</title>
    <style type="text/css">
    body {
      font-size: 18px;
      line-height: 28px;
    }
    .green {
      color: green;
    }
    .red {
      color: red;
    }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <jsp:include page="jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
这是出错页面。应该根据具体业务需要进行处理或向用户反馈错误信息，这里只对该情况进行一般性的描述。<br/><br/>
一般出现这个页面都是对action的访问没经过QDK的验证，解决办法：<br/>
1.访问系统，在浏览器地址栏里输入的域名必需是&nbsp;<span class="green">app.ssoDomain</span>
设置的主域名下的子域或该主域(比如设置的主域名是&nbsp;<span class="green">.netinnet.com</span><br/>
即&nbsp;<span class="red">app.ssoDomain=.netinnet.com</span>&nbsp;就可以用<br/>
<span class="green"><span class="red">子域名称</span>.netinnet.com:端口号/具体项目</span>&nbsp;或&nbsp;<span class="green">netinnet.com:端口号/具体项目</span>&nbsp;来访问,成功访问的前提是DNS能够成功映射,即需要在&nbsp;<span class="red">HOSTS</span>&nbsp;文件中添加映射,如该处的<br/>
<span class="green">127.0.0.1 netinnet.com</span><br/>
<span class="green">127.0.0.1 www.netinnet.com</span><br/>
)进行访问;对于该值设定成IP地址的(例如：127.0.0.1),则只能使用&nbsp;127.0.0.1&nbsp;来进行访问,用localhost也会出错。<br/>
(<span class="red">Note:</span> 该验证信息是通过cookie传递的,如果能够了解cookie的工作机制,对cookie的path、domain属性有所了解,就能理解QDK这个验证的流程。);<br /><br/>
2.默认情况下对所有的action访问都是必需走这个验证的,但是也可以在&nbsp;<span class="green">filter.authFilter.ignore_actions</span>&nbsp;中注册actiion甚至具体到指定action中的节点来绕过这个限制,通常需要绕过这个验证的都是公开的操作,类似开放的接口操作之类的,或者常见的登录、登出、注册业务等等。具体配置方法查看&nbsp;qdkConfig.properties&nbsp;中说明。<br/><br/>
3.一般为了系统安全,是不会在&nbsp;<span class="green">filter.authFilter.ignore_actions</span>&nbsp;中注册开放所有的action,所以更通常的做法是在用户登录之后进行授权,让已登录用户获得权限。对于授权操作,一般都是在用户执行登录操作后成功通过系统认证时在action中执行下述语句：<br/>
<span class="red">=markLogin|{ck_LoginId:'[:session.userId]',ck_LoginName:'[:session.loginId]',ck_RoleIds:'a,b,c',ck_roleNames:'a,v,v'}</span><br/>
ck_LoginId、ck_LoginName需要根据具体情况自行设置,而ck_RoleIds和ck_roleNames则使用该默认值。<br/>
然后在用户退出系统时执行回收权限,通过在action中调用下述语句：<br/>
<span class="red">=markLogout</span>
</body>
</html>

