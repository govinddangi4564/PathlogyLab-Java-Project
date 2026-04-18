package com.pathology.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	private int id;
	private int userId;
	private String patientId;
	private String reportName;
	private String reportPath;
	private Date reportDate;
	private String status;

	public Report(int userId, String patientId, String reportName, String reportPath, String status) {
		super();
		this.userId = userId;
		this.patientId = patientId;
		this.reportName = reportName;
		this.reportPath = reportPath;
		this.status = status;
	}

	public Report(int id, String patientId, String reportName, String reportPath, Date reportDate, String status) {
		super();
		this.id = id;
		this.patientId = patientId;
		this.reportName = reportName;
		this.reportPath = reportPath;
		this.reportDate = reportDate;
		this.status = status;
	}

}