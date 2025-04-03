package com.vts.dms.admin.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
@Entity
@Table(name = "login_division")
public class LoginDivision implements Serializable {
	   @Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long LoginDivisionId;
	    private Long LoginId;
	    private Long DivisionId;
	    private Long SerialNo;
		public Long getLoginDivisionId() {
			return LoginDivisionId;
		}
		public void setLoginDivisionId(Long loginDivisionId) {
			LoginDivisionId = loginDivisionId;
		}
		public Long getLoginId() {
			return LoginId;
		}
		public void setLoginId(Long loginId) {
			LoginId = loginId;
		}
		public Long getDivisionId() {
			return DivisionId;
		}
		public void setDivisionId(Long divisionId) {
			DivisionId = divisionId;
		}
		public Long getSerialNo() {
			return SerialNo;
		}
		public void setSerialNo(Long serialNo) {
			SerialNo = serialNo;
		}
	    
	    
	
}
