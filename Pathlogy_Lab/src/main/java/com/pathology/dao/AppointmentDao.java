package com.pathology.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Appointment;

public class AppointmentDao {

	public int bookAppointment(Appointment ap) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO appointments (patient_id,test_name,appointment_date,time_slot,lab_location,status,priority) VALUES(?,?,?,?,?,?,?)")) {
			pst.setString(1, ap.getPatientId());
			pst.setString(2, ap.getTestName());
			pst.setDate(3, ap.getAppointmentDate());
			pst.setTime(4, Time.valueOf(ap.getAppointmentTime()));
			pst.setString(5, ap.getLabLocation());
			pst.setString(6, "Booked");
			pst.setString(7, ap.getPriority());

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public List<Appointment> viewAppointment() {
		List<Appointment> list = new LinkedList<Appointment>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT p.patient_name,p.patient_email,p.patient_mobile,a.patient_id, a.id,a.test_name,a.appointment_date,a.time_slot,a.lab_location,a.status,a.priority FROM appointments a JOIN patients p ON p.patient_uid = a.patient_id")) {
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
				LocalTime time = LocalTime.parse(apTime);

				String loc = rs.getString("lab_location");
				String sts = rs.getString("status");
				String priority = rs.getString("priority");

				list.add(new Appointment(id, pId, name, email, mobile, test, apDate, time, loc, sts, priority));
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
								+ "a.lab_location, a.status, a.priority " + "FROM appointments a "
								+ "JOIN patients p ON p.patient_uid = a.patient_id " + "WHERE a.id = ?")) {

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

				LocalTime time = rs.getTime("time_slot").toLocalTime();

				String loc = rs.getString("lab_location");
				String sts = rs.getString("status");
				String priority = rs.getString("priority");

				ap = new Appointment(dbId, pId, name, email, mobile, test, apDate, time, loc, sts, priority);
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
}
