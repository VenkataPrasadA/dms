package com.vts.dms.dak.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
