package com.atguigu.crud.service;

import com.atguigu.crud.bean.Salary;
import com.atguigu.crud.bean.SalaryExample;
import com.atguigu.crud.bean.SalaryExample.Criteria;
import com.atguigu.crud.bean.Salary;
import com.atguigu.crud.dao.SalaryMapper;
import com.atguigu.crud.dao.SalaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalaryService {
	
	@Autowired
	SalaryMapper salaryMapper;

	/**
	 * 查询所有员工工资
	 * @return
	 */
	public List<Salary> getAll() {
		// TODO Auto-generated method stub
		return salaryMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工薪资保存
	 * @param salary
	 */
	public void saveSa(Salary salary) {
		// TODO Auto-generated method stub
		salaryMapper.insertSelective(salary);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param SaName
	 * @return  true：代表当前姓名可用   fasle：不可用
	 */
	public boolean checkUser(String SaName) {
		// TODO Auto-generated method stub
		SalaryExample example = new SalaryExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(SaName);
		long count = salaryMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */
	public Salary getSa(Integer id) {
		// TODO Auto-generated method stub
		Salary salary = salaryMapper.selectByPrimaryKey(id);
		return salary;
	}

	/**
	 * 员工更新
	 * @param salary
	 */
	public void updateSa(Salary salary) {
		// TODO Auto-generated method stub
		float num = salary.getBaseSalary()+salary.getBonus()-salary.getInsurance();//计算税前工资
		salary.setBeforeSalary(num);
		salaryMapper.updateByPrimaryKeySelective(salary);
	}

	/**
	 * 员工删除
	 * @param id
	 */
	public void deleteSa(Integer id) {
		// TODO Auto-generated method stub
		salaryMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		SalaryExample example = new SalaryExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where Sa_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		salaryMapper.deleteByExample(example);
	}

}
