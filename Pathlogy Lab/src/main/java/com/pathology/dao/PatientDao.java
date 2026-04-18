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

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO patients (patient_name, patient_email,patient_mobile) VALUES(?,?,?)",
						PreparedStatement.RETURN_GENERATED_KEYS)) {
			pst.setString(1, p.getPatientName());
			pst.setString(2, p.getPatientEmail());
			pst.setString(3, p.getPatientMobile());

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
}
