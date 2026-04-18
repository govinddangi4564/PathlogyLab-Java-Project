package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathology.dao.PatientDao;
import com.pathology.model.Patient;

@WebServlet("/addPatient")
public class AddPatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddPatientServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("patientName");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");

		PatientDao dao = new PatientDao();

		Patient p = new Patient(name, email, mobile);

		int i = dao.addPatient(p);

		if (i != 0) {
			response.sendRedirect(request.getContextPath() + "/Pages/admin-dashboard.jsp");
		} else {
			request.setAttribute("msg", "Failed to add Patient.");
			request.getRequestDispatcher("./Pages/addPatient.jsp").forward(request, response);
		}

	}

}
