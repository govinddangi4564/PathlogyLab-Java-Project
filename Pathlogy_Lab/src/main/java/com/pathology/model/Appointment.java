package com.pathology.model;

import java.sql.Date;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Appointment {
	private int id;
	private String patientId;
	private String patientName;
	private String patientEmail;
	private String patientMobile;
	private String testName;
	private Date appointmentDate;
	private LocalTime appointmentTime;
	private String labLocation;
	private String status;
	private String priority;

	public Appointment(String patientId, String testName, Date appointmentDate, LocalTime appointmentTime,
			String labLocation, String priority) {
		super();
		this.patientId = patientId;
		this.testName = testName;
		this.appointmentDate = appointmentDate;
		this.appointmentTime = appointmentTime;
		this.labLocation = labLocation;
		this.priority = priority;
	}

	public Appointment(String patientId, String patientName, String patientEmail, String patientMobile) {
		super();
		this.patientId = patientId;
		this.patientName = patientName;
		this.patientEmail = patientEmail;
		this.patientMobile = patientMobile;
	}

}
