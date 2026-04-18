package com.pathology.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Patient {
	private int id;
	private String patientId;
	private String patientName;
	private String patientEmail;
	private String patientMobile;

	public Patient(String patientName, String patientEmail, String patientMobile) {
		super();
		this.patientName = patientName;
		this.patientEmail = patientEmail;
		this.patientMobile = patientMobile;
	}

	public Patient(String patientId, String patientName, String patientEmail, String patientMobile) {
		super();
		this.patientId = patientId;
		this.patientName = patientName;
		this.patientEmail = patientEmail;
		this.patientMobile = patientMobile;
	}

}
