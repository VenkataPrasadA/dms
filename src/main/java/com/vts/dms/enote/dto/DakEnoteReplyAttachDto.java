package com.vts.dms.enote.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class DakEnoteReplyAttachDto {

	private Long DakEnoteAttachmentId;
	private Long DakEnoteReplyId;
	private String FilePath;
	private String FileName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Long DakId;
}
