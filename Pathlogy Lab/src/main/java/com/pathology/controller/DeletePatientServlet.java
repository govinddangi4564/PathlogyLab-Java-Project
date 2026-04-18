package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathology.dao.PatientDao;
import com.pathology.dao.ReportDao;
import com.sun.net.httpserver.Request;

@WebServlet("/deletePatient")
public class DeletePatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeletePatientServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pId = request.getParameter("pId");
		PatientDao dao = new PatientDao();

		
		int i = dao.deletePatient(pId);

		if (i != 0) {
			request.getSession().setAttribute("msg", "Patient deleted successfully");
		} else {
			request.getSession().setAttribute("msg", "Delete failed");
		}

		response.sendRedirect("viewPatients");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
