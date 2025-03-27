package com.vts.dms.dak.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="dak_member_type")
public class DakMemberType implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int DakMemberTypeId;
	
	
	
	public int getDakMemberTypeId() {
		return DakMemberTypeId;
	}

	public void setDakMemberTypeId(int dakMemberTypeId) {
		DakMemberTypeId = dakMemberTypeId;
	}

	public String getDakMemberType() {
		return DakMemberType;
	}

	public void setDakMemberType(String dakMemberType) {
		DakMemberType = dakMemberType;
	}

	private String DakMemberType;
	
}
