package com.vts.dms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="vendor_parameter")
public class VendorParameter {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY )
	private Long VendorParameterId;
	private String VendorExt;
	private Long VendorExtSerialNo;
	public Long getVendorParameterId() {
		return VendorParameterId;
	}
	public void setVendorParameterId(Long vendorParameterId) {
		VendorParameterId = vendorParameterId;
	}
	public String getVendorExt() {
		return VendorExt;
	}
	public void setVendorExt(String vendorExt) {
		VendorExt = vendorExt;
	}
	public Long getVendorExtSerialNo() {
		return VendorExtSerialNo;
	}
	public void setVendorExtSerialNo(Long vendorExtSerialNo) {
		VendorExtSerialNo = vendorExtSerialNo;
	}
	
}
