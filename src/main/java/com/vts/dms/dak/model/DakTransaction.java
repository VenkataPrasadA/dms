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
