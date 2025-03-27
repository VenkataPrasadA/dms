package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DakSeekResponseAttachDto {
	
	private Long SeekResponseAttachmentId;
	private MultipartFile[] SeekResponsereplydocs;
	private Long SeekResponseId;
	private Long DakId;
	private Long EmpId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String Reply;
	private String ReplyStatus;
	private String DakNo;

}
