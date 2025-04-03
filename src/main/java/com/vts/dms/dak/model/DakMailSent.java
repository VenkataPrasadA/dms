package com.vts.dms.dak.model;

import java.sql.Date;
import java.util.Set;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;



@NoArgsConstructor
@Data
@Entity
@Table(name="dak_mail_sent")
public class DakMailSent {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long dakMailSentId;
    private Long messageId;
    private String mailType;
	private String subject;
    private Date sentDate;
    private String addressFrom;
    private String addressRecieptant;
	private String isMarked;
	private String CreatedBy;
	private String CreatedDate;
	@OneToMany
    @JoinColumn(name="dakMailSentId",insertable = false, updatable = false)
    private Set<DakMailSentAttach> dakMailSentAttach;
}