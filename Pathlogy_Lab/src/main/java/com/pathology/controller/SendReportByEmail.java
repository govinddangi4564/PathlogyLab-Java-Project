package com.pathology.controller;

import java.io.File;
import java.io.IOException;
import java.util.ResourceBundle;

import com.pathology.dao.ReportDao;
import com.pathology.model.Report;
import com.pathology.service.EmailFileService;
import com.pathology.template.ReportTemplate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sendReport")
public class SendReportByEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendReportByEmail() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));

		HttpSession session = request.getSession();
		ReportDao dao = new ReportDao();
		Report r = dao.getReport(id);

		String toEmail = r.getPatientEmail();
		String fileName = r.getReportPath();

		ResourceBundle bundle = null;
		try {
			bundle = ResourceBundle.getBundle("config");
		} catch (Exception e) {}

		String reportsPath = System.getenv("REPORTS_PATH") != null ? System.getenv("REPORTS_PATH") : getServletContext().getRealPath("/reports/");
		if (!reportsPath.endsWith(File.separator)) {
			reportsPath += File.separator;
		}

		File file = new File(reportsPath + fileName);

		String body = ReportTemplate.getTemplate();

		String subject = "Your Medical Report - Pathology Lab";

		EmailFileService.sendWithAttachment(toEmail, subject, body, file);

		int i = dao.updateStatus(id);
		int j = dao.markEmailSent(id);

		if (i > 0 && j > 0) {
			session.setAttribute("successMsg", "Report sent successfully!");
		} else {
			session.setAttribute("errorMsg", "Database update failed!");
		}

		response.sendRedirect(request.getContextPath() + "/viewAllReports");
	}

}
