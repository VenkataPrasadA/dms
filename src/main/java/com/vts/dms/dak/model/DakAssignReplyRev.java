package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
