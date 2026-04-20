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

@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdatePasswordServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("email") == null) {
			response.sendRedirect("./Pages/login.jsp");
			return;
		}

		String email = (String) session.getAttribute("email");

		String nPass = request.getParameter("newPassword");
		String cPass = request.getParameter("confirmPassword");

		if (!nPass.equals(cPass)) {
			session.setAttribute("msg", "Passwords do not match");
			response.sendRedirect("./Pages/updatePassword.jsp");
			return;
		}
		String hashPass = BCrypt.hashpw(nPass, BCrypt.gensalt());

		UserDao dao = new UserDao();

		int i = dao.updatePassword(email, hashPass);

		if (i != 0) {
			session.removeAttribute("email");
			session.setAttribute("msg", "Password Updated Successfully");
			response.sendRedirect(request.getContextPath() + "./Pages/login.jsp");
		} else {
			session.setAttribute("msg", "Failed to update password");
			response.sendRedirect("./Pages/updatePassword.jsp");
		}
	}

}
