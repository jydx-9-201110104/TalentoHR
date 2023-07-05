<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Login</title>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="css/Login.css">

    <!--font-awesome 核心CSS文件-->
    <link href="//cdn.bootcss.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

</head>
<body>
<div class="container">
    <div class="form row">
        <form class="form-horizontal col-sm-offset-3 col-md-offset-3">
            <h3 class="form-title">登录</h3>
            <div class="col-sm-9 col-md-9">
                <div class="form-group">
                    <i class="fa fa-user" aria-hidden="true"></i>
                    <input class="form-control" type="text" name="username" id="username" placeholder="请输入用户名" required autofocus>
                </div>
                <div class="form-group">
                    <i class="fa fa-key" aria-hidden="true"></i>
                    <input class="form-control " type="password" name="password" id="password" placeholder="请输入密码" required>
                </div>
                <div class="form-group">
                    <input onclick="login()" value="登录" class="btn btn-success pull-right">
                </div>
            </div>
        </form>

    </div>
</div>
</body>
<script>
    function login() {
        var name = $("#username").val()
        var password = $("#password").val()
        if(name === 'admin' && password === 'admin'){
            // confirm(name)
            // confirm(password)
            window.location.href="index-1.jsp"
        } else {
            confirm("账号或密码错误！！")
        }
    }
</script>
</html>