<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.*" %>

<!DOCTYPE html>
<!-- news에 관련된 정보를 db로 저장시키는 코드 -->
<%
NewsDB ndb = null;
News news = null;
try
{

ndb = new NewsDB();
news = new News();
Connection con = Newscms.getConnection();
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");
Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

sql = "SELECT image1 FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
rs = pstmt.executeQuery();
rs.next();
if(multiPart.getMyPart("image1") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("image1"));
	file.delete();
	
	news.setImage1(multiPart.getSavedFileName("image1"));
} 
else
{
	news.setImage1(rs.getString("image1"));
}
sql = "SELECT image2 FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
rs = pstmt.executeQuery();
rs.next();
if(multiPart.getMyPart("image2") != null) { 

	File file = new File(realFolder + File.separator + rs.getString("image2"));
	file.delete();
	
	news.setImage2(multiPart.getSavedFileName("image2"));
} 
else
{
	news.setImage2(rs.getString("image2"));
}

sql = "SELECT image3 FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
rs = pstmt.executeQuery();
rs.next();

if(multiPart.getMyPart("image3") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("image3"));
	file.delete();
	
	news.setImage3(multiPart.getSavedFileName("image3"));
} 
else
{
	news.setImage3(rs.getString("image3"));
}

sql = "SELECT thumbnail FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
rs = pstmt.executeQuery();
rs.next();
if(multiPart.getMyPart("thumbnail") != null) { 

	File file = new File(realFolder + File.separator + rs.getString("thumbnail"));
	file.delete();
	
	news.setThumbnail(multiPart.getSavedFileName("thumbnail"));
} 
else
{
	news.setThumbnail(rs.getString("thumbnail"));	
}

rs.close();
pstmt.close();
con.close();

news.setId(Integer.parseInt(request.getParameter("id")));
news.setFirst(request.getParameter("first"));
news.setSecond(request.getParameter("second"));
news.setCode(Integer.parseInt(request.getParameter("code")));
news.setStatus(request.getParameter("status"));
news.setReportDay(request.getParameter("reportDay"));
news.setReporterName(request.getParameter("reporterName"));
news.setReporterEmail(request.getParameter("reporterEmail"));
news.setTitle(request.getParameter("title"));
news.setContent1(request.getParameter("content1"));
news.setContent2(request.getParameter("content2"));
news.setContent3(request.getParameter("content3"));
news.setLastUpdate();

ndb.change(news);
ndb.close();
}
catch(SQLException e) {
	out.print(e);
	return;
}
response.sendRedirect("manageNews.jsp?first=&&second=&&status=&&pageNum=1");
%>