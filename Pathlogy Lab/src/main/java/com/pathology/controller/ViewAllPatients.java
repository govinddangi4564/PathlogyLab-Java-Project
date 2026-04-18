package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathology.dao.PatientDao;
import com.pathology.model.Patient;

@WebServlet("/viewPatients")
public class ViewAllPatients extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ViewAllPatients() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PatientDao dao = new PatientDao();
		List<Patient> list = dao.viewAllPatients();

		request.setAttribute("reportList", list);
		request.getRequestDispatcher("./Pages/viewAllPatients.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
