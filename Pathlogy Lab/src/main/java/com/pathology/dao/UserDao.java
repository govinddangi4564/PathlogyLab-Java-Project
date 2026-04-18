package com.pathology.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.pathology.model.User;

public class UserDao {

	public int signup(User u) {
		int i = 0;

		try (Connection con = DBConnection.getConnection()) {

			// 🔹 Step 1: Insert user
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO users (name, email, mobile, password, role) VALUES (?,?,?,?,?)",
					PreparedStatement.RETURN_GENERATED_KEYS);

			pst.setString(1, u.getName());
			pst.setString(2, u.getEmail());
			pst.setString(3, u.getMobile());
			pst.setString(4, u.getPassword());
			pst.setString(5, u.getRole());

			i = pst.executeUpdate();

			// 🔹 Step 2: Get generated user_id
			ResultSet rs = pst.getGeneratedKeys();
			int userId = 0;
			if (rs.next()) {
				userId = rs.getInt(1);
			}

			// 🔹 Step 3: Check if patient already exists
			PreparedStatement check = con
					.prepareStatement("SELECT id FROM patients WHERE patient_email = ? OR patient_mobile = ?");
			check.setString(1, u.getEmail());
			check.setString(2, u.getMobile());

			ResultSet rsCheck = check.executeQuery();

			if (rsCheck.next()) {
				// Patient exists → update user_id
				PreparedStatement update = con.prepareStatement(
						"UPDATE patients SET user_id = ? WHERE patient_email = ? OR patient_mobile = ?");

				update.setInt(1, userId);
				update.setString(2, u.getEmail());
				update.setString(3, u.getMobile());

				update.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return i;
	}

	public User login(String emailOrMobile, String role) {
		User u = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT * FROM users WHERE (email = ? or mobile = ?) and role = ?")) {

			pst.setString(1, emailOrMobile);
			pst.setString(2, emailOrMobile);
			pst.setString(3, role);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String mobile = rs.getString("mobile");
				String pass = rs.getString("password");
				String dbRole = rs.getString("role");

				u = new User(id, name, email, mobile, pass, dbRole);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return u;
	}

	public int totalPatient() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT COUNT(id) AS total FROM users WHERE role = ?")) {

			pst.setString(1, "USER");

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				count = rs.getInt("total");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return count;
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

	public int todaysReportCount() {
		int count = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT COUNT(id) AS total FROM reports WHERE DATE(upload_date) = CURDATE()")) {

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
