package com.vts.dms.admin.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak_handingover")
public class DakHandingOver {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long HandingOverId;
	private Long FromEmpId;
	private Long ToEmpId;
	private Date FromDate;
	private Date ToDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	@Transient
	private String ActionValue;
	
}
