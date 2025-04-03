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
@Table(name="dak_pnc_reply")
public class DakPnCReply {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakPnCReplyId;
	private Long DakId;
	private Long EmpId;
	private String PnCReply;
	private String PnCReplyStatus;
	private String ReturnedCommt;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
