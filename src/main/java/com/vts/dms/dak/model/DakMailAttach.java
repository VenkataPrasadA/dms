package com.vts.dms.dak.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak_mail_attach")
public class DakMailAttach {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long dakMailAttachId;
    private Long dakMailId;
    private String attachPath;
	
}