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
@Table(name="dak_reply_attachment")
public class DakReplyAttach {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReplyAttachmentId;
	private Long ReplyId;
	private Long EmpId;
	private String IsMain;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;

	
}
