package com.vts.dms.dak.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name="dak_c_daklink")
public class DakCreateLink {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakCreateLinkId;
	private Long DakCreateId;
	private Long LinkDakCreateId;
	private String CreatedBy;
	private String CreatedDate;
	
}
