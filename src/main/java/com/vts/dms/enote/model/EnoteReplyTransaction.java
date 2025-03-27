package com.vts.dms.enote.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "dak_enote_reply_trans")
public class EnoteReplyTransaction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EnoteReplyTransId;
	private Long DakEnoteReplyId;
	private String EnoteStatusCode;
	private String Remarks;
	private String Role;
	private Long ActionBy;
	private String ActionDate;
}
