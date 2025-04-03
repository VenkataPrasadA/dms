package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
