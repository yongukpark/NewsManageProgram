<%@page import="myBean.ClassificationDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myBean.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--모든 페이지에 공통으로 상단에 보여지는 화면 -->
<%
ClassificationDB headerCdb = new ClassificationDB();
ArrayList<String> headerFirstArr = headerCdb.selectFirst();
ArrayList<Classification> headerArrAll = headerCdb.selectAll();
headerCdb.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0px;
}

#top_blank {
	margin: 0px;
	height: 90px;
	background-color: #233c90;
}

header {
	display: block;
	margin-left: 20%;
	height: 60px;
	width: 60%;
	padding: 0px;
}

#title {
	display: inline-block;
	width: 20%;
	height: 100%;
	vertical-align: top;
}

#logo {
	width: 100%;
	height: 60%;
	text-align: center;
	font-size: 25px;
	font-weight: bold;
	padding-top: 12px;
	padding-bottom: 12px;
}

#logo>p {
	margin: 0px;
	border-right: 2px solid #e5e5e5;
}

nav {
	display: inline-block;
	width: 70%;
	height: 100%;
}

#category {
	display: inline-block;
}

.category_list {
	display: inline-block;
	font-size: 20px;
	padding-right: 20px;
}

a:link {
	text-decoration: none;
	color: #000;
}

a:visited {
	color: #000;
}

a:hover {
	font-weight: bold;
	color: blue;
}

#hidden_blank {
	display: none;
	position: absolute;
	background-color: #fcfcfc;
	border-bottom: 5px solid #f7f7f7;
	height: 50px;
	width: 100%;
}

#headerSecond {
	margin-left: 32.1%;
}

.headerSecondList {
	display: inline-block;
	font-size: 17px;
	padding-right: 20px;
}
</style>

<script>

window.addEventListener('load', function()
{
	var hidden = document.getElementById("hidden_blank");
	var headerArr = new Array();
	
	<%for (int i = 0; i < headerArrAll.size(); i++) {%>
		headerArr.push(["<%=headerArrAll.get(i).getFirst()%>","<%=headerArrAll.get(i).getSecond()%>"]);
<%}%>
	<%for (String headerS2 : headerFirstArr) {%>
	document.getElementById("<%=headerS2%>").onmouseover = function()
	{
		var obj = document.getElementById("headerSecond");	
        while (obj.firstChild) {
            obj.removeChild(obj.firstChild);
        }
        
		hidden.style.display = "block";
		

		for (var i in headerArr) {
			if (headerArr[i][0] == "<%=headerS2%>") {
				var optionObj = document.createElement("li");
				optionObj.classList.add("headerSecondList");
				var link = document.createElement("a");
				link.href = "categoryNews.jsp?pageNum=1&first=" + headerArr[i][0] +"&second=" + headerArr[i][1]; // 링크 대상 설정
				link.textContent = headerArr[i][1]; // 링크 텍스트 설정
				optionObj.appendChild(link);
				document.getElementById("headerSecond").appendChild(optionObj);
			}
		}
	}

	<%}%>
	document.getElementById("top_blank").onmouseover = function()
	{
		hidden.style.display = "none";
	}
	document.getElementById("hidden_blank").onmouseover = function()
	{
		hidden.style.display = "block";
	}
	document.getElementById("hidden_blank").onmouseout = function()
	{
		hidden.style.display = "none";
	}
	
	
});



</script>
</head>
<body>
	<div id="top_blank"></div>
	<header>
		<div id="title">
			<div id="logo">
				<p>
					<a href="./index.jsp">XX 뉴스</a>
				</p>
			</div>
		</div>
		<nav>
			<ul id="category">
				<%
				for (String headerS : headerFirstArr) {
				%>
				<li class="category_list" id="<%=headerS%>"><a href="./categoryNews.jsp?pageNum=1&first=<%=headerS%>&second="><%=headerS%></a></li>
				<%
				}
				%>
			</ul>
		</nav>
	</header>
	<div id="hidden_blank">
		<ul id="headerSecond"></ul>
	</div>
</body>
</html>