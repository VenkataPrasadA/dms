package com.vts.dms.enote.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
