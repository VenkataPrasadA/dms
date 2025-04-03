package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

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
