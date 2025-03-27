package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class DakCreateAttachDto {

	private Long DakCreateAttachmentId;
	private Long DakCreateId;
	private String FilePath;
	private String FileName;
	private String Type;
	private String CreatedBy;
	private String CreatedDate;
	private MultipartFile File;
	private MultipartFile[] SubFile;
	private String ModifiedBy;
	private String ModifiedDate;
	private String RefNo;
	private String Remarks;
	private Long EmpId;
	private String replyid;
	private String DakNo;
}
