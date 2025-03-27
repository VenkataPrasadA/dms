package com.vts.dms.dak.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name="dak_notification")
public class DakNotification {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long NotificationId;
	private Long EmpId;
	private Long NotificationBy;
	private String NotificationDate;
	private String NotificationMessage;
	private String NotificationUrl;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
