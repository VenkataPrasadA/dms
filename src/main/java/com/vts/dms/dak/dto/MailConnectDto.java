package com.vts.dms.dak.dto;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MailConnectDto {
	private String protocol;
    private String username;
	private String password;
    private String port;
	private String host;
    private String path;
    private String mailType;
    private Date mailDate;
    private String folder;
}
