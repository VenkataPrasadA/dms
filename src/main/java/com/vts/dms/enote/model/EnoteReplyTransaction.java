package com.vts.dms.enote.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
