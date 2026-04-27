package com.pathology.template;

public class OtpTemplate {

	public static String getTemplate(String actionText, String otp) {

		return "<html>" + "<body style='font-family:Arial, sans-serif; background:#f4f6f8; padding:20px;'>"

				+ "<div style='max-width:500px; margin:auto; background:#ffffff; padding:25px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);'>"

				+ "<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>"
				+ "<hr style='border:none; border-top:1px solid #eee;'>"

				+ "<p style='font-size:15px;'>Dear User,</p>"

				+ "<p style='font-size:15px;'>We received a request to <b>" + actionText
				+ "</b>. Please use the OTP below:</p>"

				+ "<div style='text-align:center; margin:25px 0;'>"
				+ "<span style='font-size:28px; letter-spacing:5px; font-weight:bold; color:#ffffff; background:#0b7a75; padding:12px 25px; border-radius:8px;'>"
				+ otp + "</span>" + "</div>"

				+ "<p style='font-size:14px; color:#555;'>This OTP is valid for <b>10 minutes</b>. Please do not share it with anyone.</p>"

				+ "<p style='font-size:13px; color:#888;'>If you did not request this, please ignore this email.</p>"

				+ "<hr style='border:none; border-top:1px solid #eee;'>"
				+ "<p style='font-size:13px; color:#888; text-align:center;'>© 2026 Pathology Lab</p>"

				+ "</div></body></html>";
	}
}
