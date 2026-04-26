package com.pathology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;

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
}
