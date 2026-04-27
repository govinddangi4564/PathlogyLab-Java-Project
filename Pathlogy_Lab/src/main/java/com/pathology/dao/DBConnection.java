package com.pathology.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DBConnection {

	private static ResourceBundle bundle;
	static {
		try {
			bundle = ResourceBundle.getBundle("config");
		} catch (Exception e) {
			System.err.println("Warning: config.properties not found, using Environment Variables only.");
		}
	}

	private static String getProp(String key, String defaultValue) {
		if (bundle != null && bundle.containsKey(key)) {
			return bundle.getString(key);
		}
		return defaultValue;
	}

	private static final String URL = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : getProp("db.url", "jdbc:mysql://localhost:3306/pathology_lab");
	private static final String DRIVER = getProp("db.driver", "com.mysql.cj.jdbc.Driver");
	private static final String USERNAME = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : getProp("db.username", "root");
	private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : getProp("db.password", "root");

	public static Connection getConnection() {
		Connection con = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Database Connection Error: " + e.getMessage());
			e.printStackTrace();
		}

		return con;
	}
}
