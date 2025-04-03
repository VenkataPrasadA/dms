package com.vts.dms.dak.model;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak_daklink")
public class DakLink {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakLinkId;
	private Long DakId;
	private Long LinkDakId;
	private String CreatedBy;
	private String CreatedDate;
	
}
