package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.dak.model.DakMain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakReplyDto {

	private MultipartFile[] ReplyDocs;
	private long DakId;
	private long EmpId;
	private String Reply;
	private String CreatedBy;
	//for edit purpose
	private long DakReplyId;
	private String ModifiedBy;
	private String[] DakAssignerReAttachs;
	private String ReplyPersonSentMail;
	private String[] ReplyReceivedMail;
	private String ReplyMailSubject;
	private String HostType;

}
