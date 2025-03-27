package com.vts.dms.dak.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DakDestinationDto {

	
	private Long dakId;
	private Long dakCreateId;
	private String appUrl;
	private String reply;
	private Long destinationTypeId;
	private String closingComment;
	private String replyPersonSentMail;
	private String[] replyReceivedMail;
	private String replyMailSubject;
	private String hostType; 
	private String createdBy;
	private String createdDate;
	private String modifiedBy;
	private String modifiedDate;
	private Long empId;
	
}
