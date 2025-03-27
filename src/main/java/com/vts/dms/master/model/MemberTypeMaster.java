package com.vts.dms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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
