package com.pathology.controller;

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
import java.io.IOException;
import java.util.Properties;

import com.pathology.dao.UserDao;

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendOtpServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public String generateOtp() {
		return String.valueOf((int) (Math.random() * 900000) + 100000);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String otp = generateOtp();

		request.getSession().setAttribute("email", email);

		UserDao dao = new UserDao();
		int i = dao.storeOtp(email, otp);

		String from = "govinddangi5811@gmail.com";
		String appPass = "jrhcujbnbnkhzdlf";

		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.host", "smtp.gmail.com");
		props.setProperty("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, appPass);
			}
		});

		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			msg.setSubject("OTP for Password Reset - Pathology Lab");
			msg.setText("Dear User,\n\n"
					+ "Please use the following One-Time Password (OTP) to proceed with your request.\n\n"
					+ "Your OTP is: " + otp + "\n\n"
					+ "Note: This OTP is valid for the next 10 minutes. Please do not share it with anyone.\n\n"
					+ "Thank you,\nPathology Lab");

			Transport.send(msg);

			if (i != 0) {
				request.getSession().setAttribute("msg", "OTP sent successfully");
			} else {
				request.getSession().setAttribute("msg", "Something Went Wrong.");
			}

			response.sendRedirect("./Pages/verifyOtp.jsp");

		} catch (MessagingException e) {

		}
	}

}
