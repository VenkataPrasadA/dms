package com.vts.dms.admin.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="dak_form_detail")
public class FormDetail implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FormDetailId ;
	private Long FormModuleId ;
	private String FormName ;
	private String FormDispName ;
	private String FormUrl ;
	private Long FormSerialNo ;
	private int IsActive ;
	private String ModifiedBy ;
	private String ModifiedDate;
	public Long getFormDetailId() {
		return FormDetailId;
	}
	public void setFormDetailId(Long formDetailId) {
		FormDetailId = formDetailId;
	}
	public Long getFormModuleId() {
		return FormModuleId;
	}
	public void setFormModuleId(Long formModuleId) {
		FormModuleId = formModuleId;
	}
	public String getFormName() {
		return FormName;
	}
	public void setFormName(String formName) {
		FormName = formName;
	}
	public String getFormDispName() {
		return FormDispName;
	}
	public void setFormDispName(String formDispName) {
		FormDispName = formDispName;
	}
	public String getFormUrl() {
		return FormUrl;
	}
	public void setFormUrl(String formUrl) {
		FormUrl = formUrl;
	}
	public Long getFormSerialNo() {
		return FormSerialNo;
	}
	public void setFormSerialNo(Long formSerialNo) {
		FormSerialNo = formSerialNo;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
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
