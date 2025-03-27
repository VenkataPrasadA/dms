package com.vts.dms.master.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="vendor")
public class Vendor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long VendorId;
	private String VendorCode;
	private String VendorName;
	private String Address;
	private String City;
	private String PinCode;
	private String ContactPerson;
	private String TelNo;
	private String FaxNo;
	private String Email;
	private String RegistrationNo;
	private Date RegistrationDate;
	private Date ValidityDate;
	private String CPPRegisterId;
	private String ProductRange;
	private String VendorType;
	private String PAN;
	private String GSTNo;
	private String VendorBank;
	private String AccountNo;
	private int isActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public Long getVendorId() {
		return VendorId;
	}
	public void setVendorId(Long vendorId) {
		VendorId = vendorId;
	}
	public String getVendorCode() {
		return VendorCode;
	}
	public void setVendorCode(String vendorCode) {
		VendorCode = vendorCode;
	}
	public String getVendorName() {
		return VendorName;
	}
	public void setVendorName(String vendorName) {
		VendorName = vendorName;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public String getCity() {
		return City;
	}
	public void setCity(String city) {
		City = city;
	}
	public String getPinCode() {
		return PinCode;
	}
	public void setPinCode(String pinCode) {
		PinCode = pinCode;
	}
	public String getContactPerson() {
		return ContactPerson;
	}
	public void setContactPerson(String contactPerson) {
		ContactPerson = contactPerson;
	}
	public String getTelNo() {
		return TelNo;
	}
	public void setTelNo(String telNo) {
		TelNo = telNo;
	}
	public String getFaxNo() {
		return FaxNo;
	}
	public void setFaxNo(String faxNo) {
		FaxNo = faxNo;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getRegistrationNo() {
		return RegistrationNo;
	}
	public void setRegistrationNo(String registrationNo) {
		RegistrationNo = registrationNo;
	}
	
	public Date getRegistrationDate() {
		return RegistrationDate;
	}
	public void setRegistrationDate(Date registrationDate) {
		RegistrationDate = registrationDate;
	}
	public Date getValidityDate() {
		return ValidityDate;
	}
	public void setValidityDate(Date validityDate) {
		ValidityDate = validityDate;
	}
	public String getCPPRegisterId() {
		return CPPRegisterId;
	}
	public void setCPPRegisterId(String cPPRegisterId) {
		CPPRegisterId = cPPRegisterId;
	}
	public String getProductRange() {
		return ProductRange;
	}
	public void setProductRange(String productRange) {
		ProductRange = productRange;
	}
	public String getVendorType() {
		return VendorType;
	}
	public void setVendorType(String vendorType) {
		VendorType = vendorType;
	}
	public String getPAN() {
		return PAN;
	}
	public void setPAN(String pAN) {
		PAN = pAN;
	}
	public String getGSTNo() {
		return GSTNo;
	}
	public void setGSTNo(String gSTNo) {
		GSTNo = gSTNo;
	}
	public String getVendorBank() {
		return VendorBank;
	}
	public void setVendorBank(String vendorBank) {
		VendorBank = vendorBank;
	}
	public String getAccountNo() {
		return AccountNo;
	}
	public void setAccountNo(String accountNo) {
		AccountNo = accountNo;
	}
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
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
