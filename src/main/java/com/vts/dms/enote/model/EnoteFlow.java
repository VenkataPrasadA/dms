package com.vts.dms.enote.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
@Data
@Entity
@Table(name = "dak_enote_flow")
public class EnoteFlow {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RecommendId;
	private String RecommendNo;
	private Long EnoteId;
	private Long EmpId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;

}
