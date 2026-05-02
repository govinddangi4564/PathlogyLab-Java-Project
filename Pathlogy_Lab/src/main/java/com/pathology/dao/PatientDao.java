package com.pathology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Patient;

public class PatientDao {

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

	public List<Patient> getAllPatients() {
		List<Patient> list = new LinkedList<Patient>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM patients ORDER BY patient_uid DESC")) {

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
