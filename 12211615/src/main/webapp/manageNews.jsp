<%@page import="java.io.Console"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 현재 선택된 요소에 맞게 arrLi를 업데이트하고 이것을 기사 관리 출력 페이지에 출력함 -->
<%
ClassificationDB cf = new ClassificationDB();
ArrayList<Classification> arrLi = cf.selectAll();
NewsDB ndb = new NewsDB();
ArrayList<News> newsList = new ArrayList<News>();
String first = request.getParameter("first");
String second = request.getParameter("second");
String status = request.getParameter("status");
int pageNum = Integer.parseInt(request.getParameter("pageNum"));

if (first.equals("")) {
	if (status.equals("")) {
		newsList = ndb.select();
	} else {
		newsList = ndb.selectStatus(status);
	}
} else if (second.equals("")) {
	if (status.equals("")) {
		newsList = ndb.select(first);
	} else {
		newsList = ndb.select(first, status);
	}
} else {
	int code = 0;
	for (Classification cl : arrLi) {
		if (cl.getFirst().equals(first) && cl.getSecond().equals(second)) {
	code = cl.getCode();
		}
	}
	if (status.equals("")) {
		newsList = ndb.selectCode(code);
	} else {
		newsList = ndb.select(code, status);
	}
}
%>
<title>뉴스</title>

<style>
.block {
	height: auto;
	padding: 10px 70px;
	line-height: 50px;
	font-size: 17px;
	font-weight: bold;
}

.input_block {
	margin-right: 4.5%;
	display: inline-block;
	vertical-align: top;
	height: 50px;
}

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

#manage {
	display: inline-block;
	width: 8%;
	height: 40px;
	padding: 5px 0px;
}

#manage_button {
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
	padding-bottom: 20px;
	width: 100%;
	border-bottom: 2px solid #e5e5e5;
}

.news>div {
	height: 100%;
	width: 100%;
}

.thumbnail {
	padding: 2.6%;
	height: 100%;
	width: 16.5%;
	display: inline-block;
	vertical-align: top;
}

.content {
	padding: 2.55%;
	height: 20px;
	width: 61.0%;
	display: inline-block;
	vertical-align: top;
}

.news img {
	height: 100%;
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
	text-align: center;
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

#modify {
	font-size: 20px;
	background-color: #92C6FF;
}

#modify:hover {
	cursor: pointer;
	background-color: #62ACFF;
}

#delete {
	font-size: 20px;
	background-color: #FFC2A4;
}

#delete:hover {
	cursor: pointer;
	background-color: #F79462;
}
</style>

<script>
<!-- 처음 로드 될때 분류1에 리스트로 출력될 항목들 설정 -->
window.addEventListener('load', function(){
	
	var arrFirst = new Array();
	var arr = new Array();
	
	<%for (int i = 0; i < arrLi.size(); i++) {%>
		arr.push(["<%=arrLi.get(i).getFirst()%>","<%=arrLi.get(i).getSecond()%>","<%=arrLi.get(i).getCode()%>"]);
<%}%>
	var preString = "";

		for (var i in arr) {
			if (arr[i][0] != preString) {
				preString = arr[i][0];
				arrFirst.push(preString);
			}
		}
		for ( var i in arrFirst) {
			var c1Obj = document.getElementById("first");
			var optionObj = document.createElement("option");
			optionObj.setAttribute("value", arrFirst[i]);
			var t = document.createTextNode(arrFirst[i]);
			optionObj.appendChild(t);
			c1Obj.appendChild(optionObj);
		}
		
		var first = document.getElementById("first");
		for(var i = 0 ; i < first.length ; i++)
		{
			if(first[i].value == "<%=request.getParameter("first")%>")
			{
				first[i].selected = true;
				break;
			}
		}
		
		if("<%=request.getParameter("first")%>" != "")
		{
			var c1Obj = document.getElementById("first");
			var c2Obj = document.getElementById("second");
			
			for ( var i in arr) {
				if (arr[i][0] == c1Obj.value) {
					console.log("a");
					var optionObj = document.createElement("option");
					optionObj.setAttribute("value", arr[i][1]);
					var t = document.createTextNode(arr[i][1]);
					optionObj.appendChild(t);
					c2Obj.appendChild(optionObj);
				}
			}
			
			var second = document.getElementById("second");
			
			for(var i = 0 ; i < second.length ; i++)
			{
				if(second[i].value == "<%=request.getParameter("second")%>")
				{
					second[i].selected = true;
					break;
				}
			}

			for ( var i in arr) {
				if (arr[i][0] == c1Obj.value) {
					if (arr[i][1] == c2Obj.value) {
						document.getElementById("code").value = arr[i][2];
						break;
					}

				}

			}
		}


		var status = document.getElementById("status");
		for(var i = 0 ; i < status.length ; i++)
		{
			if(status[i].value == "<%=request.getParameter("status")%>")
			{
				status[i].selected = true;
				break;
			}
		}
		
		
		<!--분류 1이 선택되었을때 페이지 이동 후 그에 맞는 분류 2의 항목들을 설정-->
		document.getElementById("first").onchange = function() {
			var url = "manageNews.jsp?first=" + document.getElementById("first").value + "&&second=&&status="+ document.getElementById("status").value + "&&pageNum=1";
			location.href=url;
		}
		<!--분류 1,2 모두 선택되었을때 그에 맞는 코드 자동 입력 후 페이지 이동-->
		document.getElementById("second").onchange = function() {
			var url = "manageNews.jsp?first=" + document.getElementById("first").value + "&&second=" + document.getElementById("second").value +"&&status="+ document.getElementById("status").value + "&&pageNum=1";
			location.href=url;
		}
		<!--등록상태 변경 후 페이지 이동-->
		document.getElementById("status").onchange = function() {
			var url = "manageNews.jsp?first=" + document.getElementById("first").value + "&&second=" + document.getElementById("second").value +"&&status="+ document.getElementById("status").value + "&&pageNum=1";
			location.href=url;
		}
	});
</script>

</head>

<body>
	<%@ include file="/header.jsp"%>
	<div id="middle_blank">
		<div id="search">
			<form method="get" action="search.jsp">
				<input type="hidden" name="pageNum" value="1"> <select name="condition" class="search_condition">
					<optgroup label="검색기준">
						<option value="기자 이름">기자 이름</option>
						<option value="기사 제목">기사 제목</option>
						<option value="기사 내용">기사 내용</option>
					</optgroup>
				</select> <input type="text" placeholder="검색어를 입력해주세요." name="search_input" id="search_input">
				<button type="submit" id="search_button">검색</button>
			</form>
		</div>
		<div id="manage">
			<input type="button" onclick="location.href='createNews.jsp'" value="기사 등록" id="manage_button">
		</div>
	</div>
	<br>
	<article>
		<div class="block">
			분류1 : <select name="first" id="first" class="input_block" style="width: 17%; font-size: 15px" required="required">
				<option value="">전체</option>

			</select> 분류2 : <select name="second" id="second" class="input_block" style="width: 17%; font-size: 15px" required="required">
				<option value="">전체</option>

			</select> 분류 코드 : <input type="text" name="code" id="code" class="input_block" readonly style="height: 44px; width: 9%; background-color: #e5e5e5; font-size: 20px; text-align: center;"> 등록 상태 : <select name="status" id="status" class="input_block" style="width: 11.5%; margin-right: 0px; font-size: 15px">
				<option value="">전체</option>
				<option value="등록완료">등록완료</option>
				<option value="등록대기">등록대기</option>
			</select>
		</div>
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
						<br> <strong><%=newsList.get(i).getTitle()%></strong><br>
						<p>
							기사 취재일&nbsp;&nbsp;:&nbsp;&nbsp;<%=newsList.get(i).getReportDay()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최종수정일&nbsp;&nbsp;:&nbsp;&nbsp;<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(newsList.get(i).getLastUpdate())%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=newsList.get(i).getStatus()%></p>
					</div>
					<div style="display: inline-block; padding: 2.55% 0%; text-align: center;">
						<div>관리</div>
						<div style="padding-top: 50%">
							<input type="button" value="수정" id="modify" onclick="location.href='updateNews.jsp?id=<%=newsList.get(i).getId()%>'" />
						</div>
						<div style="padding-top: 50%">
							<input type="button" value="삭제" id="delete" onclick="delNews(<%=newsList.get(i).getId()%>)" />
						</div>
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
			<li onclick="location.href='manageNews.jsp?first=<%=first%>&&second=<%=second%>&&status=<%=status%>&&pageNum=<%=i%>'"><%=i%></li>
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
			<li onclick="location.href='manageNews.jsp?first=<%=first%>&&second=<%=second%>&&status=<%=status%>&&pageNum=<%=i%>'"><%=i%></li>
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
			<li onclick="location.href='manageNews.jsp?first=<%=first%>&&second=<%=second%>&&status=<%=status%>&&pageNum=<%=i%>'"><%=i%></li>
			<%
			}
			}
			}
			%>

		</ul>
	</footer>
</body>
<script>
function delNews(num)
{
	if(confirm('정말 삭제하시겠습니까?'))
	{
		location.href="deleteNewsActionForm.jsp?id="+num;
	}
	
}

</script>
</html>