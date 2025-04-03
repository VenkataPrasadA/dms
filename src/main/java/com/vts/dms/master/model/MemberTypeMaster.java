package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "dak_member_type")
public class MemberTypeMaster {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakMemberTypeId;
	private String DakMemberType;
	private String MemberTypeGrouping;	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
