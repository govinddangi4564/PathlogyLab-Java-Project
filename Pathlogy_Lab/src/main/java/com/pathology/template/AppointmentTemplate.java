package com.pathology.template;

import java.sql.Date;
import java.time.LocalTime;

public class AppointmentTemplate {
	public static String getTemplate(String patientName, Date date, LocalTime time, String testName) {

		return "<html>" + "<body style='font-family:Arial; background:#f4f6f8; padding:20px;'>"

				+ "<div style='max-width:500px; margin:auto; background:#fff; padding:25px; border-radius:10px;'>"

				+ "<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>"

				+ "<p>Dear " + patientName + ",</p>"
				+ "<p>Your appointment has been <b style='color:green;'>confirmed</b>.</p>"

				+ "<p><b>Date:</b> " + date + "</p>" + "<p><b>Time:</b> " + time + "</p>" + "<p><b>Test:</b> "
				+ testName + "</p>"

				+ "<p>Please arrive 10 minutes early.</p>"

				+ "</div></body></html>";
	}
}
