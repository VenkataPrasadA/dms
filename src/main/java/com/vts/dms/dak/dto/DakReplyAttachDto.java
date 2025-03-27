package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class DakReplyAttachDto {

	private Long ReplyAttachmentId;
	private Long ReplyId;
	private String IsMain;
	private Long EmpId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private MultipartFile[] ReplyFile;
	private String DakNo;
}
