package com.vts.dms.enote.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.enote.model.Enote;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnoteDto {
	private Enote enote;
	private Long EnoteId;
	private String NoteId;	
	private String NoteNo;
	private String RefNo;
	private Date RefDate;
	private String Subject;
	private String Comment;
	private Long DakId;
	private Long DakReplyId;
	private String DakNo;
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
	private Long ExternalOfficer;
	private String External_Role;
	private Long ApprovingOfficer;
	private String Approving_Role;
	private String LabCode;
	private String EnoteType;
	private String IsDak;
	private String EnoteFrom;
	private String EnoteStatusCode;
	private String EnoteStatusCodeNext;
	private Long InitiatedBy;
	private String LetterNo;
	private Date LetterDate;
	private String DraftContent;
	private Long DestinationId;
	private Long DestinationTypeId;
	private Long Signatory;
	private String LetterHead;
	private String DivisionCode;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsDraft;
	private int IsActive;
	private MultipartFile[] dakEnoteDocument;
	private String ApprovalDate;
	private String ApprovalExternalOfficer;
	private String Actionsave;
	private MultipartFile[] dakReplyEnoteDocument;
	

}
