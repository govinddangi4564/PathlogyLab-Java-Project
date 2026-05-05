package com.pathology.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Appointment;

public class AppointmentDao {

	public int bookAppointment(Appointment ap) {
		int i = 0;
		String patientUID = null;

		try (Connection con = DBConnection.getConnection()) {

			con.setAutoCommit(false);

			// 1. Get user id
			int userId = 0;
			PreparedStatement pst2 = con.prepareStatement("SELECT id FROM users WHERE email = ? OR mobile = ?");
			pst2.setString(1, ap.getPatientEmail());
			pst2.setString(2, ap.getPatientMobile());

			ResultSet rs2 = pst2.executeQuery();
			if (rs2.next()) {
				userId = rs2.getInt("id");
			}

			// 2. Check patient exists
			PreparedStatement pst3 = con
					.prepareStatement("SELECT id, patient_uid FROM patients WHERE patient_email = ?");
			pst3.setString(1, ap.getPatientEmail());

			ResultSet rs3 = pst3.executeQuery();
			int patientId = 0;

			if (rs3.next()) {
				patientId = rs3.getInt("id");
				patientUID = rs3.getString("patient_uid");
			} else {
				// Insert new patient
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO patients (patient_name, patient_email, patient_mobile, user_id) VALUES(?,?,?,?)",
						PreparedStatement.RETURN_GENERATED_KEYS);

				pst.setString(1, ap.getPatientName());
				pst.setString(2, ap.getPatientEmail());
				pst.setString(3, ap.getPatientMobile());
				pst.setInt(4, userId);

				pst.executeUpdate();

				ResultSet rs = pst.getGeneratedKeys();
				if (rs.next()) {
					patientId = rs.getInt(1);
					patientUID = "pt-" + (10000 + patientId);

					PreparedStatement pst1 = con.prepareStatement("UPDATE patients SET patient_uid = ? WHERE id = ?");
					pst1.setString(1, patientUID);
					pst1.setInt(2, patientId);
					pst1.executeUpdate();
				}
			}

			// 3. Generate token
			int tokenNo = 0;
			PreparedStatement pst4 = con.prepareStatement("SELECT COALESCE(MAX(token_no), 0) + 1 AS next_token "
					+ "FROM appointments WHERE appointment_date = ? AND status = 'Confirmed' AND lab_location = ?");

			pst4.setDate(1, ap.getAppointmentDate());
			pst4.setString(2, ap.getLabLocation());

			ResultSet rs4 = pst4.executeQuery();
			if (rs4.next()) {
				tokenNo = rs4.getInt("next_token");
			}

			// 4. Book appointment (for both new & existing patient)
			PreparedStatement pst5 = con.prepareStatement(
					"INSERT INTO appointments (patient_id, test_name, appointment_date, time_slot, lab_location, status, priority, token_no, booking_type) VALUES(?,?,?,?,?,?,?,?,?)");

			pst5.setString(1, patientUID);
			pst5.setString(2, ap.getTestName());
			pst5.setDate(3, ap.getAppointmentDate());

			if ("Online".equalsIgnoreCase(ap.getMode())) {
				pst5.setTime(4, Time.valueOf(ap.getAppointmentTime()));
			} else {
				pst5.setNull(4, java.sql.Types.TIME);
			}

			pst5.setString(5, ap.getLabLocation());
			pst5.setString(6, ap.getStatus());
			pst5.setString(7, ap.getPriority());

			if ("Offline".equalsIgnoreCase(ap.getMode())) {
				pst5.setInt(8, tokenNo);
			} else {
				pst5.setNull(8, java.sql.Types.INTEGER);
			}

			pst5.setString(9, ap.getMode());

			i = pst5.executeUpdate();

			con.commit(); // success

		} catch (Exception e) {
			e.printStackTrace();
		}

		return i;
	}

	public List<Appointment> viewAppointment(String key) {
		List<Appointment> list = new LinkedList<Appointment>();

		String query = "";

		if ("today".equals(key)) {
			query = "SELECT p.patient_name,p.patient_email,p.patient_mobile,a.patient_id, a.id,a.test_name,a.appointment_date,a.time_slot,a.lab_location,a.status,a.priority, a.token_no, a.booking_type FROM appointments a JOIN patients p ON p.patient_uid = a.patient_id WHERE a.appointment_date = CURDATE()";
		} else if ("todayOrAfter".equals(key)) {
			query = "SELECT p.patient_name,p.patient_email,p.patient_mobile,a.patient_id, a.id,a.test_name,a.appointment_date,a.time_slot,a.lab_location,a.status,a.priority, a.token_no, a.booking_type FROM appointments a JOIN patients p ON p.patient_uid = a.patient_id WHERE a.appointment_date >= CURDATE()";
		} else {
			query = "SELECT p.patient_name,p.patient_email,p.patient_mobile,a.patient_id, a.id,a.test_name,a.appointment_date,a.time_slot,a.lab_location,a.status,a.priority, a.token_no, a.booking_type FROM appointments a JOIN patients p ON p.patient_uid = a.patient_id";
		}

		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String pId = rs.getString("patient_id");
				String name = rs.getString("patient_name");
				String email = rs.getString("patient_email");
				String mobile = rs.getString("patient_mobile");
				String test = rs.getString("test_name");
				Date apDate = rs.getDate("appointment_date");

				String apTime = rs.getString("time_slot");
				LocalTime time = null;

				if (apTime != null && !apTime.isEmpty()) {
					time = LocalTime.parse(apTime);
				}

				String loc = rs.getString("lab_location");
				String sts = rs.getString("status");
				String priority = rs.getString("priority");
				int token = rs.getInt("token_no");
				String mode = rs.getString("booking_type");

				list.add(new Appointment(id, pId, name, email, mobile, test, apDate, time, loc, sts, priority, token,
						mode));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Appointment getAppointmentById(int id) {
		Appointment ap = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT p.patient_name, p.patient_email, p.patient_mobile, "
								+ "a.patient_id, a.id, a.test_name, a.appointment_date, a.time_slot, "
								+ "a.lab_location, a.status, a.priority, a.token_no, a.booking_type "
								+ "FROM appointments a " + "JOIN patients p ON p.patient_uid = a.patient_id "
								+ "WHERE a.id = ?")) {

			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				int dbId = rs.getInt("id");
				String pId = rs.getString("patient_id");
				String name = rs.getString("patient_name");
				String email = rs.getString("patient_email");
				String mobile = rs.getString("patient_mobile");
				String test = rs.getString("test_name");
				Date apDate = rs.getDate("appointment_date");

				Time sqlTime = rs.getTime("time_slot");
				LocalTime time = null;

				if (sqlTime != null) {
					time = sqlTime.toLocalTime();
				}

				String loc = rs.getString("lab_location");
				String sts = rs.getString("status");
				String priority = rs.getString("priority");
				Integer token = (Integer) rs.getObject("token_no");
				String mode = rs.getString("booking_type");

				ap = new Appointment(dbId, pId, name, email, mobile, test, apDate, time, loc, sts, priority, token,
						mode);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ap;
	}

	public int updateAppointmentStatus(int id, String status) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("UPDATE appointments SET status = ? WHERE id = ?")) {
			pst.setString(1, status);
			pst.setInt(2, id);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public int getTotalAppointment() {
		int total = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT COUNT(id) AS total FROM appointments")) {
			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}

	public int getConfirmedAppointment() {
		int total = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM appointments WHERE status = ?")) {
			pst.setString(1, "Confirmed");

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}

	public int getPendingAppointment() {
		int total = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM appointments WHERE status = ?")) {
			pst.setString(1, "Booked");

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}

	public int getCancelledAppointment() {
		int total = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT COUNT(id) AS total FROM appointments WHERE status = ?")) {
			pst.setString(1, "Cancelled");

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}

	public List<Appointment> filterAppointments(String search, String type, String status, String priority,
			String date) {
		List<Appointment> list = new ArrayList<Appointment>();

		String query = "SELECT p.patient_name,p.patient_email,p.patient_mobile,a.patient_id, a.id,a.test_name,a.appointment_date,a.time_slot,a.lab_location,a.status,a.priority, a.token_no, a.booking_type FROM appointments a JOIN patients p ON p.patient_uid = a.patient_id WHERE 1=1";

		if (search != null && !search.isEmpty()) {
			query += " AND (patient_id LIKE ? OR test_name LIKE ? OR lab_location LIKE ? OR patient_name LIKE ? OR patient_email LIKE ? OR patient_mobile LIKE ?)";
		}

		if (type != null && !type.isEmpty()) {
			query += " AND test_name = ?";
		}

		if (status != null && !status.isEmpty()) {
			query += " AND status = ?";
		}

		if (priority != null && !priority.isEmpty()) {
			query += " AND priority = ?";
		}

		if (date != null && !date.isEmpty()) {
			query += " AND appointment_date = ?";
		}

		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

			int i = 1;

			if (search != null && !search.isEmpty()) {
				pst.setString(i++, "%" + search + "%");
				pst.setString(i++, "%" + search + "%");
				pst.setString(i++, "%" + search + "%");
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

			if (priority != null && !priority.isEmpty()) {
				pst.setString(i++, priority);
			}

			if (date != null && !date.isEmpty()) {
				pst.setString(i++, date);
			}

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String pId = rs.getString("patient_id");
				String name = rs.getString("patient_name");
				String email = rs.getString("patient_email");
				String mobile = rs.getString("patient_mobile");
				String test = rs.getString("test_name");
				Date apDate = rs.getDate("appointment_date");

				String apTime = rs.getString("time_slot");
				LocalTime time = null;

				if (apTime != null && !apTime.isEmpty()) {
					time = LocalTime.parse(apTime);
				}

				String loc = rs.getString("lab_location");
				String sts = rs.getString("status");
				String priority1 = rs.getString("priority");
				int token = rs.getInt("token_no");
				String mode = rs.getString("booking_type");

				list.add(new Appointment(id, pId, name, email, mobile, test, apDate, time, loc, sts, priority1, token,
						mode));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
}
