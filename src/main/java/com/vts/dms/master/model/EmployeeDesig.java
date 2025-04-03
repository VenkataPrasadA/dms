package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table (name="employee_desig")
public class EmployeeDesig {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DesigId;
	private String DesigCode;
	private String Designation;
	private Long DesigLimit;
	public Long getDesigId() {
		return DesigId;
	}
	public void setDesigId(Long desigId) {
		DesigId = desigId;
	}
	public String getDesigCode() {
		return DesigCode;
	}
	public void setDesigCode(String desigCode) {
		DesigCode = desigCode;
	}
	public String getDesignation() {
		return Designation;
	}
	public void setDesignation(String designation) {
		Designation = designation;
	}
	public Long getDesigLimit() {
		return DesigLimit;
	}
	public void setDesigLimit(Long desigLimit) {
		DesigLimit = desigLimit;
	}
	
	
	
	
}
