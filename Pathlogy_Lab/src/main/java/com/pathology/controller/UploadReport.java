package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

		HttpSession session = request.getSession();

		User u = (User) session.getAttribute("userObj");

		if (u == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int userId = u.getId();

		String patientId = request.getParameter("patientId");
		String title = request.getParameter("reportName");

		Part pt = request.getPart("reportFile");
		String path = "D:\\All Codes\\Java FullStack Projects\\Pathlogy_Lab\\Pathlogy_Lab\\src\\main\\webapp\\reports\\";

		File uploadDir = new File(path);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		String report = System.currentTimeMillis() + "_" + pt.getSubmittedFileName();
		pt.write(path + File.separator + report);

		Report r = new Report(userId, patientId, title, report);

		ReportDao dao = new ReportDao();

		int i = dao.uploadReport(r);

		if (i > 0) {
			session.setAttribute("successMsg", "Report update successfully");
		} else {
			session.setAttribute("errorMsg", "Something Went Wrong.");
		}
		response.sendRedirect(request.getContextPath() + "/Pages/uploadReport.jsp");
	}

}
