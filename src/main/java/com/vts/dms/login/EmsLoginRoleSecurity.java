package com.vts.dms.login;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="dms_login_role_security")
public class EmsLoginRoleSecurity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long LoginRoleSecurityId ;
	private Long LoginId;
	private Long RoleId;
	
	public Long getLoginRoleSecurityId() {
		return LoginRoleSecurityId;
	}
	public void setLoginRoleSecurityId(Long loginRoleSecurityId) {
		LoginRoleSecurityId = loginRoleSecurityId;
	}
	public Long getLoginId() {
		return LoginId;
	}
	public void setLoginId(Long loginId) {
		LoginId = loginId;
	}
	public Long getRoleId() {
		return RoleId;
	}
	public void setRoleId(Long roleId) {
		RoleId = roleId;
	}

}
