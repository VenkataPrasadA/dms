package com.vts.dms.admin.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="form_role")
public class FormRole implements Serializable {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long FormRoleId ;
	private String FormRoleName ;
	private int IsActive ;
	private String CreatedBy ;
	private String CreatedDate;
	private String ModifiedBy ;
	private String ModifiedDate;
	public Long getFormRoleId() {
		return FormRoleId;
	}
	public void setFormRoleId(Long formRoleId) {
		FormRoleId = formRoleId;
	}
	public String getFormRoleName() {
		return FormRoleName;
	}
	public void setFormRoleName(String formRoleName) {
		FormRoleName = formRoleName;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
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
