package com.pathology.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Report;

public class ReportDao {

	// ------------ ADMIN ---------------------

	public int uploadReport(Report r) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO reports (user_id, patient_id, report_name, file_path, status) values (?,?,?,?,?)")) {

			pst.setInt(1, r.getUserId());
			pst.setString(2, r.getPatientId());
			pst.setString(3, r.getReportName());
			pst.setString(4, r.getReportPath());
			pst.setString(5, "Pending");

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public List<Report> reportList() {
		List<Report> list = new LinkedList<Report>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT r.*, p.patient_name FROM reports r JOIN patients p ON r.patient_id = p.patient_uid")) {

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String patientId = rs.getString("patient_id");
				String report = rs.getString("report_name");
				String path = rs.getString("file_path");
				Date dt = rs.getDate("upload_date");
				String status = rs.getString("status");
				boolean emailSent = rs.getBoolean("email_sent");
				String patientName = rs.getString("patient_name");

				list.add(new Report(id, patientId, report, path, dt, status, patientName, emailSent));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Report> patientReport(String pId) {
		List<Report> list = new LinkedList<Report>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT r.*, p.patient_name FROM reports r JOIN patients p ON r.patient_id = p.patient_uid WHERE r.patient_id = ?")) {

			pst.setString(1, pId);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String patientId = rs.getString("patient_id");
				String patientName = rs.getString("patient_name");
				String report = rs.getString("report_name");
				String path = rs.getString("file_path");
				Date dt = rs.getDate("upload_date");
				String status = rs.getString("status");
				boolean emailSent = rs.getBoolean("email_sent");

				list.add(new Report(id, patientId, report, path, dt, status, patientName, emailSent));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public int deleteReport(int id) {
		int i = 0;

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pst = con.prepareStatement("DELETE FROM reports WHERE id = ?");

			pst.setInt(1, id);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public int totalReports() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT COUNT(id) AS total FROM reports")) {

			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("total");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int totalPendingReports() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM reports where status = ?")) {
			pst.setString(1, "Pending");

			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int totalCompletedReports() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM reports where status = ?")) {
			pst.setString(1, "Completed");

			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int totalDeliveredReports() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM reports where status = ?")) {
			pst.setString(1, "Delivered");

			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<Report> filterReport(String search, String type, String status, String sort) {

		List<Report> list = new ArrayList<Report>();

		String query = "SELECT r.*, p.patient_name FROM reports r JOIN patients p ON r.patient_id = p.patient_uid WHERE 1=1";

		if (search != null && !search.isEmpty()) {
			query += " AND (report_name LIKE ? OR patient_id LIKE ? OR status LIKE ?)";
		}

		if (type != null && !type.isEmpty()) {
			query += " AND report_name = ?";
		}

		if (status != null && !status.isEmpty()) {
			query += " AND status = ?";
		}

		if (sort != null && !sort.isEmpty()) {
			switch (sort) {
			case "date_desc":
				query += " ORDER BY upload_date DESC";
				break;
			case "date_asc":
				query += " ORDER BY upload_date ASC";
				break;
			case "name_asc":
				query += " ORDER BY report_name ASC";
				break;
			case "name_desc":
				query += " ORDER BY report_name DESC";
				break;
			}
		}

		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

			int i = 1;

			if (search != null && !search.isEmpty()) {
				pst.setString(i++, "%" + search + "%");
				pst.setString(i++, "%" + search + "%");
				pst.setString(i++, "%" + search + "%");
			}

			if (type != null && !type.isEmpty()) {
				pst.setString(i++, type);
			}

			if (status != null && !status.isEmpty()) {
				pst.setString(i++, status);
			}

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String patientId = rs.getString("patient_id");
				String patientName = rs.getString("patient_name");
				String report = rs.getString("report_name");
				String path = rs.getString("file_path");
				Date dt = rs.getDate("upload_date");
				String sts = rs.getString("status");
				boolean emailSent = rs.getBoolean("email_sent");

				list.add(new Report(id, patientId, report, path, dt, sts, patientName, emailSent));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// ------------------------- USER / PATIENT------------------------

	public List<Report> reportList(String email) {
		List<Report> list = new LinkedList<Report>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT r.id AS report_id, p.patient_name, r.report_name, r.file_path, r.status, r.upload_date FROM patients p JOIN reports r ON p.patient_uid = r.patient_id WHERE p.patient_email = ?")) {

			pst.setString(1, email);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int rId = rs.getInt("report_id");
				String patientName = rs.getString("patient_name");
				String report = rs.getString("report_name");
				String reportPath = rs.getString("file_path");
				String status = rs.getString("status");
				Date dt = rs.getDate("upload_date");

				list.add(new Report(rId, report, reportPath, dt, status, patientName));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Report getReport(int id) {
		Report r = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT p.patient_email, r.file_path FROM patients p JOIN reports r ON p.patient_uid = r.patient_id WHERE r.id = ?")) {
			pst.setInt(1, id);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				r = new Report(rs.getString("file_path"), rs.getString("patient_email"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return r;
	}

	public int updateStatus(int id) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("UPDATE reports SET status = ? WHERE id = ?")) {
			pst.setString(1, "Completed");
			pst.setInt(2, id);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	public int markEmailSent(int reportId) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("UPDATE reports SET email_sent = ? WHERE id = ?")) {
			pst.setBoolean(1, true);
			pst.setInt(2, reportId);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	public int updateDeliverdStatus(int id) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("UPDATE reports SET status = ? WHERE id = ?")) {
			pst.setString(1, "Delivered");
			pst.setInt(2, id);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}
}
