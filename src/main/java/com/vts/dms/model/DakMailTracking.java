package com.vts.dms.model;

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
@Table(name="dak_mail_track")
public class DakMailTracking {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long MailTrackingId;
	private String TrackingType;
	private long MailExpectedCount;
	private long MailSentCount;
	private String MailSentStatus;
	private String CreatedDate;
	private String CreatedTime;
	private String MailSentDateTime;
}
