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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String emailOrMobile = request.getParameter("loginId");
		String pass = request.getParameter("password");
		String role = request.getParameter("role");

		UserDao dao = new UserDao();
		User user = dao.login(emailOrMobile,role);

		if (user != null && BCrypt.checkpw(pass, user.getPassword())) {

			HttpSession session = request.getSession();
			session.setAttribute("userObj", user);

			if ("USER".equals(role)) {
				response.sendRedirect("Pages/user-dashboard.jsp");
			} else {
				response.sendRedirect("Pages/admin-dashboard.jsp");
			}

		} else {
			request.setAttribute("msg", "Invalid Credentials");
			request.getRequestDispatcher("./Pages/login.jsp").forward(request, response);
		}
	}

}
