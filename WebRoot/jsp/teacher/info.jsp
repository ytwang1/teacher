<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="cn.netinnet.qdk.util.RequestUtil"%>
<%@page import="cn.netinnet.qdk.util.SessionUtil"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String teacherId = RequestUtil.getVarStringValue(request, "teacherId");
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
            width: 400px;
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
    <form name="teacherForm">
        <div>
            <span>�˺�:</span>
            <input type="text" name="teacherAccount" class="speciedWidth" />
        </div>
        <div>
            <span>����:</span>
            <input type="text" name="teacherName" class="speciedWidth" />
        </div>
        <div>
            <span>�Ա�:</span>
            <input type="text" name="teacherSex" class="speciedWidth" />
        </div>
        <div>
            <span>�绰:</span>
            <input type="text" name="teacherPhone" class="speciedWidth" />
        </div>
        <div>
            <span>����:</span>
            <input type="text" name="teacherEmail" class="speciedWidth" />
        </div>
        <div>
            <input type="submit" id="infoBtn" value="�޸�" class="btn btn-success" />
        </div>
    </form>
</div>
</body>
<script type="text/javascript">
    $(function(){
        var teacherId = "<%=teacherId %>";
        $("#infoBtn").click(function(event){
            $.NinTools.preventDefault(event);

            var teacherAccount = $.trim(teacherForm.teacherAccount.value);
            var teacherName = $.trim(teacherForm.teacherName.value);
            var teacherSex = $.trim(teacherForm.teacherSex.value);
            var teacherPhone = $.trim(teacherForm.teacherPhone.value);
            var teacherEmail = $.trim(teacherForm.teacherEmail.value);

            if(0 >= teacherAccount.length) {
                alert("��ʦ����Ϊ��");
                return false;
            }

            // AJAX �ύ
            var url = "do?action=user/teacher&start=info";
            var data = {
                "teacherId": teacherId,
                "teacherAccount": teacherAccount,
                "teacherName": teacherName,
                "teacherSex": teacherSex,
                "teacherPhone": teacherPhone,
                "teacherEmail": teacherEmail
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
                        self.location.href = result.forwardUrl;
                    } else {
                        alert("ʧ��");
                    }
                }
            });

            return false;
        });

        var load = function() {
            var url = "do?action=user/teacher&start=teacherDetail";
            var data = {"teacherId": teacherId};

            // �첽��ȡ���ľ�������
            $.post(url, data, function(result){
                teacherForm.teacherAccount.value = result.teacherAccount;
                teacherForm.teacherName.value = result.teacherName;
                teacherForm.teacherSex.value = result.teacherSex;
                teacherForm.teacherPhone.value = result.teacherPhone;
                teacherForm.teacherEmail.value = result.teacherEmail;
            }, "json");
        };

        // load��ɺ�ִ��
        load();
    });
</script>
</html>
