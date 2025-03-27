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
@Table(name="dak_attachment")
public class DakAttachment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakAttachmentId;
	private Long DakId;
	private String IsMain;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
