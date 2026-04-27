package com.pathology.service;

import java.io.File;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

public class EmailFileService {

	private static final ResourceBundle bundle = ResourceBundle.getBundle("config");

	private static final String FROM_EMAIL = bundle.getString("email.from");
	private static final String APP_PASS = bundle.getString("email.password");
	private static final String SMTP_HOST = bundle.getString("email.smtp.host");
	private static final String SMTP_PORT = bundle.getString("email.smtp.port");

	public static boolean sendWithAttachment(String toEmail, String subject, String body, File file) {

		try {
			// Validate file
			if (file == null || !file.exists()) {
				System.out.println("File not found!");
				return false;
			}

			// Mail properties
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", SMTP_HOST);
			props.put("mail.smtp.port", SMTP_PORT);

			// Session
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(FROM_EMAIL, APP_PASS);
				}
			});

			// Message
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject(subject);

			// Body
			MimeBodyPart textPart = new MimeBodyPart();
			textPart.setContent(body, "text/html");

			// Attachment
			MimeBodyPart filePart = new MimeBodyPart();
			filePart.attachFile(file);

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(filePart);

			message.setContent(multipart);

			// Send
			Transport.send(message);

			return true;

		} catch (MessagingException | IOException e) {
			e.printStackTrace();
			return false;
		}
	}
}