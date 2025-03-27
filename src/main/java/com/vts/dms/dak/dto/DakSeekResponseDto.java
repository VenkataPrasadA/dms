package com.vts.dms.dak.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakSeekResponseDto {

	private Long SeekResponseId;
	private Long DakId;
	private Long SeekAssignerId;
	private Long SeekEmpId;
	private String Remarks;
	private String Reply;
	private String ReplyStatus;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
