package com.pathology.template;

import java.sql.Date;
import java.time.LocalTime;

public class AppointmentTemplate {
	public static String getTemplate(String patientName, Date date, LocalTime time, String testName, String action) {

		String color = action.equalsIgnoreCase("confirmed") ? "green" : "red";
		String message = action.equalsIgnoreCase("confirmed") ? "Your appointment has been successfully confirmed."
				: "Your appointment has been cancelled.";

		return "<html>" + "<body style='font-family:Arial; background:#f4f6f8; padding:20px;'>" +

				"<div style='max-width:500px; margin:auto; background:#fff; padding:25px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);'>"
				+

				"<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>" +

				"<p>Dear " + patientName + ",</p>" +

				"<p style='font-size:15px;'>"
				+ message.replace("confirmed", "<b style='color:" + color + ";'>" + action + "</b>") + "</p>" +

				"<hr style='border:none; border-top:1px solid #eee;'/>" +

				"<p><b>Date:</b> " + date + "</p>" + "<p><b>Time:</b> " + time + "</p>" + "<p><b>Test:</b> " + testName
				+ "</p>" +

				(action.equalsIgnoreCase("confirmed") ? "<p style='color:#555;'>Please arrive 10 minutes early.</p>"
						: "<p style='color:#555;'>If this was a mistake, please contact us.</p>")
				+

				"<p style='margin-top:20px;'>Thank you,<br/>Pathology Lab Team</p>" +

				"</div></body></html>";
	}
}
