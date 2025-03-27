package com.vts.dms.dak.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;

@Entity
@Table(name = "dak_remind")
@Data
public class DakRemind {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long RemindId;
	private Long DakId;
	private Long RemindBy;
	private Long RemindTo;
	private String CommentType;
	private String Comment;
	private String CreatedBy;
	private String CreatedDate;
	
	@Transient
	private String Url;
}
