package com.pathology.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;

import com.pathology.dao.AppointmentDao;
import com.pathology.model.Appointment;

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String role = (String) session.getAttribute("role");

		String name = request.getParameter("patientName");
		String email = request.getParameter("patientEmail");
		String mobile = request.getParameter("patientMobile");
		String test = request.getParameter("testName");

		String appointmentDate = request.getParameter("appointmentDate");
		LocalDate localDate = LocalDate.parse(appointmentDate);
		Date apDate = Date.valueOf(localDate);

		String appointmentTime = request.getParameter("appointmentTime");
		LocalTime apTime = null;

		if (appointmentTime != null && !appointmentTime.isEmpty()) {
			apTime = LocalTime.parse(appointmentTime);
		}

		String loc = request.getParameter("labLocation");
		String priority = request.getParameter("priority");
		String mode = request.getParameter("mode");
		String status = request.getParameter("status");

		Appointment ap = new Appointment(name, email, mobile, test, apDate, apTime, loc, status, priority, mode);

		AppointmentDao apDao = new AppointmentDao();

		int i = apDao.bookAppointment(ap);

		if (i > 0) {
			session.setAttribute("successMsg", "Appointment Booked Successfully.");
		} else {
			session.setAttribute("errorMsg", "Appointment Booking Failed");
		}

		if ("USER".equals(role)) {
			response.sendRedirect(request.getContextPath() + "/Pages/bookAppointmentSelf.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/Pages/User/bookAppointment.jsp");
		}
	}
}
