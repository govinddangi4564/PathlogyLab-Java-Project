package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		String name = (String) session.getAttribute("name");
		String email = (String) session.getAttribute("email");
		String mob = (String) session.getAttribute("mobile");
		String pass = (String) session.getAttribute("pass");

		UserDao dao = new UserDao();

		// Hash password
		String hashPass = BCrypt.hashpw(pass, BCrypt.gensalt());

		// Role fixed (no user input)
		User us = new User(name, email, mob, hashPass, "USER");

		// Step 2: Insert
		int i = dao.signup(us);

		if (i > 0) {
			session.removeAttribute("mobile");
			session.removeAttribute("pass");

			session.setAttribute("successMsg", "Registration Successful. Please login.");
			response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
		} else {
			session.setAttribute("errorMsg", "Something went wrong. Try again.");
			response.sendRedirect(request.getContextPath() + "/Pages/signup.jsp");
		}
	}

}
