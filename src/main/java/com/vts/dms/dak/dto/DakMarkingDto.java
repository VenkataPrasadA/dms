package com.vts.dms.dak.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DakMarkingDto {

	private Long DakMarkingId;
	private Long DakId;
	private Long DakMemberTypeId;
	private Long EmpId;
	private Long ActionId;
	private String ReplyOpen;
	private String ReplyStatus;
	private Date ActionDueDate;
	private String CreatedBy;
	private String CreatedDate;
	private String Reply;
	private MultipartFile File;
	private String MailOutPath;
	private String MailOutFile;
	private int IsActive;
}
