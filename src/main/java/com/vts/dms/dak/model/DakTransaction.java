package com.vts.dms.dak.model;

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
@Table(name="dak_transaction")
public class DakTransaction {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DakTransactionId;
	private Long DakId;
	private Long EmpId;
	private String Remarks;
	private String TransactionDate;
	private String DakStatus;
}
