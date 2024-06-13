package myBean;

import java.sql.*;

public class Newscms {
	final static String DB_URL = "jdbc:mariadb://localhost:3306/newscms?useUnicode=true&characterEncoding=utf8&useSSL=false";
	final static String DB_USER = "admin";
	final static String DB_PASSWORD = "1234";


	static {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	}
}
