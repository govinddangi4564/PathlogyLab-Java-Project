package com.pathology.controller;

import java.io.IOException;
import java.util.List;

import com.pathology.dao.AppointmentDao;
import com.pathology.dao.PatientDao;
import com.pathology.dao.ReportDao;
import com.pathology.dao.UserDao;
import com.pathology.model.Appointment;
import com.pathology.model.Patient;
import com.pathology.model.Report;
import com.pathology.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/viewPatients", "/viewAllPatientByOffset", "/viewAllReports", "/viewReport",
		"/viewAllReportsByOffset", "/viewStaff", "/viewAppointmentReport", "/viewMyAppointment" })
public class ViewReports extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String path = request.getServletPath();

		if (path.equals("/viewPatients")) {

			PatientDao dao = new PatientDao();
			List<Patient> list = dao.viewAllPatients();

			request.setAttribute("patientList", list);
			request.getRequestDispatcher("Pages/viewAllPatients.jsp").forward(request, response);

		} else if (path.equals("/viewAllReports")) {

			ReportDao dao = new ReportDao();
			List<Report> list = dao.reportList();

			request.setAttribute("reportList", list);
			request.getRequestDispatcher("Pages/viewAllReports.jsp").forward(request, response);

		} else if (path.equals("/viewReport")) {

			String pId = request.getParameter("pId");
			ReportDao dao = new ReportDao();
			List<Report> list = dao.patientReport(pId);

			request.setAttribute("reportList", list);
			request.getRequestDispatcher("./Pages/viewAllReports.jsp").forward(request, response);

		} else if (path.equals("/viewStaff")) {

			UserDao dao = new UserDao();
			List<User> list = dao.staffList();

			request.setAttribute("staffList", list);
			request.getRequestDispatcher("./Pages/viewStaff.jsp").forward(request, response);

		} else if (path.equals("/viewAllReportsByOffset")) {

			int offset = Integer.parseInt(request.getParameter("offset"));
			ReportDao dao = new ReportDao();
			List<Report> list = dao.reportList(offset);

			request.setAttribute("reportList", list);
			request.getRequestDispatcher("Pages/viewAllReports.jsp").forward(request, response);

		} else if (path.equals("/viewAllPatientByOffset")) {

			int offset = Integer.parseInt(request.getParameter("offset"));
			PatientDao dao = new PatientDao();
			List<Patient> list = dao.viewAllPatients(offset);

			request.setAttribute("patientList", list);
			request.getRequestDispatcher("Pages/viewAllPatients.jsp").forward(request, response);

		} else if (path.equals("/viewAppointmentReport")) {

			String key = request.getParameter("key");

			AppointmentDao dao = new AppointmentDao();
			List<Appointment> list = dao.viewAppointment(key);

			request.setAttribute("appointmentList", list);
			request.getRequestDispatcher("Pages/viewAppointment.jsp").forward(request, response);

		} else if (path.equals("/viewMyAppointment")) {

			String patientId = request.getParameter("pId");
			if (patientId == null || patientId.trim().isEmpty()) {
				response.sendRedirect(request.getContextPath() + "/Pages/User/manageAppointments.jsp");
				return;
			}

			AppointmentDao dao = new AppointmentDao();
			List<Appointment> list = dao.myAppointment(patientId);

			request.setAttribute("myAppointment", list);
			request.getRequestDispatcher("Pages/User/myAppointment.jsp").forward(request, response);

		}
	}
}