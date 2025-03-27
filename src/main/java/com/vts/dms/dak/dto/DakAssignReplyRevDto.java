package com.vts.dms.dak.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakAssignReplyRevDto {

	private Long DakAssignReplyId;
	private Long DakAssignReplyRevId;
	private Long EmpId;
	private String PreReply;
	private String ReturnRemarks;
	private String[] PrevFilePath;
	private int RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
	
}
