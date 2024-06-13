<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.ArrayList"%>

<!--  분류 코드를 삭제 시키는 코드 -->

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
	
	ndb.deleteClassification(cf);
	cdb.deleteRecord(cf);
	ndb.close();
	cdb.close();
%>
<script>
alert("삭제되었습니다.");
location.href = "manageClassification.jsp";
</script>
<% 
} catch (SQLException e) {
	out.print(e);
	return;
}
%>
</head>

</html>