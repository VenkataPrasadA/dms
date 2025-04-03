package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "dak_remind_reply")
@Data
public class DakRemidReply {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long Remind_ReplyId;
	private Long RemindId;
	private String Reply;
	private String CreatedBy;
	private String CreatedDate;
}
