<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.ArrayList"%>

<!--  분류 코드를 업데이트 시키는 코드 -->

<!DOCTYPE html>
<html>
<head>
<jsp:useBean id="cf" class="myBean.Classification" />
<jsp:setProperty name="cf" property="*" />
<meta charset="UTF-8">
<%
try {
	ClassificationDB cdb = new ClassificationDB();
	NewsDB ndb = new NewsDB();
	
	ndb.changeClassification(cf);
	cdb.updateRecord(cf);
	ndb.close();
	cdb.close();
	response.sendRedirect("manageClassification.jsp");
} catch (SQLException e) {
	out.print(e);
	return;
}
%>
<script>
window.close();
</script>
</html>