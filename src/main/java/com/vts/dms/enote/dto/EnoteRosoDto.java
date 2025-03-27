package com.vts.dms.enote.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnoteRosoDto {

	private Long EnoteRoSoId;
	private Long InitiatingEmpId;	
	private Long RO1;
	private String RO1_Role;
	private Long RO2;	
	private String RO2_Role;
	private Long RO3;
	private String RO3_Role;	
	private Long RO4;
	private String RO4_Role;
	private Long RO5;
	private String RO5_Role;
	private Long ExternalOfficer;
	private String ExternalOfficer_Role;
	private Long ApprovingOfficer;
	private String Approving_Role;
	private String External_LabCode;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
