package com.pathology.controller;

import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import com.pathology.dao.UserDao;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
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
				response.sendRedirect(request.getContextPath() + "/Pages/forgetPassword.jsp");
				return;
			}
			i = dao.storeOtp(email, otp);

		} else if ("signup".equals(work)) {

			if (dao.isEmailExists(email)) {
				session.setAttribute("errorMsg", "Email already registered");
				response.sendRedirect("Pages/signup.jsp");
				return;
			}

			String name = request.getParameter("fullName");
			String mob = request.getParameter("mobile");
			String pass = request.getParameter("password");

			session.setAttribute("name", name);
			session.setAttribute("mobile", mob);
			session.setAttribute("pass", pass);

			session.setAttribute("otp", otp);
			session.setAttribute("otpTime", System.currentTimeMillis());
		}

		session.setAttribute("email", email);
		session.setAttribute("otpVerified", false);
		session.setAttribute("work", work);

		// Load credentials from properties file
		ResourceBundle bundle = ResourceBundle.getBundle("config");
		String fromEmail = bundle.getString("email.from");
		String appPass = bundle.getString("email.password");
		String smtpHost = bundle.getString("email.smtp.host");
		String smtpPort = bundle.getString("email.smtp.port");

		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.host", smtpHost);
		props.setProperty("mail.smtp.port", smtpPort);

		Session mailSession = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, appPass);
			}
		});

		try {
			MimeMessage msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(fromEmail));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

			String subject = "";
			String actionText = "";

			if ("signup".equals(work)) {
				subject = "OTP for Signup - Pathology Lab";
				actionText = "verify your account registration";
			} else if ("reset".equals(work)) {
				subject = "OTP for Password Reset - Pathology Lab";
				actionText = "reset your password";
			}

			msg.setSubject(subject);

			String message = "<html>"
					+ "<body style='font-family:Arial, sans-serif; background:#f4f6f8; padding:20px;'>"

					+ "<div style='max-width:500px; margin:auto; background:#ffffff; padding:25px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);'>"

					+ "<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>"
					+ "<hr style='border:none; border-top:1px solid #eee;'>"

					+ "<p style='font-size:15px;'>Dear User,</p>"

					+ "<p style='font-size:15px;'>We received a request to <b>" + actionText
					+ "</b>. Please use the OTP below:</p>"

					+ "<div style='text-align:center; margin:25px 0;'>"
					+ "<span style='font-size:28px; letter-spacing:5px; font-weight:bold; color:#ffffff; background:#0b7a75; padding:12px 25px; border-radius:8px;'>"
					+ otp + "</span>" + "</div>"

					+ "<p style='font-size:14px; color:#555;'>This OTP is valid for <b>10 minutes</b>. Please do not share it with anyone.</p>"

					+ "<p style='font-size:13px; color:#888;'>If you did not request this, please ignore this email.</p>"

					+ "<hr style='border:none; border-top:1px solid #eee;'>"
					+ "<p style='font-size:13px; color:#888; text-align:center;'>© 2026 Pathology Lab</p>"

					+ "</div></body></html>";

			msg.setContent(message, "text/html");

			Transport.send(msg);

			if (i > 0) {
				session.setAttribute("successMsg", "OTP sent successfully");
			} else {
				session.setAttribute("errorMsg", "Something went wrong");
			}

		} catch (MessagingException e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Email sending failed");
		}
		response.sendRedirect(request.getContextPath() + "/Pages/verifyOtp.jsp");
	}
}
