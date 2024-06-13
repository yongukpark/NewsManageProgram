package myBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ClassificationDB {
	private Connection con;	
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ClassificationDB() throws SQLException
	{
		con = Newscms.getConnection();
	}
	public void insertRecord(Classification cf) throws SQLException
	{
		String sql = "INSERT INTO classification(code, first, second) VALUES(?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, cf.getCode());
		pstmt.setString(2, cf.getFirst());
		pstmt.setString(3, cf.getSecond());
		pstmt.executeUpdate();
	}
	
	public void close() throws SQLException{
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
	
	public ArrayList<Classification> selectAll() throws SQLException
	{
		String sql = "SELECT * FROM classification ORDER BY code";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<Classification>arr = new ArrayList<Classification>();
		while(rs.next())
		{
			Classification cf = new Classification();
			cf.setCode(rs.getInt("code"));
			cf.setFirst(rs.getString("first"));
			cf.setSecond(rs.getString("second"));
			arr.add(cf);
		}
		return arr;
	}
	
	public void updateRecord(Classification cf) throws SQLException
	{
		String sql = "Update classification SET first=?, second=? WHERE code=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, cf.getFirst());
		pstmt.setString(2, cf.getSecond());
		pstmt.setInt(3, cf.getCode());
		pstmt.executeUpdate();
	}
	
	public void deleteRecord(Classification cf) throws SQLException
	{
		String sql = "DELETE FROM classification WHERE code=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, cf.getCode());
		pstmt.executeUpdate();
	}
	
	public ArrayList<String> selectFirst() throws SQLException {

		String sql = "SELECT DISTINCT first FROM classification ORDER BY code";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<String> arr = new ArrayList<String>();
		while (rs.next()) {
			arr.add(rs.getString("first"));
		}
		return arr;
	}
}
