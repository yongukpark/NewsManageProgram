<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="myBean.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
<title>뉴스</title>
<script>
	
</script>
<%
NewsDB ndb = new NewsDB();
ArrayList<News> newsList = new ArrayList<News>();
newsList = ndb.selectStatusTrue();
int pageNum = 1;
if (request.getQueryString() != null) {
	pageNum = Integer.parseInt(request.getQueryString().toString().substring(8));
}
ndb.close();
%>
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

.manage {
	display: inline-block;
	width: 8%;
	height: 40px;
	padding: 5px 0px;
}

.manage_button {
	display: inline-block;
	width: 80%;
	height: 40px;
	vertical-align: top;
	margin: 0px;
	font-size: 13px;
}

article {
	margin-left: 20%;
	width: 60%;
}

#current_category {
	height: 20px;
	font-size: 20px;
	font-weight: bold;
	padding: 15px 60px;
	color: #233c90;
	font-weight: bold;
	margin: 20px 0px;
}

#list {
	list-style: none;
	margin: 0px;
	padding-left: 50px;
}

.news {
	height: 170px;
	width: 100%;
	border-bottom: 2px solid #e5e5e5;
}

.news>div {
	height: 100%;
	width: 100%;
}

.thumbnail {
	padding: 2.6%;
	height: 120px;
	width: 16.5%;
	display: inline-block;
	vertical-align: top;
}

.content {
	padding: 2.55%;
	height: 20px;
	width: 71.0%;
	display: inline-block;
	vertical-align: top;
}

.news img {
	height: 120px;
	width: 100%;
	border: 1px solid #000;
}

.news strong {
	display: inline-block;
	font-size: 23px;
	font-weight: bold;
}

.news p {
	height: 75px;
	display: inline-block;
	font-size: 17px;
}

#page_number {
	margin-left: 32%;
	width: 46%;
	height: 100px;
}

#page_number>ul {
	height: 40px;
	width: 35%;
	margin: 0px;
	padding: 30px 200px;
}

#page_number>ul>li {
	display: inline-block;
	width: 14%;
	height: 28px;
	font-size: 16px;
	text-align: center;
	border: 1px solid #e5e5e5;
	margin-left: 3.6%;
	padding-top: 10px;
}

#page_number>ul>li:hover {
	cursor: pointer;
	background-color: #e6ecff;
}

#submit:hover {
	background-color: #3366ff;
	cursor: pointer;
}

#search_button:hover {
	cursor: pointer;
}

.newsPage:link , .newsPage:visited
{
	font-weight:bold;
	font-size:25px;
	color:black;
	text-decoration:none;
}
.newsPage:hover
{
	color:blue;
	cursor:pointer;
}
</style>
</head>

<body>
	<%@ include file="/header.jsp"%>
	<div id="middle_blank">
		<div id="search">
			<form method="get" action="search.jsp">
			<input type="hidden" name="pageNum" value="1">
				<select name="condition" class="search_condition">
					<optgroup label="검색기준">
						<option value="기자 이름">기자 이름</option>
						<option value="기사 제목">기사 제목</option>
						<option value="기사 내용">기사 내용</option>
					</optgroup>
				</select> <input type="text" placeholder="검색어를 입력해주세요." name = "search_input" id="search_input">
				<button type="submit" id="search_button">검색</button>
			</form>
		</div>
		<div class="manage">
			<input type="button" onclick="location.href='manageNews.jsp?first=&&second=&&status=&&pageNum=1'" value="기사관리" class="manage_button">
		</div>
		<div class="manage">
			<input type="button" onclick="location.href='manageClassification.jsp'" value="분류코드 관리" class="manage_button">
		</div>
	</div>
	<article>
		<div id="current_category">메인 화면</div>
		<ul id="list">
			<!-- 위에서 불러온 newsList를 통해 출력화면 구성 20개씩만 구성되도록 설정 -->

			<%
			int count = 0;

			for (int i = (pageNum - 1) * 20; i < newsList.size(); i++) {
				if (count == 20) {
					break;
				}
				count++;
			%>

			<li class="news">
				<div>
					<div class="thumbnail">

						<img src="./upload/<%=newsList.get(i).getThumbnail()%>" alt="사진">
					</div>
					<div class="content">
						<div><%=newsList.get(i).getFirst()%>&nbsp;&nbsp;&gt;&nbsp;&nbsp;<%=newsList.get(i).getSecond()%>&nbsp;&nbsp;:&nbsp;&nbsp;<%=newsList.get(i).getCode()%></div>
						<br> <a href="newsPage.jsp?id=<%=newsList.get(i).getId()%>" class="newsPage"><%=newsList.get(i).getTitle()%></a><br>
						<%
						String content = newsList.get(i).getContent1() + " " + newsList.get(i).getContent2() + " "
								+ newsList.get(i).getContent3();
						for (int letter = 0; letter < content.length(); letter++) {
							if (letter == 100) {
								out.write("...");
								break;
							}
							out.write(content.charAt(letter));
						}
						%>
					</div>
				</div>
			</li>
			<%
			}
			%>
		</ul>
	</article>
	<!-- 아래 하단에 페이지 번호 표시 -->
	<footer id="page_number">
		<ul>
			<%
			int listSize = newsList.size() / 20;
			if (newsList.size() % 20 != 0) {
				listSize++;
			}
			int pageCount = 0;
			if (pageNum <= 3) {
				for (int i = 1; i <= listSize; i++) {
					if (pageCount == 5) {
				break;
					}
					pageCount++;
					if (pageNum == i) {
			%><li style="background-color: #e6ecff"><%=i%></li>
			<%
			} else {
			%>
			<li onclick="location.href='index.jsp?pageNum=<%=i%>'"><%=i%></li>
			<%
			}
			}
			} else if (pageNum >= listSize - 2) {
			for (int i = listSize - 4; i <= listSize; i++) {
			if (pageCount == 5) {
			break;
			}
			pageCount++;
			if (pageNum == i) {
			%><li style="background-color: #e6ecff"><%=i%></li>
			<%
			} else {
			%>
			<li onclick="location.href='index.jsp?pageNum=<%=i%>'"><%=i%></li>
			<%
			}
			}
			} else {
			for (int i = pageNum - 2; i <= pageNum + 2; i++) {
			if (pageCount == 5) {
			break;
			}
			pageCount++;
			if (pageNum == i) {
			%><li style="background-color: #e6ecff"><%=i%></li>
			<%
			} else {
			%>
			<li onclick="location.href='index.jsp?pageNum=<%=i%>'"><%=i%></li>
			<%
			}
			}
			}
			%>

		</ul>
	</footer>
</body>
</html>