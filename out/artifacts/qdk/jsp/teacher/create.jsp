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
    <title>新增教师</title>
    <style type="text/css">
        form {
            width: 660px;
            text-align: center;
            margin: 10px auto;
        }
        form > div {
            padding: 5px;
        }
        .speciedWidth {
            width: 400px;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="/jsp/public/Javascript.jsp"></jsp:include>
</head>
<body>
<form name="publishForm">
    <a href="doView?action=forward&start=toMain">返回</a>
    <div>
        <span>账号:</span>
        <input type="text" name="teacherAccount" class="speciedWidth" placeholder="请输入账号" />
    </div>
    <div>
        <span>姓名:</span>
        <input type="text" name="teacherName" class="speciedWidth" placeholder="请输入姓名" />
    </div>
    <div>
        <span>性别：</span><input type="radio" name="teacherSex" value="1" id="sexM" checked="checked" /><label for="sexM">男</label><input type="radio" name="teacherSex" value="0" id="sexW" /><label for="sexW">女</label>
    </div>
    <div>
        <span>电话:</span>
        <input type="text" name="teacherPhone" class="speciedWidth" placeholder="请输入电话" />
    </div>
    <div>
        <span>邮箱:</span>
        <input type="text" name="teacherEmail" class="speciedWidth" placeholder="请输入邮箱" />
    </div>
    <div>
        <input type="submit" id="publishBtn" value="发表" class="btn btn-success" />
        <input type="reset" value="清空" class="btn btn-warning" />
    </div>
</form>
</body>
<script type="text/javascript">
    $(function(){
        $("#publishBtn").click(function(event){
            $.NinTools.preventDefault(event);

            var teacherAccount = $.trim(publishForm.teacherAccount.value);
            var teacherName = $.trim(publishForm.teacherName.value);
            var teacherSex = $.trim(publishForm.teacherSex.value);
            var teacherPhone = $.trim(publishForm.teacherPhone.value);
            var teacherEmail = $.trim(publishForm.teacherEmail.value);

            if(0 >= teacherAccount.length) {
                alert("账号不能为空");
                return false;
            }

            // AJAX 提交
            var url = "do?action=user/teacher&start=generateRandomInfo";
            var data = {
                "teacherAccount": teacherAccount,
                "teacherName": teacherName,
                "teacherSex": teacherSex,
                "teacherPhone": teacherPhone,
                "teacherEmail" : teacherEmail
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
                        alert("教师新增成功");
                        self.location.href = result.forwardUrl;
                    } else {
                        alert("失败");
                    }
                }
            });

            return false;
        });
    });
</script>
</html>

