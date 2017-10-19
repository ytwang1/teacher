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
    <title>主页</title>
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
  <a href="doView?action=forward&start=toCreate">新增教师</a>
  <a href="#" id="logout">退出系统</a><br/><br/>
  <%-- 博文列表容器，用于装载待渲染的内容 --%>
  <div id="teacherList"></div>
</div>
</body>
<%-- 博文列表模板，用于EJS渲染，装载具体数据的容器变量名称 list， 详见 jquery.NinTools.js 中的 rendering --%>
<script type="text/javascript" id="teacherTemplete">
<table class="table table-striped table-hover">
<th>教师列表</th>
<th>操作</th>

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
	<span class="font-1">共&nbsp;[%=totalCount%]&nbsp;名教师</span>
<select class="pagination">
  [%
    var totalPage = parseInt((totalCount+countPerPage-1) / countPerPage);
   %]
  [%for(var page=1; page<=totalPage; page++){%]
	<option value="[%=page%]" [%if(page==curPage){%]selected="selected"[%}%]>第[%=page%]页</option>
  [%}%]
</select>
[%}else{%]
尚未新增教师!
[%}%]
</script>

<script type="text/javascript">
$(function(){
	// 异步获取博文列表
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
				  renderEl : "teacherList",      // 渲染的元素id
			      templete : "teacherTemplete",  // 使用的ejs模版id
			}, function(result){ // 匿名函数系回调函数，其中result是AJAX请求得到的JSON响应数据，
				                   // 可在该回调函数中对一些渲染后的DOM元素绑定一些事件,
				                   // 例如在此处绑定  SELECT 元素的跳页 change 事件
				  $("#teacherList select.pagination").change(function(){
					  queryTeacherListAjax($(this).val());
					});

				  // 查看博文内容
				  $("#teacherList a[name='teacher']").click(function(event){
					    $.NinTools.preventDefault(event); // 禁用a标签的默认单击事件
					    var teacherId = $(this).attr("teacherId");
					    self.location.href="doView?action=forward&start=viewTeacherInfo&teacherId="+teacherId;
			    });

				  // 删除博文
				  $("#teacherList a[name='teacherDelete']").click(function(event){
					   $.NinTools.preventDefault(event); // 禁用a标签的默认单击事件
					   var teacherId = $(this).attr("teacherId");
					   var url = "do?action=user/teacher&start=teacherDelete";
					   var data = {"teacherId": teacherId};
					   $.post(url, data, function(result){
						   if("200" == result.code) {
							   alert("操作成功");
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

	
	// load后，自动异步获取博文列表
        queryTeacherListAjax(1);
});
</script>
</html>

