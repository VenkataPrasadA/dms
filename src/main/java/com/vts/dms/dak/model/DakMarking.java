package com.vts.dms.dak.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak_marking")
public class DakMarking {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakMarkingId;
	private Long DakId;
	private Long DakMemberTypeId;
	private Long EmpId;
	private Long ActionId;
	private String ReplyOpen;
	private String Remarkup;
    private  Date ActionDueDate;
    private String DakAckStatus;
    private String DakAssignStatus;
    private int Favourites;
	private String MsgType;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;


}


