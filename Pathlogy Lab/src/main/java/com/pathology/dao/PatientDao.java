package com.pathology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Patient;

public class PatientDao {

	public int addPatient(Patient p) {
		int i = 0;

		try {
			Connection con = DBConnection.getConnection();

			PreparedStatement pst2 = con.prepareStatement("select id from users where email = ? or mobile = ?");
			pst2.setString(1, p.getPatientEmail());
			pst2.setString(2, p.getPatientMobile());

			ResultSet rs2 = pst2.executeQuery();

			int userId = 0;
			if (rs2.next()) {
				userId = rs2.getInt("id");
			} else {
				userId = 0;
			}

			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO patients (patient_name, patient_email,patient_mobile, user_id) VALUES(?,?,?,?)",
					PreparedStatement.RETURN_GENERATED_KEYS);
			pst.setString(1, p.getPatientName());
			pst.setString(2, p.getPatientEmail());
			pst.setString(3, p.getPatientMobile());
			pst.setInt(4, userId);

			i = pst.executeUpdate();

			ResultSet rs = pst.getGeneratedKeys();
			if (rs.next()) {
				int id = rs.getInt(1);

				String patientUID = "pt-" + (10000 + id);

				PreparedStatement pst1 = con.prepareStatement("UPDATE patients SET patient_uid = ? WHERE ID = ?");
				pst1.setString(1, patientUID);
				pst1.setInt(2, id);

				pst1.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	public List<Patient> viewAllPatients() {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM patients")) {

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				list.add(new Patient(rs.getString("patient_uid"), rs.getString("patient_name"),
						rs.getString("patient_email"), rs.getString("patient_mobile")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Patient> sortPatients(String sort, String order) {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM patients ORDER BY " + sort + " " + order)) {

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				list.add(new Patient(rs.getString("patient_uid"), rs.getString("patient_name"),
						rs.getString("patient_email"), rs.getString("patient_mobile")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public int deletePatient(String pId) {
		int i = 0;

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement pst = con.prepareStatement("DELETE FROM patients WHERE patient_uid = ?");

			pst.setString(1, pId);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public int totalPatients() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT COUNT(id) AS total FROM patients")) {

			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				count = rs.getInt("total");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

}
