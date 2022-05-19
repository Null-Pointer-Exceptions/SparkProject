<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <base href="<%=basePath%>">
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.validate.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bs.css"/>


    <title>编辑个人信息</title>

    <script type="text/javascript">

        $(function () {
            jQuery.validator.addMethod("isMobile", function(value, element) {
                var length = value.length;
                var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
                return this.optional(element) || (length == 11 && mobile.test(value));
            }, "请正确填写手机号码");

            $("#userInfoForm").validate({
                //一失去焦点就校验
                onfocusout: function (element) {
                    $(element).valid();
                },
                errorPlacement: function (error, element) {	//错误信息位置设置方法
                    error.appendTo(element.next());//这里的error是生成的错误对象，element是录入数据的对象,parent父元素，next()下一个
                },
                errorElement: 'span',
                errorClass: "red",
                rules: {
                    identity: {
                        required: true
                    },
                    nickname: {
                        required: true
                    },
                    location: {
                        required: true
                    },
                    detailAddress: {
                        required: true
                    },
                    phone: {
                        required: true,
                        isMobile: true
                    }
                },
                messages: {
                    identity: {
                        required: "请选择"
                    },
                    nickname: {
                        required: "昵称不能为空"
                    },
                    location: {
                        required: "居住地不能为空"
                    },
                    detailAddress: {
                        required: "请填写详细地址"
                    },
                    phone: {
                        required: "请输入手机号",
                    }
                }
            });
            $("#passwordForm").validate({
                //一失去焦点就校验
                onfocusout: function (element) {
                    $(element).valid();
                },
                errorPlacement: function (error, element) {	//错误信息位置设置方法
                    error.appendTo(element.parent().next());//这里的error是生成的错误对象，element是录入数据的对象,parent父元素，next()下一个
                },
                errorClass: "red",
                rules: {
                    oldPassword: {
                        required: true,
                        rangelength: [3, 15]
                    },
                    newPassword: {
                        required: true,
                        rangelength: [3, 15]
                    },
                    rePassword: {
                        equalTo: "[name='newPassword']",
                        required: true
                    }
                },
                messages: {
                    oldPassword: {
                        required: "旧密码不能为空",
                        rangelength: "密码长度在{0}~{1}之间"
                    },
                    newPassword: {
                        required: "新密码不能为空",
                        rangelength: [3, 15]
                    },
                    rePassword: {
                        equalTo: "两次输入密码不一致",
                        required: "确认密码"
                    }
                },
                submitHandler: function(form) {
                    $.ajax({
                        type: 'post',
                        url: 'user/password/${sessionScope.loginUser.userId}',
                        data: $("#passwordForm").serialize(),
                        success: function (data) {
                            if(data.code == 200){
                                alert(data.message)
                                $('#passwordModal').modal('hide')
                            }else{
                                alert(data.message)
                            }
                            $('#oldPassword').val("");
                            $('#oldPassword').focus();
                            $('#newPassword').val("");
                            $('#rePassword').val("");
                        },
                        dataType: "json"
                    });
                }
            });
        });

        function saveUser() {
            $.ajax({
                type: 'post',
                url: 'user/update',
                data: $("#userInfoForm").serialize(),
                success: function (data) {
                    if (data.code == 200) {
                        alert(data.message)
                    } else {
                        alert("保存失败")
                    }
                },
                dataType: "json"
            });
        }

    </script>

    <style type="text/css">
        .modal.fade.in{
            top:200px;
        }
    </style>
</head>
<body>
<!--
    作者：offline
    时间：2018-10-29
    描述：top
-->
<jsp:include page="header.jsp"/>

<!--
    作者：offline
    时间：2018-10-29
    描述：logo search
-->

<div class="container">
    <form class="form-horizontal" action="user/update" role="form" id="userInfoForm" method="post">
        <div class="page-header">
            <h1>
                <span class="glyphicon glyphicon-user"></span>
                个人信息
            </h1>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-4">
                <p class="form-control-static">${sessionScope.loginUser.username}</p>
            </div>
        </div>

        <div class="form-group" style="margin-left: -33px;">
            <label for="nickName" class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="nickname" id="nickname"
                       value="${sessionScope.loginUser.nickname}" placeholder="昵称">
            </div>
        </div>

        <div class="form-group" style="margin-left: -33px;">
            <label for="phone" class="col-sm-2 control-label">电话号码:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="phone" id="phone"
                       value="${sessionScope.loginUser.phone}" placeholder="电话号码">
            </div>
        </div>

        <div class="form-group">
            <label for="location" class="col-sm-2 control-label">居住地:</label>
            <select class="form-control" name="location" id="location" style="width: 150px;">
                <option value="">请选择</option>
                <option value="北京市" ${sessionScope.loginUser.location == "北京市"? "selected":""}>北京市</option>
                <option value="天津市" ${sessionScope.loginUser.location == "天津市"? "selected":""}>天津市</option>
                <option value="河北省" ${sessionScope.loginUser.location == "河北省"? "selected":""}>河北省</option>
                <option value="山西省" ${sessionScope.loginUser.location == "山西省"? "selected":""}>山西省</option>
                <option value="内蒙古" ${sessionScope.loginUser.location == "内蒙古"? "selected":""}>内蒙古</option>
                <option value="辽宁省" ${sessionScope.loginUser.location == "辽宁省"? "selected":""}>辽宁省</option>
                <option value="吉林省" ${sessionScope.loginUser.location == "吉林省"? "selected":""}>吉林省</option>
                <option value="黑龙江" ${sessionScope.loginUser.location == "黑龙江"? "selected":""}>黑龙江</option>
                <option value="上海市" ${sessionScope.loginUser.location == "上海市"? "selected":""}>上海市</option>
                <option value="江苏省" ${sessionScope.loginUser.location == "江苏省"? "selected":""}>江苏省</option>

                <option value="浙江省" ${sessionScope.loginUser.location == "浙江省"? "selected":""}>浙江省</option>
                <option value="安徽省" ${sessionScope.loginUser.location == "安徽省"? "selected":""}>安徽省</option>
                <option value="福建省" ${sessionScope.loginUser.location == "福建省"? "selected":""}>福建省</option>
                <option value="江西省" ${sessionScope.loginUser.location == "江西省"? "selected":""}>江西省</option>
                <option value="山东省" ${sessionScope.loginUser.location == "山东省"? "selected":""}>山东省</option>
                <option value="河南省" ${sessionScope.loginUser.location == "河南省"? "selected":""}>河南省</option>
                <option value="湖北省" ${sessionScope.loginUser.location == "湖北省"? "selected":""}>湖北省</option>
                <option value="湖南省" ${sessionScope.loginUser.location == "湖南省"? "selected":""}>湖南省</option>
                <option value="广东省" ${sessionScope.loginUser.location == "广东省"? "selected":""}>广东省</option>
                <option value="海南省" ${sessionScope.loginUser.location == "海南省"? "selected":""}>海南省</option>

                <option value="重庆市" ${sessionScope.loginUser.location == "重庆市"? "selected":""}>重庆市</option>
                <option value="四川省" ${sessionScope.loginUser.location == "四川省"? "selected":""}>四川省</option>
                <option value="贵州省" ${sessionScope.loginUser.location == "贵州省"? "selected":""}>贵州省</option>
                <option value="云南省" ${sessionScope.loginUser.location == "云南省"? "selected":""}>云南省</option>
                <option value="陕西省" ${sessionScope.loginUser.location == "陕西省"? "selected":""}>陕西省</option>
                <option value="甘肃省" ${sessionScope.loginUser.location == "甘肃省"? "selected":""}>甘肃省</option>
                <option value="青海省" ${sessionScope.loginUser.location == "青海省"? "selected":""}>青海省</option>
                <option value="宁夏" ${sessionScope.loginUser.location == "宁夏"? "selected":""}>宁夏</option>
                <option value="新疆" ${sessionScope.loginUser.location == "新疆"? "selected":""}>新疆</option>
                <option value="西藏" ${sessionScope.loginUser.location == "西藏"? "selected":""}>西藏</option>
            </select>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">性别:</label>
            <label class="radio-inline">
                <input type="radio" name="gender" id="man"
                       value="1" ${sessionScope.loginUser.gender == "1"? "checked":""} > 男
            </label>
            <label class="radio-inline">
                <input type="radio" name="gender" id="woman"
                       value="0" ${sessionScope.loginUser.gender == "0"? "checked":""} > 女
            </label>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">身份:</label>
            <label class="radio-inline">
                <input type="radio" name="identity" id="student"
                       value="学生" ${sessionScope.loginUser.identity == "学生"? "checked":""}> 学生
            </label>
            <label class="radio-inline">
                <input type="radio" name="identity" id="teacher"
                       value="教师" ${sessionScope.loginUser.identity == "教师"? "checked":""}> 教师
            </label>
            <label class="radio-inline">
                <input type="radio" name="identity" id="worker"
                       value="上班族" ${sessionScope.loginUser.identity == "上班族"? "checked":""}> 上班族
            </label>
            <label class="radio-inline">
                <input type="radio" name="identity" id="liberal"
                       value="自由职业" ${sessionScope.loginUser.identity == "自由职业"? "checked":""}> 自由职业
            </label>
        </div>

        <div class="page-header">
            <h1>
                <span class="glyphicon glyphicon-home"></span>
                收货地址
            </h1>
        </div>
        <div class="form-group">
            <label for="detailAddress" class="col-sm-2 control-label">详细住址:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="detailAddress" id="detailAddress"
                       value="${sessionScope.loginUser.detailAddress }" placeholder="详细住址:">
            </div>
        </div>
        <%-- <div class="page-header">
             <h1>
                 <span class="glyphicon glyphicon-cog"></span>
                 安全中心
             </h1>
         </div>--%>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" onclick="saveUser();" class="btn btn-default">保存基本信息</button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#passwordModal">修改密码</button>
                <span class="red">${saveMsg}</span>
            </div>
        </div>
    </form>

        <!-- 模态框（Modal） -->
        <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="passwordModalLabel">修改密码</h4>
                    </div>
                    <form method="post" id="passwordForm">
                    <div class="modal-body" style="height: 200px">
                            <table style="width: 400px;height: 130px">
                                <tr>
                                    <td>旧密码:</td>
                                    <td><input type="password" id="oldPassword" name="oldPassword"></td>
                                    <td style="width: 150px"></td>
                                </tr>
                                <tr>
                                    <td>新密码:</td>
                                    <td><input type="password" id="newPassword" name="newPassword"></td>
                                    <td style="width: 150px"></td>
                                </tr>
                                <tr>
                                    <td>确认密码:</td>
                                    <td><input type="password" id="rePassword" name="rePassword"></td>
                                    <td style="width: 150px"></td>
                                </tr>
                            </table>
                    </div>
                    <div class="modal-footer">
                        <span id="changePwd"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-primary">提交更改</button>
                    </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>



</div>
</body>
</html>
