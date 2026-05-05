package com.pathology.controller;

import java.io.IOException;
import java.util.List;

import com.pathology.dao.AppointmentDao;
import com.pathology.dao.PatientDao;
import com.pathology.dao.ReportDao;
import com.pathology.model.Appointment;
import com.pathology.model.Patient;
import com.pathology.model.Report;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/searchPatient", "/filterReport", "/filterAppointments" })
public class FilterReportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();

		if (path.equals("/searchPatient")) {
			String key = request.getParameter("search");
			PatientDao dao = new PatientDao();
			List<Patient> list = dao.searchPatient(key);

			request.setAttribute("patientList", list);
			request.getRequestDispatcher("./Pages/viewAllPatients.jsp").forward(request, response);

		} else if (path.equals("/filterReport")) {
			String search = request.getParameter("search");
			String type = request.getParameter("type");
			String status = request.getParameter("status");
			String sort = request.getParameter("sort");

			ReportDao dao = new ReportDao();
			List<Report> list = dao.filterReport(search, type, status, sort);

			request.setAttribute("reportList", list);
			request.getRequestDispatcher("./Pages/viewAllReports.jsp").forward(request, response);

		} else if (path.equals("/filterAppointments")) {
			String search = request.getParameter("search");
			String type = request.getParameter("type");
			String status = request.getParameter("status");
			String priority = request.getParameter("priority");
			String date = request.getParameter("date");

			AppointmentDao dao = new AppointmentDao();
			List<Appointment> list = dao.filterAppointments(search, type, status, priority, date);

			request.setAttribute("appointmentList", list);
			request.getRequestDispatcher("Pages/viewAppointment.jsp").forward(request, response);
		}
	}

}
