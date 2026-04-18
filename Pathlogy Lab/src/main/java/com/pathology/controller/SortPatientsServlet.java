package com.pathology.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathology.dao.PatientDao;
import com.pathology.model.Patient;

@WebServlet("/sortPatients")
public class SortPatientsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SortPatientsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String sort = request.getParameter("sort");
		String order = request.getParameter("order");

		if (sort == null)
			sort = "patient_name";
		if (order == null)
			order = "asc";

		if (!order.equalsIgnoreCase("asc") && !order.equalsIgnoreCase("desc")) {
			order = "asc";
		}

		PatientDao dao = new PatientDao();

		List<Patient> list = dao.sortPatients(sort, order);

		request.setAttribute("reportList", list);
		request.getRequestDispatcher("./Pages/viewAllPatients.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
