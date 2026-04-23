package com.pathology.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Patient;
import com.pathology.model.User;

public class UserDao {

	public boolean isEmailExists(String email) {
		boolean exists = false;

		String sql = "SELECT 1 FROM users WHERE email = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);

			try (ResultSet rs = ps.executeQuery()) {
				exists = rs.next();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return exists;
	}

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

	public User login(String emailOrMobile) {
		User u = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT id,name,email,mobile,password,role FROM users WHERE (email = ? or mobile = ?)")) {

			pst.setString(1, emailOrMobile);
			pst.setString(2, emailOrMobile);

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

	public int storeOtp(String email, String otp) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("UPDATE users SET otp = ?, otp_time = CURRENT_TIMESTAMP WHERE email = ?")) {
			pst.setString(1, otp);
			pst.setString(2, email);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	public User verifyOtp(String email) {
		User u = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT otp, otp_time FROM users where email = ?")) {
			pst.setString(1, email);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				String dbOtp = rs.getString("otp");
				Timestamp dbOtpTime = rs.getTimestamp("otp_time");

				u = new User(dbOtp, dbOtpTime);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return u;
	}

	public void clearOtp(String email) {

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con
						.prepareStatement("UPDATE users SET otp = NULL, otp_time = NULL WHERE email = ?")) {

			pst.setString(1, email);
			pst.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int updatePassword(String email, String password) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("UPDATE users SET password = ? WHERE email = ?")) {
			pst.setString(1, password);
			pst.setString(2, email);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public User getPassword(String email) {
		User u = null;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT password FROM USERS WHERE email = ?")) {
			pst.setString(1, email);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				u = new User(rs.getString("password"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return u;
	}

	public int addStaff(User u) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO users (name, email, mobile, password, role) VALUES (?,?,?,?,?)")) {

			pst.setString(1, u.getName());
			pst.setString(2, u.getEmail());
			pst.setString(3, u.getMobile());
			pst.setString(4, u.getPassword());
			pst.setString(5, u.getRole());

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	public List<User> staffList() {
		List<User> list = new LinkedList<User>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT id, name, email, mobile, role, created_at FROM users WHERE role = ?")) {
			pst.setString(1, "STAFF");

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String mobile = rs.getString("mobile");
				String role = rs.getString("role");
				Date dt = rs.getDate("created_at");

				list.add(new User(id, name, email, mobile, role, dt));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public int deleteStaff(int id) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement("DELETE FROM users WHERE id = ?")) {
			pst.setInt(1, id);

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

}
