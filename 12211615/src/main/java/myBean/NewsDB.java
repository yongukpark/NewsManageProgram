package myBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NewsDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public NewsDB() throws SQLException {
		con = Newscms.getConnection();
	}
	//분류코드 수정시 기존의 기사들 분류코드도 수정
	public void changeClassification(Classification cf) throws SQLException
	{
		String sql = "UPDATE news SET first=?, second=? WHERE code=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, cf.getFirst());
		pstmt.setString(2, cf.getSecond());
		pstmt.setInt(3, cf.getCode());
		pstmt.executeUpdate();
	}
	//분류코드 삭제시 기존의 기사들을 미분류로 이동
	public void deleteClassification (Classification cf) throws SQLException
	{
		String sql = "UPDATE news SET first='미분류', second='미분류', code=9999 WHERE code=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, cf.getCode());
		pstmt.executeUpdate();
	}
	
	// 기사 수정 코드
	public void change(News news) throws SQLException
	{
		String sql = "UPDATE news SET first=?, second=?,code=?,status=?,reportDay=?,reporterName=?,reporterEmail=?,title=?,content1=?,image1=?,content2=?,image2=?,content3=?,image3=?,thumbnail=?,lastUpdate=? WHERE id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, news.getFirst());
		pstmt.setString(2, news.getSecond());
		pstmt.setInt(3, news.getCode());
		pstmt.setString(4, news.getStatus());
		pstmt.setDate(5, news.getReportDay());
		pstmt.setString(6, news.getReporterName());
		pstmt.setString(7, news.getReporterEmail());
		pstmt.setString(8, news.getTitle());
		pstmt.setString(9, news.getContent1());
		pstmt.setString(10, news.getImage1());
		pstmt.setString(11, news.getContent2());
		pstmt.setString(12, news.getImage2());
		pstmt.setString(13, news.getContent3());
		pstmt.setString(14, news.getImage3());
		pstmt.setString(15, news.getThumbnail());
		pstmt.setTimestamp(16, news.getLastUpdate());
		pstmt.setInt(17, news.getId());
		pstmt.executeUpdate();
	}
	
	// 기사 등록 코드
	public void update(News news) throws SQLException {
		String sql = "INSERT INTO news(first, second, code, status, reportDay, reporterName, reporterEmail, title, content1, image1, content2, image2, content3, image3, thumbnail, lastUpdate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, news.getFirst());
		pstmt.setString(2, news.getSecond());
		pstmt.setInt(3, news.getCode());
		pstmt.setString(4, news.getStatus());
		pstmt.setDate(5, news.getReportDay());
		pstmt.setString(6, news.getReporterName());
		pstmt.setString(7, news.getReporterEmail());
		pstmt.setString(8, news.getTitle());
		pstmt.setString(9, news.getContent1());
		pstmt.setString(10, news.getImage1());
		pstmt.setString(11, news.getContent2());
		pstmt.setString(12, news.getImage2());
		pstmt.setString(13, news.getContent3());
		pstmt.setString(14, news.getImage3());
		pstmt.setString(15, news.getThumbnail());
		pstmt.setTimestamp(16, news.getLastUpdate());
		pstmt.executeUpdate();
	}
	
	// 안쓰는 stream 닫는 코드
	public void close() throws SQLException {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}
	
	// 기사 내용을 기준으로 검색했을때 검색한 내용이 포함되는 기사 모두 선택되는 코드
		public ArrayList<News> selectContent(String s) throws SQLException {
			
			String sql = "SELECT * FROM news WHERE content1 Like ? OR content2 Like ? OR content3 Like ? ORDER BY lastUpdate DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + s + "%");
			pstmt.setString(2, "%" + s + "%");
			pstmt.setString(3, "%" + s + "%");
			rs = pstmt.executeQuery();
			ArrayList<News> arr = new ArrayList<News>();
			while (rs.next()) {
				News news = new News();
				news.setId(rs.getInt("id"));
				news.setFirst(rs.getString("first"));
				news.setSecond(rs.getString("second"));
				news.setCode(rs.getInt("code"));
				news.setStatus(rs.getString("status"));
				news.setReportDay(rs.getDate("reportDay"));
				news.setReporterName(rs.getString("reporterName"));
				news.setReporterEmail(rs.getString("reporterEmail"));
				news.setTitle(rs.getString("title"));
				news.setContent1(rs.getString("content1"));
				news.setImage1(rs.getString("image1"));
				news.setContent2(rs.getString("content2"));
				news.setImage2(rs.getString("image2"));
				news.setContent3(rs.getString("content3"));
				news.setImage3(rs.getString("image3"));
				news.setThumbnail(rs.getString("thumbnail"));
				news.setLastUpdate(rs.getTimestamp("lastUpdate"));
				arr.add(news);
			}
			return arr;
		}
	
	// 기자 이름을 기준으로 검색했을때 검색한 내용이 포함되는 기사 모두 선택되는 코드
	public ArrayList<News> selectReporterName(String s) throws SQLException {
		
		String sql = "SELECT * FROM news WHERE reporterName Like ? ORDER BY lastUpdate DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + s + "%");
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
	
	// 기사 제목을 기준으로 검색했을때 검색한 내용이 포함되는 기사 모두 선택되는 코드
	public ArrayList<News> selectTitle(String s) throws SQLException {
		
		String sql = "SELECT * FROM news WHERE title Like ? ORDER BY lastUpdate DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + s + "%");
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
	
	//처음 화면에 표시될 내용들 등록완료 상태인 기사만
	public ArrayList<News> selectStatusTrue() throws SQLException {
		
		String sql = "SELECT * FROM news WHERE status='등록완료' ORDER BY lastUpdate DESC";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
	// DB내의 모든 요소 기사 선택할때 사용하는 코드(등록대기 포함)
	public ArrayList<News> select() throws SQLException {
		
		String sql = "SELECT * FROM news ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
	
	// ID기준으로 하나의 기사를 찾을때 사용하는 코드
	public News select(int id) throws SQLException {
		News news = new News();
		String sql = "SELECT * FROM news WHERE id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		news.setId(rs.getInt("id"));
		news.setFirst(rs.getString("first"));
		news.setSecond(rs.getString("second"));
		news.setCode(rs.getInt("code"));
		news.setStatus(rs.getString("status"));
		news.setReportDay(rs.getDate("reportDay"));
		news.setReporterName(rs.getString("reporterName"));
		news.setReporterEmail(rs.getString("reporterEmail"));
		news.setTitle(rs.getString("title"));
		news.setContent1(rs.getString("content1"));
		news.setImage1(rs.getString("image1"));
		news.setContent2(rs.getString("content2"));
		news.setImage2(rs.getString("image2"));
		news.setContent3(rs.getString("content3"));
		news.setImage3(rs.getString("image3"));
		news.setThumbnail(rs.getString("thumbnail"));
		news.setLastUpdate(rs.getTimestamp("lastUpdate"));

		return news;
	}
	
	// manageNews.jsp에서 first와 second만 선택되었을 코드를 통해 찾는 법
	public ArrayList<News> selectCode(int code) throws SQLException {
		String sql = "SELECT * FROM news WHERE code = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, code);
		rs = pstmt.executeQuery();

		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}

	// manageNews.jsp에서 first만 선택되었을때 실행
	public ArrayList<News> select(String first) throws SQLException {
		String sql = "SELECT * FROM news WHERE first = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, first);
		rs = pstmt.executeQuery();

		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}

	// manageNews.jsp에서 first와 second와 status 모두 선택되었을때 실행
	public ArrayList<News> select(int code, String status) throws SQLException {
		String sql = "SELECT * FROM news WHERE code = ? AND status = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, code);
		pstmt.setString(2, status);
		rs = pstmt.executeQuery();

		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}

	// manageNews.jsp에서 first와 status만 선택되었을때 실행
	public ArrayList<News> select(String first, String status) throws SQLException {

		String sql = "SELECT * FROM news WHERE first = ? AND status = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, first);
		pstmt.setString(2, status);
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}

	// manageNews.jsp에서 status만 선택되었을때 실행
	public ArrayList<News> selectStatus(String status) throws SQLException {

		String sql = "SELECT * FROM news WHERE status = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, status);
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
	
	// first second 선택되었을 때 찾는 코드
	public ArrayList<News> selectFS(String first, String second) throws SQLException {

		String sql = "SELECT * FROM news WHERE first = ? AND second = ? ORDER BY id DESC";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, first);
		pstmt.setString(2, second);
		rs = pstmt.executeQuery();
		ArrayList<News> arr = new ArrayList<News>();
		while (rs.next()) {
			News news = new News();
			news.setId(rs.getInt("id"));
			news.setFirst(rs.getString("first"));
			news.setSecond(rs.getString("second"));
			news.setCode(rs.getInt("code"));
			news.setStatus(rs.getString("status"));
			news.setReportDay(rs.getDate("reportDay"));
			news.setReporterName(rs.getString("reporterName"));
			news.setReporterEmail(rs.getString("reporterEmail"));
			news.setTitle(rs.getString("title"));
			news.setContent1(rs.getString("content1"));
			news.setImage1(rs.getString("image1"));
			news.setContent2(rs.getString("content2"));
			news.setImage2(rs.getString("image2"));
			news.setContent3(rs.getString("content3"));
			news.setImage3(rs.getString("image3"));
			news.setThumbnail(rs.getString("thumbnail"));
			news.setLastUpdate(rs.getTimestamp("lastUpdate"));
			arr.add(news);
		}
		return arr;
	}
}
