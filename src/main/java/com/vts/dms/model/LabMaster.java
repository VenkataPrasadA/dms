package com.vts.dms.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="lab_master")
public class LabMaster implements Serializable {

	@Id
	private int LabMasterId;
	private String LabCode;
	private String LabName;
	private String LabUnitCode;
	private String LabAddress;
	private String LabCity;
	private String LabPin;
	private String LabTelNo;
	private String LabFaxNo;
	private String LabEmail;
	
	public String getLabTelNo() {
		return LabTelNo;
	}
	public void setLabTelNo(String labTelNo) {
		LabTelNo = labTelNo;
	}
	public String getLabFaxNo() {
		return LabFaxNo;
	}
	public void setLabFaxNo(String labFaxNo) {
		LabFaxNo = labFaxNo;
	}
	public String getLabEmail() {
		return LabEmail;
	}
	public void setLabEmail(String labEmail) {
		LabEmail = labEmail;
	}
	public int getLabMasterId() {
		return LabMasterId;
	}
	public void setLabMasterId(int labMasterId) {
		LabMasterId = labMasterId;
	}
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public String getLabName() {
		return LabName;
	}
	public void setLabName(String labName) {
		LabName = labName;
	}
	public String getLabUnitCode() {
		return LabUnitCode;
	}
	public void setLabUnitCode(String labUnitCode) {
		LabUnitCode = labUnitCode;
	}
	public String getLabAddress() {
		return LabAddress;
	}
	public void setLabAddress(String labAddress) {
		LabAddress = labAddress;
	}
	public String getLabCity() {
		return LabCity;
	}
	public void setLabCity(String labCity) {
		LabCity = labCity;
	}
	public String getLabPin() {
		return LabPin;
	}
	public void setLabPin(String labPin) {
		LabPin = labPin;
	}
	
	
	
}
