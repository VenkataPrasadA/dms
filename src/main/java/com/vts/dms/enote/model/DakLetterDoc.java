package com.vts.dms.enote.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
@Data
@Table(name = "dak_letter_doc")
public class DakLetterDoc {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LetterDocId;
	private Long EnoteId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
}
