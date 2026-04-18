package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/downloadReport")
public class DownloadReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DownloadReport() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fileName = request.getParameter("file");

		String path = request.getServletContext().getRealPath("/reports");

		File file = new File(path, fileName);

		if (!file.exists()) {
			response.getWriter().println("File not found");
			return;
		}

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

		FileInputStream fis = new FileInputStream(file);
		OutputStream os = response.getOutputStream();

		byte[] buffer = new byte[4096];
		int bytesread;

		while ((bytesread = fis.read(buffer)) != -1) {
			os.write(buffer, 0, bytesread);
		}

		fis.close();
		os.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
