package com.vts.dms.dak.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakAssignDto {

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
