package com.vts.dms.dto;



import lombok.Data;
import lombok.NoArgsConstructor;


	@NoArgsConstructor
	@Data
	public class MailConfigurationDto {

		private long MailConfigurationId;
		private String TypeOfHost;
		private String Host;
		private String Port;
		private String Username;
		private String Password;
		private String CreatedBy;
		private String CreatedDate;
		
		
		
		
	}

