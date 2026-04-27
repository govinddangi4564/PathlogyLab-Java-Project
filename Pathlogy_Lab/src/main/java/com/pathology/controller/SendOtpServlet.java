package com.pathology.controller;

import java.io.IOException;

import com.pathology.dao.UserDao;
import com.pathology.service.EmailService;
import com.pathology.template.OtpTemplate;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendOtpServlet() {
		super();
	}

	public String generateOtp() {
		return String.valueOf((int) (Math.random() * 900000) + 100000);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String work = request.getParameter("work");

		HttpSession session = request.getSession();
		UserDao dao = new UserDao();

		String otp = generateOtp();
		int i = 1;

		if ("reset".equals(work)) {

			if (!dao.isEmailExists(email)) {
				session.setAttribute("errorMsg", "Email not registered");
				response.sendRedirect("Pages/forgetPassword.jsp");
				return;
			}

			i = dao.storeOtp(email, otp);

		} else if ("signup".equals(work)) {

			if (dao.isEmailExists(email)) {
				session.setAttribute("errorMsg", "Email already registered");
				response.sendRedirect("Pages/signup.jsp");
				return;
			}

			session.setAttribute("name", request.getParameter("fullName"));
			session.setAttribute("mobile", request.getParameter("mobile"));
			session.setAttribute("pass", request.getParameter("password"));

			session.setAttribute("otp", otp);
			session.setAttribute("otpTime", System.currentTimeMillis());
		}

		session.setAttribute("email", email);
		session.setAttribute("otpVerified", false);
		session.setAttribute("work", work);

		String subject = "";
		String actionText = "";

		if ("signup".equals(work)) {
			subject = "OTP for Signup - Pathology Lab";
			actionText = "verify your account";
		} else {
			subject = "OTP for Password Reset - Pathology Lab";
			actionText = "reset your password";
		}

		String body = OtpTemplate.getTemplate(otp, actionText);

		try {
			EmailService.sendEmail(email, subject, body);

			if (i > 0) {
				session.setAttribute("successMsg", "OTP sent successfully");
			} else {
				session.setAttribute("errorMsg", "Something went wrong");
			}

		} catch (MessagingException e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Email sending failed");
		}

		response.sendRedirect("Pages/verifyOtp.jsp");
	}
}
