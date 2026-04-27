package com.pathology.template;

public class ReportTemplate {

	public static String getTemplate() {

		return "<html>" + "<body style='font-family:Arial, sans-serif; background:#f4f6f8; padding:20px;'>"

				+ "<div style='max-width:600px; margin:auto; background:#ffffff; padding:25px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);'>"

				+ "<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>"
				+ "<hr style='border:none; border-top:1px solid #eee;'>"

				+ "<p style='font-size:15px;'>Dear Patient,</p>"

				+ "<p style='font-size:15px;'>We are pleased to inform you that your <b>medical report</b> is ready.</p>"

				+ "<div style='background:#f9fbfc; padding:15px; border-radius:8px; margin:20px 0;'>"
				+ "<p>Please find your report attached with this email.</p>" + "</div>"

				+ "<p style='font-size:14px;'>If you have any questions, feel free to contact us.</p>"

				+ "<p style='font-size:14px; color:#555;'>Stay healthy!</p>"

				+ "<hr style='border:none; border-top:1px solid #eee;'>"
				+ "<p style='font-size:13px; color:#888; text-align:center;'>© 2026 Pathology Lab</p>"

				+ "</div></body></html>";
	}
}
