package com.vts.dms.master.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="project_master")
public class ProjectMaster implements Serializable {
	
	@Id
	private int ProjectId;
	private String ProjectCode;
	private String ProjectName;
	private String ProjectDescription;
	private int DivisionId;
	private String AuthorityNo;
	private String AuthorityDate;
	private String PDC;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public int getProjectId() {
		return ProjectId;
	}
	public void setProjectId(int projectId) {
		ProjectId = projectId;
	}
	public String getProjectCode() {
		return ProjectCode;
	}
	public void setProjectCode(String projectCode) {
		ProjectCode = projectCode;
	}
	public String getProjectName() {
		return ProjectName;
	}
	public void setProjectName(String projectName) {
		ProjectName = projectName;
	}
	public String getProjectDescription() {
		return ProjectDescription;
	}
	public void setProjectDescription(String projectDescription) {
		ProjectDescription = projectDescription;
	}
	public int getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(int divisionId) {
		DivisionId = divisionId;
	}
	public String getAuthorityNo() {
		return AuthorityNo;
	}
	public void setAuthorityNo(String authorityNo) {
		AuthorityNo = authorityNo;
	}
	public String getAuthorityDate() {
		return AuthorityDate;
	}
	public void setAuthorityDate(String authorityDate) {
		AuthorityDate = authorityDate;
	}
	public String getPDC() {
		return PDC;
	}
	public void setPDC(String pDC) {
		PDC = pDC;
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
