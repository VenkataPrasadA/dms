package com.vts.dms.enote.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EnoteflowDto {

	private Long RecommendId;
	private String RecommendNo;
	private Long EnoteId;
	private Long EmpId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String[] RecommendeEmps;
}
