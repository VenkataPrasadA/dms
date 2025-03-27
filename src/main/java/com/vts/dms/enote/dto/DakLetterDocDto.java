package com.vts.dms.enote.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DakLetterDocDto {

	private Long LetterDocId;
	private Long EnoteId;
	private long EmpId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String letterNo;
	private String ReplyPersonSentMail;
	private String[] ReplyReceivedMail;
	private String HostType;
	private MultipartFile UploadDocument;
}
