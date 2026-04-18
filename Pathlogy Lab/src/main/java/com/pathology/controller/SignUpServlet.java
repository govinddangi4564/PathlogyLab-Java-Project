package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.pathology.dao.UserDao;
import com.pathology.model.User;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SignUpServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("fullName");
		String email = request.getParameter("email");
		String mob = request.getParameter("mobile");
		String pass = request.getParameter("password");
		String role = request.getParameter("role");

		String hashPass = BCrypt.hashpw(pass, BCrypt.gensalt());

		User us = new User(name, email, mob, hashPass, role);

		UserDao dao = new UserDao();

		int i = dao.signup(us);

		if (i != 0) {
			response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
		} else {
			response.setContentType("text/html");
			response.getWriter().println("<h3 style='color:red;'>Something went wrong</h3>");
		}

	}

}
