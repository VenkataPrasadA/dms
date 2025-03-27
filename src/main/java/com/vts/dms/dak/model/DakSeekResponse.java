package com.vts.dms.dak.model;

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
@Table(name="dak_seekresponse")
public class DakSeekResponse {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long SeekResponseId;
	private Long DakId;
	private Long SeekAssignerId;
	private Long SeekEmpId;
	private String Remarks;
	private String Reply;
	private String ReplyStatus;
	private String RepliedBy;
	private String RepliedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
