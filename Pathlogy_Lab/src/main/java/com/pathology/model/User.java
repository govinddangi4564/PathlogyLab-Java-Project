package com.pathology.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	private int id;
	private String name;
	private String email;
	private String mobile;
	private String password;
	private String role;
	private Date date;
	private String otp;
	private Timestamp otpTime;

	private int rating;
	private String message;

	public User(String name, String email, String mobile, String password, String role) {
		super();
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.password = password;
		this.role = role;
	}

	public User(String otp, Timestamp otpTime) {
		super();
		this.otp = otp;
		this.otpTime = otpTime;
	}

	public User(int id, String name, String email, String mobile, String password, String role) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.password = password;
		this.role = role;
	}

	public User(String password) {
		super();
		this.password = password;
	}

	public User(int id, String name, String email, String mobile, String role, Date date) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.role = role;
		this.date = date;
	}

}
