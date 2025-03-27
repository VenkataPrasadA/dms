package com.vts.dms.dak.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name = "dak_c")
public class DakCreate {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakCreateId;
	private String DakNo;
	private Long LetterTypeId;
	private Long DeliveryTypeId;
	private Long DestinationId;
	private String RefNo;
	private Date RefDate;
	private Long PriorityId;
	private String Subject;
	private Date ReceiptDate;
	private String KeyWord1;
	private String KeyWord2;
	private String KeyWord3;
	private String KeyWord4;
	private Long ActionId;
	private Date ActionDueDate;
	private String ActionTime;
	private String DakStatus;
	private String DistributedDate;
	private String Remarks;
	private String Signatory;
	private String ReplyOpen;
	private String ReplyStatus;
	private String ClosedBy;
	private String ClosedDateTime;
	private String ClosingCommt;
	private String DivisionCode;
	private String LabCode;
	private String IsSave;
	private String IsSelf;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
