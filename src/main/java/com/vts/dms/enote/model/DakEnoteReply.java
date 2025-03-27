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
@Entity
@Data
@Table(name = "dak_enote_reply")
public class DakEnoteReply {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakEnoteReplyId;
	private Long DakReplyId;
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
}
