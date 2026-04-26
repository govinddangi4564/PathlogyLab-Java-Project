package com.pathology.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalTime;

import com.pathology.dao.AppointmentDao;
import com.pathology.dao.PatientDao;
import com.pathology.model.Appointment;
import com.pathology.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BookAppointmentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		String test = request.getParameter("testName");

		String appointmentDate = request.getParameter("appointmentDate");
		Date apDate = Date.valueOf(appointmentDate);

		String appointmentTime = request.getParameter("appointmentTime");
		LocalTime apTime = LocalTime.parse(appointmentTime);

		String loc = request.getParameter("labLocation");
		String priority = request.getParameter("priority");

		String name = request.getParameter("patientName");
		String email = request.getParameter("patientEmail");
		String mobile = request.getParameter("patientMobile");

		PatientDao pDao = new PatientDao();
		AppointmentDao apDao = new AppointmentDao();

		Patient p = new Patient(name, email, mobile);
		String patientUID = pDao.addPatient(p);

		if (patientUID == null) {
			session.setAttribute("errorMsg", "Patient creation failed");
			response.sendRedirect(request.getContextPath() + "/Pages/bookAppointment.jsp");
			return;
		}

		Appointment ap = new Appointment(patientUID, test, apDate, apTime, loc, priority);

		int i = apDao.bookAppointment(ap);

		if (i > 0) {
			session.setAttribute("successMsg", "Appointment Booked Successfully (Patient UID: " + patientUID + ")");
		} else {
			session.setAttribute("errorMsg", "Appointment Booking Failed");
		}

		response.sendRedirect(request.getContextPath() + "/Pages/User/bookAppointment.jsp");
	}
}
