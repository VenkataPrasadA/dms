package com.vts.dms.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
