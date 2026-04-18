package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.pathology.dao.ReportDao;
import com.pathology.model.Report;

@WebServlet("/viewReport")
public class ViewReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ViewReportServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pId = request.getParameter("pId");
		ReportDao dao = new ReportDao();

		List<Report> list = dao.patientReport(pId);

		request.setAttribute("reportList", list);
		request.getRequestDispatcher("./Pages/viewAllReports.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
