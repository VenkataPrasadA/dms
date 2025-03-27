package com.vts.dms.dak.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;



@NoArgsConstructor
@Data
@Entity
@Table(name="dak_assign")
public class DakAssign {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakAssignId;
	private Long DakId;
	private Long DakMarkingId;
	private Long EmpId;
	private String ReplyStatus;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
