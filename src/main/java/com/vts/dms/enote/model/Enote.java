package com.vts.dms.enote.model;

import java.sql.Date;

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
@Table(name = "dak_enote")
public class Enote {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
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
	private String IsDraft;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
