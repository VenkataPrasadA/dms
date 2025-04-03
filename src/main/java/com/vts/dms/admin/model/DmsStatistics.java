package com.vts.dms.admin.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "dak_statistics")
public class DmsStatistics {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long StatisticsId;
	private Date  LogDate;
	private Long LoginCount;
	private String UserName;
	private Long EmpId;
	private Long DakCount;
	private Long DistributedCount;
	private Long AcknowledgeCount;
	private Long MarkedCount;
	private Long RepliedCount;
	private Long AssignedCount;
	private Long AssignRepliedCount;
	private Long SeekResponseCount;
	private Long SeekResponseRepliedCount;
}
