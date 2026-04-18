package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathology.dao.ReportDao;

@WebServlet("/deleteReport")
public class DeleteReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteReportServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));

		ReportDao dao = new ReportDao();

		int i = dao.deleteReport(id);

		if (i != 0) {
			request.getSession().setAttribute("msg", "Report deleted successfully");
		} else {
			request.getSession().setAttribute("msg", "Delete failed");
		}

		response.sendRedirect("viewAllReports");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
