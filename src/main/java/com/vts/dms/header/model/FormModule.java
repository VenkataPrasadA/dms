package com.vts.dms.header.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="dak_form_module")
public class FormModule implements Serializable {
	
	
	@Id
	private Long FormModuleId ;
	private String FormModuleName ;
	private String ModuleUrl ;
	private String ModuleIcon ;
	private Long SerialNo ;
	private int IsActive ;
	public Long getFormModuleId() {
		return FormModuleId;
	}
	public void setFormModuleId(Long formModuleId) {
		FormModuleId = formModuleId;
	}
	public String getFormModuleName() {
		return FormModuleName;
	}
	public void setFormModuleName(String formModuleName) {
		FormModuleName = formModuleName;
	}
	public Long getSerialNo() {
		return SerialNo;
	}
	public void setSerialNo(Long serialNo) {
		SerialNo = serialNo;
	}
	
	public String getModuleUrl() {
		return ModuleUrl;
	}
	public void setModuleUrl(String moduleUrl) {
		ModuleUrl = moduleUrl;
	}
	public String getModuleIcon() {
		return ModuleIcon;
	}
	public void setModuleIcon(String moduleIcon) {
		ModuleIcon = moduleIcon;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
	
	
}
