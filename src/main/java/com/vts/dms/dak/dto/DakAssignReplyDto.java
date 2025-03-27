package com.vts.dms.dak.dto;



import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DakAssignReplyDto {
	
	
	private Long DakAssignReplyId;
	private MultipartFile[] AssignReplyDocs;
	private long DakId;
	private long AssignId;
	private long EmpId;
	private String Reply;
	private String ReplyStatus;
	private String ReturnRemarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String DakNo;

}
