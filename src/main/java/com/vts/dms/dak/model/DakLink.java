package com.vts.dms.dak.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
