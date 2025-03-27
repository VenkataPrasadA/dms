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
@Table(name="dak_assign_reply")
public class DakAssignReply {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakAssignReplyId;
	private Long DakId;
	private Long DakAssignId;
	private Long EmpId;
	private String Reply;
	private String ReplyStatus;
	private String ReturnRemarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
