<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="cn.netinnet.qdk.util.RequestUtil"%>
<%@page import="cn.netinnet.qdk.util.SessionUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String blogId = RequestUtil.getVarStringValue(request, "blogId");
%>
<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=GBK"/>
    <title>��������</title>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    div {
      width: 400px;
      text-align: center;
      margin: 10px auto;
    }
    form {
      width: 660px;
      text-align: center;
    }
    form > div {
    padding: 5px;
    }
    .speciedWidth {
      width: 400px;
    }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
<div>
  <a href="doView?action=forward&start=toMain">����</a>
  <form name="blogForm">
    <div>
      <span>����:</span>
      <input type="text" name="title" class="speciedWidth" />
    </div>
    <div>
      <span>����:</span>
      <textarea rows="" cols="" name="content" class="speciedWidth"></textarea>
    </div>
    <div>
      <input type="submit" id="editBtn" value="�޸�" class="btn btn-success" />
    </div>
  </form>
</div>
</body>
<script type="text/javascript">
$(function(){
	var blogId = "<%=blogId %>";
	$("#editBtn").click(function(event){
		  $.NinTools.preventDefault(event);

		  var title = $.trim(blogForm.title.value);
		  var content = $.trim(blogForm.content.value);

		  if(0 >= title.length) {
			  alert("���ⲻ��Ϊ��");
			  return false;
			}

			// AJAX �ύ
			var url = "do?action=user/teacher&start=edit";
			var data = {
					  "blogId": blogId,
					  "title": title,
					  "content": content
			};
			$.ajax({
				  url: url,
				  data: data,
				  type: "POST",
				  dataType: "json",
				  traditional: true,
				  beforeSend: function(xhr) {},
				  complete: function(xhr, ts) {},
				  success: function(result) {
					  if("200" === result.code) {
						  alert("�޸ĳɹ�");
						} else {
							  alert("ʧ��");
						}
					}
			});

			return false;
	});

	var load = function() {
		  var url = "do?action=user/blog&start=blogDetail";
		  var data = {"blogId": blogId};

		  // �첽��ȡ���ľ�������
		  $.post(url, data, function(result){
			  blogForm.title.value = result.title;
			  blogForm.content.value = result.content;
			}, "json");
	};

	// load��ɺ�ִ��
	load();
});
</script>
</html>
