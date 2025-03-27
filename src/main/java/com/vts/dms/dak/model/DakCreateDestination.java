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
@Table(name = "dak_c_destination")
public class DakCreateDestination {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakCreateDestinationId;
	private Long DakCreateId;
	private Long DestinationTypeId;
	private String Acknowledged;
	private String Reply;
	private String ReplyStatus;
	private String IsSent;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
