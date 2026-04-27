package com.pathology.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalTime;

import com.pathology.dao.AppointmentDao;
import com.pathology.model.Appointment;
import com.pathology.service.EmailService;
import com.pathology.template.AppointmentTemplate;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/appointmentConfirmation")
public class SendAppointmentConfirmation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendAppointmentConfirmation() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String status = request.getParameter("status");

		AppointmentDao dao = new AppointmentDao();
		Appointment ap = dao.getAppointmentById(id);

		String toEmail = ap.getPatientEmail();
		String name = ap.getPatientName();
		Date apDate = ap.getAppointmentDate();
		LocalTime apTime = ap.getAppointmentTime();
		String test = ap.getTestName();

		String subject = "Appointment Confirmation";

		String body = AppointmentTemplate.getTemplate(name, apDate, apTime, test);

		HttpSession session = request.getSession();

		try {
			EmailService.sendEmail(toEmail, subject, body);

			int i = dao.updateAppointmentStatus(id, status);

			if (i > 0) {
				session.setAttribute("successMsg", "Appointment confirmed & email sent");
			} else {
				session.setAttribute("errorMsg", "Status update failed");
			}

		} catch (MessagingException e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Email sending failed");
		}

		response.sendRedirect(request.getContextPath() + "/Pages/viewAppointment.jsp");
	}

}
