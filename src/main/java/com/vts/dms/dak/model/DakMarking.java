package com.vts.dms.dak.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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


