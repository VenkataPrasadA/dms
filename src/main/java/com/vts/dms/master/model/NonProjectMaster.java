package com.vts.dms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "dak_non_project")
public class NonProjectMaster {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long NonProjectId;
	private String NonShortName;
	private String NonProjectName;
	private int IsActive;
	private String createdBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
