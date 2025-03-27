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
@Table(name = "dak_assign_reply_rev")
public class DakAssignReplyRev {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakAssignReplyRevId;
	private Long DakAssignReplyId;
	private Long EmpId;
	private String Reply;
	private String ReturnRemarks;
	private Long RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
}
