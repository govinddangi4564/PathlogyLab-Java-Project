package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

import com.pathology.dao.UserDao;
import com.pathology.model.User;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public VerifyOtpServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		String email = (String) request.getSession().getAttribute("email");

		String userOtp = request.getParameter("otp"); // User entered otp

		UserDao dao = new UserDao();
		User dbUser = dao.verifyOtp(email); // db otp + time

		if (dbUser != null) {
			String dbOtp = dbUser.getOtp();
			Timestamp otpTime = dbUser.getOtpTime();

			Timestamp currentTime = new Timestamp(System.currentTimeMillis());

			long diff = currentTime.getTime() - otpTime.getTime();
			long minutes = diff / (1000 * 60);

			if (minutes > 10) {
				session.setAttribute("msg", "OTP expired");
				response.sendRedirect("./Pages/verifyOtp.jsp");
			} else if (dbOtp.equals(userOtp)) {

				// clear OTP after verify
				dao.clearOtp(email);

				session.setAttribute("msg", "OTP Verified");
				response.sendRedirect("./Pages/updatePassword.jsp");
			} else {
				session.setAttribute("msg", "Invalid OTP");
				response.sendRedirect("./Pages/verifyOtp.jsp");
			}
		} else {
			session.setAttribute("msg", "Something Went Wrong");
			response.sendRedirect("./Pages/verifyOtp.jsp");
		}

	}

}
