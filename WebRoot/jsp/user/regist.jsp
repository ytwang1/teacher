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
    <title>ע��</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    form {
       width: 400px;
       text-align: center;
       margin: 0 auto;
     }
    div {
    width: 265px;
    padding: 2px 0;
    }
    div>span {
    display: inline-block;
    width: 80px;
    text-align: right;
    }
    </style>
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
  <form name="registForm">
    <div>
      <span>��¼ID��</span><input type="text" name="loginId" />
    </div>
    <div>
      <span>���룺</span><input type="password" name="password" />
    </div>
    <div>
      <span>�Ա�</span><input type="radio" name="sex" value="1" id="sexM" checked="checked" /><label for="sexM">��</label><input type="radio" name="sex" value="0" id="sexW" /><label for="sexW">Ů</label>
    </div>
    <div>
      <input id="submitRegist" type="button" value="ע��" class="btn btn-success" />
      <input id="submitReset" type="reset" value="����" class="btn btn-warning" />
    </div>
  </form>
</body>
<script type="text/javascript">
$(function(){
	// AJAX�ύע��
	$("#submitRegist").click(function(event){
		  // ����submit��Ĭ�ϵ�����������
		  $.NinTools.preventDefault(event);

			// ��֤���ύע�������
			var loginId = $.trim(registForm.loginId.value);
			if($.NinTools.isStrContainBlankChar(loginId)) {
				  alert("loginId����Ϊ��,���Ҳ��ܰ����հ��ַ�");
				  return false;
			}
			var password = $.trim(registForm.password.value);
			if(password.length < 6 || $.NinTools.isStrContainBlankChar(password)) {
				  alert("���볤�Ȳ��ܵ���6,���Ҳ��ܰ����հ��ַ�");
				  return false;
			}

			// AJAX �ύע��
			var url = "do?action=user/user&start=regist";
			var data = {
					"loginId": loginId,
					"password": password,
					"sex": registForm.sex.value};
			$.ajax({
				  url: url,
				  type: "POST",
				  data: data,
				  dataType: "json",
				  beforeSend: function(xhr) {
				  },
				  complete: function(xhr, ts) {
					    $("#submitReset").click();
					},
					success: function(jsonObj){
						  alert(jsonObj.msg)
					}
			});

		  // ��ֹð��
		  return false;
	});
});
</script>
</html>
