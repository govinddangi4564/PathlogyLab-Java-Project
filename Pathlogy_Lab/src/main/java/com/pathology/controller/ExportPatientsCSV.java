package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.pathology.dao.PatientDao;
import com.pathology.model.Patient;

@WebServlet("/exportPatientsCSV")
public class ExportPatientsCSV extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ExportPatientsCSV() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("userObj") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String role = (String) session.getAttribute("role");
		if (!("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role))) {
			response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
			return;
		}

		PrintWriter writer = null;
		try {
			PatientDao patientDao = new PatientDao();
			List<Patient> patients = patientDao.getAllPatients();

			// Set response headers for CSV download
			String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HHmmss"));
			String fileName = "Patients_Export_" + timestamp + ".csv";

			response.setContentType("text/csv;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

			writer = response.getWriter();

			writer.println("Patient ID,Patient Name,Patient Email,Patient Mobile");

			// Write patient data
			if (patients != null && !patients.isEmpty()) {
				for (Patient patient : patients) {
					// Escape commas and quotes in data
					String patientId = escapeCSV(patient.getPatientId());
					String patientName = escapeCSV(patient.getPatientName());
					String patientEmail = escapeCSV(patient.getPatientEmail());
					String patientMobile = escapeCSV(patient.getPatientMobile());

					writer.printf("%s,%s,%s,%s%n", patientId, patientName, patientEmail, patientMobile);
				}
			}

			writer.flush();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				if (writer != null) {
					writer.println("Error generating CSV file: " + e.getMessage());
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} finally {
			if (writer != null) {
				writer.close();
			}
		}
	}

	/**
	 * Escapes special characters in CSV fields according to RFC 4180
	 */
	private String escapeCSV(String field) {
		if (field == null) {
			return "";
		}

		// If field contains comma, newline, or double quote, wrap in double quotes
		if (field.contains(",") || field.contains("\n") || field.contains("\"")) {
			// Escape double quotes by doubling them
			field = field.replace("\"", "\"\"");
			return "\"" + field + "\"";
		}

		return field;
	}
}
