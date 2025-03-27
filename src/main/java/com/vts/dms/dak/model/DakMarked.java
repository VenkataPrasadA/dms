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
@Table(name="dak_distribution")
public class DakMarked {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakDistributionId;
	private Long DakId;
	private String DistributionType;
	private Long DistributionTypeId;
	private String CreatedBy;
	private String CreatedDate;

}
