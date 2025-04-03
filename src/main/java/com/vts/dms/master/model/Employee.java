package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="employee")
public class Employee {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long EmpId;
	private String EmpNo;
	private String EmpName;
	private Long DesigId;
	private String ExtNo;
	private String Email;
	private Long DivisionId;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public String getEmpNo() {
		return EmpNo;
	}
	public void setEmpNo(String empNo) {
		EmpNo = empNo;
	}
	public String getEmpName() {
		return EmpName;
	}
	public void setEmpName(String empName) {
		EmpName = empName;
	}
	public Long getDesigId() {
		return DesigId;
	}
	public void setDesigId(Long desigId) {
		DesigId = desigId;
	}
	public String getExtNo() {
		return ExtNo;
	}
	public void setExtNo(String extNo) {
		ExtNo = extNo;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public Long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(Long divisionId) {
		DivisionId = divisionId;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
}
