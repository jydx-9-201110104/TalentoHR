<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>薪资管理列表</title>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
	<script type="text/javascript"
			src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
	<link
			href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
			rel="stylesheet">
	<script
			src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工修改的模态框 -->
<div class="modal fade" id="saUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">薪资修改</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="empName_update_static"></p>
						</div>
					</div>
<%--					<div class="form-group">--%>
<%--						<label class="col-sm-2 control-label">部门</label>--%>
<%--						<div class="col-sm-10">--%>
<%--							<p class="form-control-static" id="deptName_update_static"></p>--%>
<%--						</div>--%>
<%--					</div>--%>
					<div class="form-group">
						<label class="col-sm-2 control-label">基础工资</label>
						<div class="col-sm-10">
							<input type="text" name="baseSalary" class="form-control" id="base_update_input" >
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">保险</label>
						<div class="col-sm-10">
							<input type="text" name="insurance" class="form-control" id="insurance_update_input" >
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">奖金</label>
						<div class="col-sm-10">
							<input type="text" name="bonus" class="form-control" id="bonus_update_input" >
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">税前工资</label>
						<div class="col-sm-10">
							<input type="text" name="beforeSalary" class="form-control" id="before_update_input" >
							<span class="help-block"></span>
						</div>
					</div>
<%--					<div class="form-group">--%>
<%--						<label class="col-sm-2 control-label">部门</label>--%>
<%--						<div class="col-sm-4">--%>
<%--							<!-- 部门提交部门id即可 -->--%>
<%--							<select class="form-control" name="dId">--%>
<%--							</select>--%>
<%--						</div>--%>
<%--					</div>--%>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="sa_update_btn">更新</button>
			</div>
		</div>
	</div>
</div>



<!-- 搭建显示页面 -->
<div class="container">
	<!-- 标题 -->
	<div class="row">
		<div class="col-md-12">
			<h1>Salary-CRUD</h1>
		</div>
	</div>

	<!-- 显示表格数据 -->
	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover" id="sas_table">
				<thead>
				<tr>
					<th>id</th>
					<th>姓名</th>
<%--					<th>部门</th>--%>
					<th>基础工资</th>
					<th>保险</th>
					<th>奖金</th>
					<th>税前工资</th>
					<th>实际工资</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>

	<!-- 显示分页信息 -->
	<div class="row">
		<!--分页文字信息  -->
		<div class="col-md-6" id="page_info_area"></div>
		<!-- 分页条信息 -->
		<div class="col-md-6" id="page_nav_area">

		</div>
	</div>

</div>
<script type="text/javascript">

	var totalRecord,currentPage;
	//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
	$(function(){
		//去首页
		to_pageSa(1);
	});

	function to_pageSa(pn){
		$.ajax({
			url:"${APP_PATH}/sas",
			data:"pn="+pn,
			type:"GET",
			success:function(result){
				//1、解析并显示员工数据
				build_sas_table(result);
				//2、解析并显示分页信息
				build_page_info(result);
				//3、解析显示分页条数据
				build_page_nav(result);
				console.log(result);
			}
		});
	}

	function build_sas_table(result){
		//清空table表格
		$("#sas_table tbody").empty();
		var sas = result.extend.pageInfo.list;
		$.each(sas,function(index,item){
			// var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			// var deptNameTd = $("<td></td>").append(item.department.deptName);
			var baseSalaryTd = $("<td></td>").append(item.baseSalary);
			var bonusTd = $("<td></td>").append(item.bonus);
			var insuranceTd = $("<td></td>").append(item.insurance);
			var beforeSalaryTd = $("<td></td>").append(item.beforeSalary);
			var afterSalaryTd = $("<td></td>").append(item.afterSalary);

			/**
			 <button class="">
			 <span class="" aria-hidden="true"></span>
			 编辑
			 </button>
			 */
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
			//为编辑按钮添加一个自定义的属性，来表示当前员工id
			editBtn.attr("edit-id",item.empId);

			// var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
			// 		.append($("<span></span>").addClass("glyphicon glyphicon-trash"));
			// .append("删除");
			//为删除按钮添加一个自定义的属性来表示当前删除的员工id
			// delBtn.attr("del-id",item.empId);
			var btnSaTd = $("<td></td>").append(editBtn).append(" ");
			// .append(delBtn);
			// ;
			//var delBtn =
			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					// .append(deptNameTd)
					.append(baseSalaryTd)
					.append(bonusTd)
					.append(insuranceTd)
					.append(beforeSalaryTd)
					.append(afterSalaryTd)
					.append(btnSaTd)
					.appendTo("#sas_table tbody");
		});
	}
	//解析显示分页信息
	function build_page_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
				result.extend.pageInfo.pages+"页,总"+
				result.extend.pageInfo.total+"条记录");
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}

	//解析显示分页条，点击分页要能去下一页....
	function build_page_nav(result){
		//page_nav_area
		$("#page_nav_area").empty();
		var ul = $("<ul></ul>").addClass("pagination");

		//构建元素
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage == false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			//为元素添加点击翻页的事件
			firstPageLi.click(function(){
				to_pageSa(1);
			});
			prePageLi.click(function(){
				to_pageSa(result.extend.pageInfo.pageNum -1);
			});
		}



		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage == false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			nextPageLi.click(function(){
				to_pageSa(result.extend.pageInfo.pageNum +1);
			});
			lastPageLi.click(function(){
				to_pageSa(result.extend.pageInfo.pages);
			});
		}



		//添加首页和前一页 的提示
		ul.append(firstPageLi).append(prePageLi);
		//1,2，3遍历给ul中添加页码提示
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){

			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_pageSa(item);
			});
			ul.append(numLi);
		});
		//添加下一页和末页 的提示
		ul.append(nextPageLi).append(lastPageLi);

		//把ul加入到nav
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}

	//清空表单样式及内容
	function reset_form(ele){
		$(ele)[0].reset();
		//清空表单样式
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
	}

	// //点击新增按钮弹出模态框。
	// $("#emp_add_modal_btn").click(function(){
	// 	//清除表单数据（表单完整重置（表单的数据，表单的样式））
	// 	reset_form("#empAddModal form");
	// 	//s$("")[0].reset();
	// 	//发送ajax请求，查出部门信息，显示在下拉列表中
	// 	getDepts("#empAddModal select");
	// 	//弹出模态框
	// 	$("#empAddModal").modal({
	// 		backdrop:"static"
	// 	});
	// });

	//查出所有的部门信息并显示在下拉列表中
	<%--function getDepts(ele){--%>
	<%--	//清空之前下拉列表的值--%>
	<%--	$(ele).empty();--%>
	<%--	$.ajax({--%>
	<%--		url:"${APP_PATH}/Depts",--%>
	<%--		type:"GET",--%>
	<%--		success:function(result){--%>
	<%--			//{"code":100,"msg":"处理成功！",--%>
	<%--			//"extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}--%>
	<%--			//console.log(result);--%>
	<%--			//显示部门信息在下拉列表中--%>
	<%--			//$("#empAddModal select").append("")--%>
	<%--			$.each(result.extend.depts,function(){--%>
	<%--				var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);--%>
	<%--				optionEle.appendTo(ele);--%>
	<%--			});--%>
	<%--		}--%>
	<%--	});--%>

	<%--}--%>




	//1、我们是按钮创建之前就绑定了click，所以绑定不上。
	//1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
	//jquery新版没有live，使用on进行替代
	$(document).on("click",".edit_btn",function(){
		//alert("edit");
		//1、查出部门信息，并显示部门列表
		// getDepts("#saUpdateModal select");
		//2、查出员工信息，显示员工信息
		getSa($(this).attr("edit-id"));

		//3、把员工的id传递给模态框的更新按钮
		$("#sa_update_btn").attr("edit-id",$(this).attr("edit-id"));
		$("#saUpdateModal").modal({
			backdrop:"static"
		});
	});
	// 数据回显
	function getSa(id){
		$.ajax({
			url:"${APP_PATH}/sa/"+id,
			type:"GET",
			success:function(result){

				var saData = result.extend.sa;
				console.log(saData);
				$("#empName_update_static").text(saData.empName);
				// $("#deptName_update_static").text(saData.department.deptName);
				$("#base_update_input").val(saData.baseSalary);
				$("#insurance_update_input").val(saData.insurance);
				$("#bonus_update_input").val(saData.bonus);
				$("#before_update_input").val(saData.beforeSalary);
			}
		});
	}

	//点击更新，更新员工信息
	$("#sa_update_btn").click(function(){
		//2、发送ajax请求保存更新的员工数据
		$.ajax({
			url:"${APP_PATH}/sa/"+$(this).attr("edit-id"),
			type:"PUT",
			data:$("#saUpdateModal form").serialize(),
			success:function(result){
				alert(result.msg);
				//1、关闭对话框
				$("#saUpdateModal").modal("hide");
				//2、回到本页面
				to_pageSa(currentPage);
			}
		});
	});

</script>
</body>
</html>