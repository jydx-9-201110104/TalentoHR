package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Salary;
import com.atguigu.crud.bean.SalaryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SalaryMapper {
    int countByExample(SalaryExample example);

    int deleteByExample(SalaryExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Salary record);

    int insertSelective(Salary record);

    List<Salary> selectByExampleWithDept(SalaryExample example);

    Salary selectByPrimaryKey(Integer empId);

    int updateByExampleSelective(@Param("record") Salary record, @Param("example") SalaryExample example);

    int updateByExample(@Param("record") Salary record, @Param("example") SalaryExample example);

    int updateByPrimaryKeySelective(Salary record);

    int updateByPrimaryKey(Salary record);
}