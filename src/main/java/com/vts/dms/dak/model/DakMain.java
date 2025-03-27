package com.vts.dms.dak.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;


import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak")
public class DakMain {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakId;
	private String DakNo;
	private Long LetterTypeId;
	private Long DeliveryTypeId;
	private String RefNo;
	private Date RefDate;
	private Long PriorityId;
	private Long SourceDetailId;
	private Long SourceId;
	private String ProjectType;
	private String Subject;
	private Date ReceiptDate;
	private Long ProjectId;
	private String KeyWord1;
	private String KeyWord2;
	private String KeyWord3;
	private String KeyWord4;
	private String Remarks;
	private String Signatory;
	private Long ActionId;
	private String ReplyOpen;
	private String ReplyStatus;
	private Date ActionDueDate;
	private String ActionTime;
	private String DakStatus;
	private String ModifiedBy;
	private String ModifiedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String DirectorApproval;
	private String ClosingAuthority;
	private String ApprovedBy;
	private String ApprovedCommt;
	private String ApprovedDateTime;
	private String ClosedBy;
	private String ClosedDate;
	private String ClosedDateTime;
	private String ClosingCommt;
	private String DivisionCode;
	private String LabCode;
	private String SourceLabCode;
	private long DirApvForwarderId;
	private int IsActive;
	private Long DakCreateId;
	private String AppUrl;
	
	@Transient
	private String CreateLabCode;
}
