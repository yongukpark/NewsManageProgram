<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" import="myBean.*, java.sql.*"%>
<!-- 뉴스 기사 출력 페이지 -->

<%
request.setCharacterEncoding("utf-8");
int id = Integer.parseInt(request.getParameter("id"));
NewsDB ndb = null;
News news = null;

try {
	ndb = new NewsDB();
	news = ndb.select(id);
} catch (SQLException e) {
	out.print(e);
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스</title>
<style>
#middle_blank {
	display: block;
	background-color: #f7f7f7;
	height: 50px;
}

#search {
	display: inline-block;
	margin-left: 63%;
	width: 18%;
	height: 40px;
	padding: 5px 0px;
}

.search_condition {
	margin: 0px;
	display: inline-block;
	width: 30%;
	height: 40px;
	vertical-align: top;
}

#search_input {
	margin-left: -5px;
	display: inline-block;
	width: 52%;
	height: 36px;
	vertical-align: top;
	border: 1px solid #a6a6a6;
	margin-right: -5px;
}

#search_button {
	display: inline-block;
	width: 15%;
	height: 40px;
	vertical-align: top;
	margin: 0px;
	font-size: 13px;
}

option {
	text-align: center;
}

article {
	margin-left: 20%;
	width: 60%;
	padding: 0px 60px;
}
</style>

</head>
<body>
	<%@ include file="/header.jsp"%>
	<div id="middle_blank">
		<div id="search">
			<form action="">
				<select name="condition" class="search_condition">
					<optgroup label="검색기준">
						<option value="none">===선택===</option>
						<option value="name">기자 이름</option>
						<option value="title">기사 제목</option>
						<option value="content">기사 내용</option>
					</optgroup>
				</select> <input type="text" placeholder="검색어를 입력해주세요." id="search_input">
				<button type="button" id="search_button">검색</button>
			</form>

		</div>
	</div>

	<article>
		<div style="font-size: 20px; margin: 20px 0px"><%=news.getFirst()%>
			&nbsp;>&nbsp;
			<%=news.getSecond()%>
			&nbsp; [<%=news.getCode()%>]
		</div>
		<br>
		<div id="title" style="font-size: 40px; margin-bottom: 20px; width: 100%;"><%=news.getTitle()%></div>

		<br>

		<div style="padding: 0px 30px; border-top: 2px solid #a6a6a6;">
			<div>
				<div style="font-size: 16px; width: 80%; display: inline-block"><%=news.getReporterName()%>
					기자
				</div>
				<div style="font-size: 13px; display: inline-block">
					<br>최종 수정일 :
					<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(news.getLastUpdate())%>
					<br>기사 취재일 :
					<%=news.getReportDay()%>
				</div>
			</div>
			<br><br><br>
			<div>
				<div style="text-align: center;">
					<img src="./upload/<%=news.getThumbnail()%>" style="width:100%;height:100%"/>
				</div>
				<div style="font-size: 18px; padding-top: 30px"><%=news.getContent1()%></div>
				<%
				if (news.getImage1() != null && news.getImage1().length() != 0) {
				%>
				<br>
				<div style="text-align: center;">
					<img src="./upload/<%=news.getImage1()%>"style="width:100%;height:100%"/>
				</div>
				<br>
				<%
				}
				%>
				<%
				if (news.getContent2() != null && news.getContent2().length() != 0) {
				%>
				<br>
				<div style="font-size: 18px"><%=news.getContent2()%></div>
				<br>
				<%
				}
				%>
				<%
				if (news.getImage2() != null && news.getImage2().length() != 0) {
				%>
				<br>
				<div style="text-align: center;">
					<img src="./upload/<%=news.getImage2()%>"style="width:100%;height:100%"/>
				</div>
				<br>
				<%
				}
				%>
				<%
				if (news.getContent3() != null && news.getContent3().length() != 0) {
				%>
				<br>
				<div style="font-size: 18px"><%=news.getContent3()%></div>
				<br>
				<%
				}
				%>
				<%
				if (news.getImage3() != null && news.getImage3().length() != 0) {
				%>
				<br>
				<div style="text-align: center;">
					<img src="./upload/<%=news.getImage3()%>"style="width:100%;height:100%"/>
				</div>
				<%
				}
				%>
				<div style="font-size: 16px; font-weight:bold;margin-top: 20px; padding: 20px 0px; border-bottom: 2px solid #e5e5e5;">
					기자 이메일 : 
					<%=news.getReporterEmail()%>
				</div>
				<br><br><br><br><br>
			</div>
		</div>
	</article>
</body>
</html>