<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*"%>

<!--  분류 코드를 추가하는 시키는 코드 -->

<!DOCTYPE html>
<jsp:useBean id="cf" class="myBean.Classification"/>
<jsp:setProperty name="cf" property="*"/>
<%
try
{
ClassificationDB cdb = new ClassificationDB();
cdb.insertRecord(cf);
cdb.close();
}
catch(SQLException e) {
	out.print(e);
	return;
}
response.sendRedirect("manageClassification.jsp");
%>