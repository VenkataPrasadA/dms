package com.vts.dms.admin.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
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
