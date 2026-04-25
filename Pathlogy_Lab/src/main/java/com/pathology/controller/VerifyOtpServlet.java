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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/Pages/forgetPassword.jsp");
			return;
		}

		String email = (String) session.getAttribute("email");
		String userOtp = request.getParameter("otp");
		String work = (String) session.getAttribute("work");

		if ("signup".equals(work)) {
			String sentOtp = (String) session.getAttribute("otp");
			Long otpTime = (Long) session.getAttribute("otpTime");

			long diff = System.currentTimeMillis() - otpTime;
			long minutes = diff / (1000 * 60);

			if (minutes > 10) {
				session.setAttribute("errorMsg", "OTP expired");
				response.sendRedirect("./Pages/verifyOtp.jsp");
				return;
			}

			if (sentOtp != null && sentOtp.equals(userOtp)) {
				session.removeAttribute("otp");
				session.setAttribute("successMsg", "OTP Verified");
				response.sendRedirect(request.getContextPath() + "/signup");
			} else {
				session.setAttribute("errorMsg", "Invalid OTP");
				response.sendRedirect(request.getContextPath() + "/Pages/verifyOtp.jsp");
			}

		} else {

			if (email == null || userOtp == null) {
				session.setAttribute("errorMsg", "Session expired. Try again.");
				response.sendRedirect(request.getContextPath() + "/Pages/forgetPassword.jsp");
				return;
			}
			UserDao dao = new UserDao();
			User dbUser = dao.verifyOtp(email); // db otp + time

			if (dbUser != null && dbUser.getOtp() != null && dbUser.getOtpTime() != null) {
				String dbOtp = dbUser.getOtp();
				Timestamp otpTime = dbUser.getOtpTime();

				long diff = System.currentTimeMillis() - otpTime.getTime();
				long minutes = diff / (1000 * 60);

				if (minutes > 10) {
					session.setAttribute("errorMsg", "OTP expired");
					response.sendRedirect("./Pages/verifyOtp.jsp");

				} else if (dbOtp.equals(userOtp)) {

					// clear OTP after verify
					dao.clearOtp(email);

					session.setAttribute("otpVerified", true);

					session.setAttribute("successMsg", "OTP Verified");
					response.sendRedirect(request.getContextPath() + "/Pages/updatePassword.jsp");
				} else {
					session.setAttribute("errorMsg", "Invalid OTP");
					response.sendRedirect(request.getContextPath() + "/Pages/verifyOtp.jsp");
				}

			} else {
				session.setAttribute("errorMsg", "Invalid request or OTP not found");
				response.sendRedirect(request.getContextPath() + "/Pages/verifyOtp.jsp");
			}
		}
	}
}
