package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathology.dao.PatientDao;
import com.pathology.dao.ReportDao;
import com.pathology.model.Patient;
import com.pathology.model.Report;

@WebServlet(urlPatterns = { "/viewPatients", "/viewAllReports", "/viewReport" })
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
		}
	}
}