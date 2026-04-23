package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathology.dao.PatientDao;
import com.pathology.dao.ReportDao;
import com.pathology.dao.UserDao;
import com.sun.net.httpserver.Request;

@WebServlet(urlPatterns = { "/deletePatient", "/deleteReport", "/deleteStaff" })
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String path = request.getServletPath();

		if (path.equals("/deletePatient")) {

			String pId = request.getParameter("pId");
			PatientDao dao = new PatientDao();
			int i = dao.deletePatient(pId);

			if (i != 0) {
				request.setAttribute("msg", "Patient deleted successfully");
			} else {
				request.setAttribute("msg", "Delete failed");
			}
			request.getRequestDispatcher("viewPatients").forward(request, response);

		} else if (path.equals("/deleteReport")) {
			int id = Integer.parseInt(request.getParameter("id"));
			ReportDao dao = new ReportDao();
			int i = dao.deleteReport(id);

			if (i != 0) {
				request.setAttribute("msg", "Report deleted successfully");
			} else {
				request.setAttribute("msg", "Delete failed");
			}
			request.getRequestDispatcher("viewAllReports").forward(request, response);

		} else if (path.equals("/deleteStaff")) {
			int id = Integer.parseInt(request.getParameter("id"));
			UserDao dao = new UserDao();

			int i = dao.deleteStaff(id);

			if (i != 0) {
				request.setAttribute("msg", "Staff deleted successfully");
			} else {
				request.setAttribute("msg", "Delete failed");
			}
			request.getRequestDispatcher("viewStaff").forward(request, response);
		}
	}
}
