package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

		HttpSession session = request.getSession();

		if (name == null || name.trim().isEmpty()) {
			session.setAttribute("errorMsg", "Patient name is required");
			response.sendRedirect(request.getContextPath() + "/Pages/addPatient.jsp");
			return;
		}

		PatientDao dao = new PatientDao();
		Patient p = new Patient(name, email, mobile);

		String patientUID = dao.addPatient(p);

		if (patientUID != null) {
			session.setAttribute("successMsg", "Patient Added Successfully. UID: " + patientUID);
		} else {
			session.setAttribute("errorMsg", "Something Went Wrong");
		}
		response.sendRedirect(request.getContextPath() + "/Pages/addPatient.jsp");
	}
}
