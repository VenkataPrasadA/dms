package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
