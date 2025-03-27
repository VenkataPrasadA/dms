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
@Table(name="dak_seekresponse_attachment")
public class SeekResponseReplyAttachment {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long SeekResponseAttachmentId;
	private Long SeekResponseId;
	private Long DakId;
	private Long EmpId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
