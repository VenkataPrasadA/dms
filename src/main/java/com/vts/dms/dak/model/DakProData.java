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
@Table(name="dak_pro")
public class DakProData {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DakProjectId;
	private Long DakId;
	private Long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
}
