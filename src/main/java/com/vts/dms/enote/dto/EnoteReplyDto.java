package com.vts.dms.enote.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.enote.model.DakEnoteReply;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnoteReplyDto {

	private DakEnoteReply enoteReply;
	private Long DakReplyId;
	private Long DakEnoteReplyId;
	private Long DakId;	
	private String NoteNo;
	private String DakNo;
	private String RefNo;
	private Date RefDate;
	private String Reply;
	private Long Recommend1;
	private String Rec1_Role;
	private Long Recommend2;
	private String Rec2_Role;
	private Long Recommend3;
	private String Rec3_Role;
	private Long Recommend4;
	private String Rec4_Role;
	private Long Recommend5;
	private String Rec5_Role;
	private Long SanctionOfficer;
	private String Sanction_Role;
	private String LabCode;
	private String EnoteStatusCode;
	private String EnoteStatusCodeNext;
	private Long InitiatedBy;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private MultipartFile[] dakReplyEnoteDocument;
	private String ApprovalDate;
	private String Actionsave;
	
}
