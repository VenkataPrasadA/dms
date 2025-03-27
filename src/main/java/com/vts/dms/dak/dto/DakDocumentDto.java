package com.vts.dms.dak.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class DakDocumentDto {

	private Long DocId;
	private String DocName;
	private String DocPath;
	private String CreatedBy;
	private String CreatedDate;
}
