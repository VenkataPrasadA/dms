package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "dak_others_project")
public class OtherProjectMaster
{
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long ProjectOtherId;
	private String ProjectCode;
	private String ProjectShortName;
	private String ProjectName;
	private String LabCode;
	private String createdBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
