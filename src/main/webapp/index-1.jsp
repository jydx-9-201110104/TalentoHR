<%--
  Created by IntelliJ IDEA.
  User: 0.0
  Date: 2023/7/4
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test</title>
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

    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li id="ssm" class="active"><a id="EmpA" href="emp.jsp" target="myIframe" >EMP-CRUD<span class="sr-only">(current)</span></a></li>
                    <li id="dept"><a id="DeptA" href="dept.jsp" target="myIframe">Dept—CRUD</a></li>
                    <li id="salary"><a id="salaryA" href="salary.jsp" target="myIframe">Salary—CRUD</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</head>
<body>
<div class="container">
    <h5>
        欢迎来到企业人员管理系统
    </h5>
    <iframe style="width: 100%;height: 600px" name="myIframe" src="emp.jsp"></iframe>
</div>
</body>
<script>
    $(document).ready(function () {
        //遍历li标签，从而获取下面a标签的href，这里为了方便说明选用的是.nav类，在实际应用中可以使用id代替
        $('.nav').find('li').each(function () {
            var a = $(this).find('a:first')[0];
            // 判断a标签的href是否与当前页面的路径相同
            if ($(a).attr("href") === location.pathname) {
                $(this).addClass("active");
            } else {
                $(this).removeClass("active");
            }
        })
    })
</script>
</html>
