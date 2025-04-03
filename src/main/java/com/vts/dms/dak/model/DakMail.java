package com.vts.dms.dak.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
@Table(name="dak_mail")
public class DakMail 
{
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long dakMailId;
    private Long messageId;
    private String mailType;
	private String subject;
    private LocalDateTime recievedDate;
    private String addressFrom;
    private String addressRecieptant;
	private String isMarked;
	private String CreatedBy;
	private LocalDateTime CreatedDate;
	@OneToMany
    @JoinColumn(name="dakMailId",insertable = false, updatable = false)
    private Set<DakMailAttach> dakMailAttach;
}
