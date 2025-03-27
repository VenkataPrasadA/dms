package com.vts.dms.dak.model;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;



@NoArgsConstructor
@Data
@Entity
@Table(name="dak_mail")
public class DakMail 
{
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long dakMailId;
    private Long messageId;
    private String mailType;
	private String subject;
    private String recievedDate;
    private String addressFrom;
    private String addressRecieptant;
	private String isMarked;
	private String CreatedBy;
	private String CreatedDate;
	@OneToMany
    @JoinColumn(name="dakMailId",insertable = false, updatable = false)
    private Set<DakMailAttach> dakMailAttach;
}
