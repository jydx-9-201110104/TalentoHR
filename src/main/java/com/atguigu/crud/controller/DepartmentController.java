package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * 处理和部门有关的请求
 * @author lfy
 *
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;

	/**
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 *
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/dept/{ids}",method= RequestMethod.DELETE)
	public Msg deleteDept(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			departmentService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			departmentService.deleteDept(id);
		}
		return Msg.success();
	}

	@ResponseBody
	@RequestMapping(value="/dept/{deptId}",method=RequestMethod.PUT)
	public Msg savedept(Department department, HttpServletRequest request){
		System.out.println("将要更新的部门数据："+ department);
		departmentService.updateDept(department);
		return Msg.success();
	}

	@RequestMapping(value="/dept",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveDept(@Valid Department department, BindingResult result){
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
			departmentService.saveDept(department);
			return Msg.success();
		}

	}

	/**
	 * 根据id查询部门
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/dept/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getDept(@PathVariable("id")Integer id){

		Department department = departmentService.getDept(id);
		return Msg.success().add("dept", department);
	}

	/**
	 * 检查部门名是否可用
	 * @param deptName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkdept")
	public Msg checkdept(@RequestParam("deptName")String deptName){
		//先判断用户名是否是合法的表达式;
		String regx = "^[\u2E80-\u9FFF]{2,5}";
		if(!deptName.matches(regx)){
			return Msg.fail().add("va_msg", "部门名称必须是2-5位中文");
		}

		//数据库用户名重复校验
		boolean b = departmentService.checkUser(deptName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "部门名不可用");
		}
	}

	/**
	 * 返回所有的部门信息
	 */
	@RequestMapping("/Depts")
	@ResponseBody
	public Msg getDepts(){
		//查出的所有部门信息
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDeptsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Department> depts = departmentService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(depts, 5);
		return Msg.success().add("pageInfo", page);
	}

}
