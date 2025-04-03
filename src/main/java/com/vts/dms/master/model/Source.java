package com.vts.dms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "dak_source_details")
public class Source {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long SourceDetailId;
	private Long SourceId;
	private String SourceShortName;
	private String SourceName;
	private String SourceAddress;
	private String SourceCity;
	private String SourcePin;
	
	private String IsDMS;
	private String ApiUrl;
	private String DivisionCode;
	private String LabCode;
	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
