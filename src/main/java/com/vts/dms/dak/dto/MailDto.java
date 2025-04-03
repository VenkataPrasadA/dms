package com.vts.dms.dak.dto;

import java.util.Date;
import java.util.List;

import jakarta.mail.Address;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MailDto {
    private Long messageId;
	private String subject;
    private String content;
    private Date recievedDate;
    private Address[] addressFrom;
    private Address[] addressRecieptant;
    private List<String> attachment;
    private String mailType;
    
}
