package com.vts.dms.enote.model;

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
@Table(name = "dak_enote_attach")
public class EnoteAttachment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EnoteAttachmentId;
	private Long EnoteId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
