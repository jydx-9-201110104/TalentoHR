package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.validation.Valid;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Salary;
import com.atguigu.crud.service.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工CRUD请求
 *
 * @author lfy
 *
 */
@Controller
public class SalaryController {

	@Autowired
	SalaryService salaryService;

	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/sa/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getsa(@PathVariable("id")Integer id){

		Salary salary = salaryService.getSa(id);
		return Msg.success().add("sa", salary);
	}


	/**
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工薪资更新方法
	 * @param salary
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/sa/{empId}",method=RequestMethod.PUT)
	public Msg savesa(Salary salary,HttpServletRequest request){
//		request.getParameter("");
//		System.out.println("请求体中的值："+request.getParameter("baseSalary"));
		salaryService.updateSa(salary);
		return Msg.success();
	}
	
	/**
	 * 员工保存
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 *
	 *
	 * @return
	 */
	@RequestMapping(value="/sa",method=RequestMethod.POST)
	@ResponseBody
	public Msg savesa(@Valid Salary salary,BindingResult result){
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			salaryService.saveSa(salary);
			return Msg.success();
		}

	}

	/**
	 * 导入jackson包，查询所有。
	 * @param pn
	 * @return
	 */
	@RequestMapping("/sas")
	@ResponseBody
	public Msg getSasWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Salary> sas = salaryService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page =new PageInfo(sas, 5);
		return Msg.success().add("pageInfo", page);
	}

	/**
	 * 查询员工数据（分页查询）
	 *
	 * @return
	 */
//	 @RequestMapping("/sas")
	public String getSas(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) {
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Salary> sas = salaryService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(sas, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}

}
