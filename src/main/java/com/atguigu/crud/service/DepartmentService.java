package com.atguigu.crud.service;

import java.util.List;

import com.atguigu.crud.bean.DepartmentExample;
import com.atguigu.crud.bean.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	DepartmentMapper departmentMapper;

	public void deleteBatch(List<Integer> ids) {
		DepartmentExample example = new DepartmentExample();
		DepartmentExample.Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andDeptIdIn(ids);
		departmentMapper.deleteByExample(example);
	}

	public void deleteDept(Integer id) {
		departmentMapper.deleteByPrimaryKey(id);
	}

	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

	public void updateDept(Department department) {
		departmentMapper.updateByPrimaryKeySelective(department);
	}

	public boolean checkUser(String deptName) {
		DepartmentExample example = new DepartmentExample();
		DepartmentExample.Criteria criteria = example.createCriteria();
		criteria.andDeptNameEqualTo(deptName);
		long count = departmentMapper.countByExample(example);
		return count==0;
	}

	public Department getDept(Integer id) {
		Department department = departmentMapper.selectByPrimaryKey(id);
		return department;
	}

	public List<Department> getAll() {
		return departmentMapper.selectByExample(null);
	}

	public void saveDept(Department department) {
		departmentMapper.insertSelective(department);
	}
}
