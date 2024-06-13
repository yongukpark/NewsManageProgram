<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="myBean.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

sql = "SELECT image1, image2, image3, thumbnail FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
rs = pstmt.executeQuery();
rs.next();
if(rs.getString("image1") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("image1"));
	file.delete();
} 
if(rs.getString("image2") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("image2"));
	file.delete();
} 
if(rs.getString("image3") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("image3"));
	file.delete();
} 
if(rs.getString("thumbnail") != null) { 
	File file = new File(realFolder + File.separator + rs.getString("thumbnail"));
	file.delete();
} 

sql = "DELETE FROM news WHERE id=?";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(request.getParameter("id")));
pstmt.executeUpdate();

rs.close();
pstmt.close();
con.close();

response.sendRedirect("manageNews.jsp?first=&&second=&&status=&&pageNum=1");
}
catch (Exception e) { 
	out.println(e.toString());
	return;
}
%>