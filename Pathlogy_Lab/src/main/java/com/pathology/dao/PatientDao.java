package com.pathology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Patient;

public class PatientDao {

	public String addPatient(Patient p) {
		String patientUID = null;

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

			PreparedStatement pst3 = con.prepareStatement("SELECT patient_uid FROM patients WHERE patient_email = ?");
			pst3.setString(1, p.getPatientEmail());

			ResultSet rs3 = pst3.executeQuery();
			if (rs3.next()) {
				patientUID = rs3.getString("patient_uid");
			} else {

				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO patients (patient_name, patient_email,patient_mobile, user_id) VALUES(?,?,?,?)",
						PreparedStatement.RETURN_GENERATED_KEYS);
				pst.setString(1, p.getPatientName());
				pst.setString(2, p.getPatientEmail());
				pst.setString(3, p.getPatientMobile());
				pst.setInt(4, userId);

				pst.executeUpdate();

				ResultSet rs = pst.getGeneratedKeys();
				if (rs.next()) {
					int id = rs.getInt(1);

					patientUID = "pt-" + (10000 + id);

					PreparedStatement pst1 = con.prepareStatement("UPDATE patients SET patient_uid = ? WHERE ID = ?");
					pst1.setString(1, patientUID);
					pst1.setInt(2, id);

					pst1.executeUpdate();
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return patientUID;
	}

	public List<Patient> viewAllPatients() {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM patients LIMIT 15 OFFSET 0")) {

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

	public List<Patient> viewAllPatients(int offset) {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM patients LIMIT 15 OFFSET ?")) {
			pst.setInt(1, offset);
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
				PreparedStatement pst = con.prepareStatement(
						"SELECT * FROM patients ORDER BY " + sort + " " + order + " LIMIT 15 OFFSET 0")) {

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

	public List<Patient> searchPatient(String key) {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT * FROM patients where patient_uid LIKE ? OR patient_name LIKE ? OR patient_email LIKE ? OR patient_mobile LIKE ? LIMIT 15 OFFSET 0")) {

			pst.setString(1, "%" + key + "%");
			pst.setString(2, "%" + key + "%");
			pst.setString(3, "%" + key + "%");
			pst.setString(4, "%" + key + "%");

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

}
