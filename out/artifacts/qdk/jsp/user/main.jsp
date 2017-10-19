<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="cn.netinnet.qdk.util.RequestUtil"%>
<%@page import="cn.netinnet.qdk.util.SessionUtil"%>
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
    <title>��ҳ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    div {
      width: 400px;
      text-align: center;
      margin: 10px auto;
     }
    #teacherList {
      border: 1px solid #EEE;
      width: 400px;
      min-height: 80px;
      text-align: center;
      padding: 5px;
      overflow: auto;
    }
    table, th, td
    {
      width:80%;
      border: 1px solid black;
      margin: 0 auto;
      text-align: center;
    }
    ul {
    margin-top: -10px;
    list-style: none;
    }
    .font-1 {
    font-size: 13px;
    }
    </style>
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
<div>
  <h3>Welcome, <%=SessionUtil.getVarStringValue(request, "loginId") %>.</h3><br/><br/>
  <a href="doView?action=forward&start=toCreate">������ʦ</a>
  <a href="#" id="logout">�˳�ϵͳ</a><br/><br/>
  <%-- �����б�����������װ�ش���Ⱦ������ --%>
  <div id="teacherList"></div>
</div>
</body>
<%-- �����б�ģ�壬����EJS��Ⱦ��װ�ؾ������ݵ������������� list�� ��� jquery.NinTools.js �е� rendering --%>
<script type="text/javascript" id="teacherTemplete">
<table class="table table-striped table-hover">
<th>��ʦ�б�</th>
<th>����</th>

[%if(list.length>0){%]


  [%for(var i=0; list[i]; i++){%]
    <tr><td>
    <a name="teacher" teacherId="[%=list[i].id%]" href="#">[%=list[i].teachername%]</a>
    </td>
    <td>
    <a name="teacherDelete" teacherId="[%=list[i].id%]" href="#"><span class="glyphicon glyphicon-remove"></span></a>
    </td>
	[%}%]
</tr>
</table>
	<span class="font-1">��&nbsp;[%=totalCount%]&nbsp;����ʦ</span>
<select class="pagination">
  [%
    var totalPage = parseInt((totalCount+countPerPage-1) / countPerPage);
   %]
  [%for(var page=1; page<=totalPage; page++){%]
	<option value="[%=page%]" [%if(page==curPage){%]selected="selected"[%}%]>��[%=page%]ҳ</option>
  [%}%]
</select>
[%}else{%]
��δ������ʦ!
[%}%]
</script>

<script type="text/javascript">
$(function(){
	// �첽��ȡ�����б�
	var queryTeacherListAjax = function(page) {
			page = page || 1;
			if(page < 1) page = 1;

			var url = "do?action=user/teacher&start=summaryList";
			var data = {
			    page: page
			};

			$.NinTools.rendering({
				  url: url,
				  data: data,
				  renderEl : "teacherList",      // ��Ⱦ��Ԫ��id
			      templete : "teacherTemplete",  // ʹ�õ�ejsģ��id
			}, function(result){ // ��������ϵ�ص�����������result��AJAX����õ���JSON��Ӧ���ݣ�
				                   // ���ڸûص������ж�һЩ��Ⱦ���DOMԪ�ذ�һЩ�¼�,
				                   // �����ڴ˴���  SELECT Ԫ�ص���ҳ change �¼�
				  $("#teacherList select.pagination").change(function(){
					  queryTeacherListAjax($(this).val());
					});

				  // �鿴��������
				  $("#teacherList a[name='teacher']").click(function(event){
					    $.NinTools.preventDefault(event); // ����a��ǩ��Ĭ�ϵ����¼�
					    var teacherId = $(this).attr("teacherId");
					    self.location.href="doView?action=forward&start=viewTeacherInfo&teacherId="+teacherId;
			    });

				  // ɾ������
				  $("#teacherList a[name='teacherDelete']").click(function(event){
					   $.NinTools.preventDefault(event); // ����a��ǩ��Ĭ�ϵ����¼�
					   var teacherId = $(this).attr("teacherId");
					   var url = "do?action=user/teacher&start=teacherDelete";
					   var data = {"teacherId": teacherId};
					   $.post(url, data, function(result){
						   if("200" == result.code) {
							   alert("�����ɹ�");
							   queryTeacherListAjax();
							 }
						 }, "json");
		      });
			});
	};
	
	$("#logout").click(function(event){
		  $.NinTools.preventDefault(event);

		  $.post("do?action=user/user&start=logout", null, function(result){
			  if("200" == result.code) {
				  self.location.href = result.forwardUrl;
				}
			}, "JSON");
	});

	
	// load���Զ��첽��ȡ�����б�
        queryTeacherListAjax(1);
});
</script>
</html>

