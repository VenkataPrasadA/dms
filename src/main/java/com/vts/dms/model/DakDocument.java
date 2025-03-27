package com.vts.dms.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name="document")
public class DakDocument {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DocId;
	private String DocName;
	private String DocPath;
	private String CreatedBy;
	private String CreatedDate;
}
