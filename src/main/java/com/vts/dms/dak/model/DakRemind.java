package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

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
