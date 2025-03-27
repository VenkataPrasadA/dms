package com.vts.dms.dak.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakPnCReplyDto {

	private MultipartFile[] PnCReplyDocs;
	private long DakId;
	private long EmpId;
	private String Reply;
	private String CreatedBy;
	//for edit purpose
	private long PnCReplyId;
	private String ModifiedBy;
	private String[] DakMarkerReAttachs;
}
