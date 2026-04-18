package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.pathology.dao.ReportDao;
import com.pathology.model.Report;
import com.pathology.model.User;

@MultipartConfig
@WebServlet("/uploadReport")
public class UploadReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadReport() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User u = (User) request.getSession().getAttribute("userObj");

		if (u == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int userId = u.getId();

		String patientId = request.getParameter("patientId");
		String title = request.getParameter("reportName");
		String reportStatus = request.getParameter("reportStatus");

		Part pt = request.getPart("reportFile");
		String path = "D:\\All Codes\\Java FullStack Projects\\Pathlogy Lab\\Pathlogy Lab\\src\\main\\webapp\\reports\\";

		String report = title + "_" + pt.getSubmittedFileName();
		pt.write(path + File.separator + report);

		Report r = new Report(userId, patientId, title, report, reportStatus);

		ReportDao dao = new ReportDao();

		int i = dao.uploadReport(r);

		if (i != 0) {
			request.getSession().setAttribute("msg", "Report update successfully");
		} else {
			request.getSession().setAttribute("msg", "Something Went Wrong.");
		}

		response.sendRedirect("./Pages/uploadReport.jsp");

	}

}
