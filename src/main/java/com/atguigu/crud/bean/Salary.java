package com.atguigu.crud.bean;

public class Salary {
    private Integer empId;

    private String empName;

    private String deptName;

    private Integer baseSalary;

    private Integer bonus;

    private Float insurance;

    private Float beforeSalary;

    private Float afterSalary;

    private Department department;

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

    public Integer getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(Integer baseSalary) {
        this.baseSalary = baseSalary;
    }

    public Integer getBonus() {
        return bonus;
    }

    public void setBonus(Integer bonus) {
        this.bonus = bonus;
    }

    public Float getInsurance() {
        return insurance;
    }

    public void setInsurance(Float insurance) {
        this.insurance = insurance;
    }

    public Float getBeforeSalary() {
        return beforeSalary;
    }

    public void setBeforeSalary(Float beforeSalary) {
        this.beforeSalary = beforeSalary;
    }

    public Float getAfterSalary() {
        return afterSalary;
    }

    public void setAfterSalary(Float afterSalary) {
        this.afterSalary = afterSalary;
    }
}