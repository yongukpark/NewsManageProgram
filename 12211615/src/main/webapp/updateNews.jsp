<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8" import="myBean.*, java.sql.*"%>
<!-- 뉴스 기사 출력 페이지 -->

<%
ClassificationDB cf = new ClassificationDB();
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

article {
	margin-left: 20%;
	width: 60%;
	padding: 0px 60px;
}

#current_category {
	height: 20px;
	font-size: 20px;
	font-weight: bold;
	padding: 15px 0px;
	color: #233c90;
	font-weight: bold;
	margin: 20px 0px;
}

.block {
	border-left: 1px solid #e5e5e5;
	border-right: 1px solid #e5e5e5;
	height: auto;
	padding: 10px 10px;
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

.input_image {
	margin-top: 20px;
	font-size: 15px;
}

footer {
	text-align:right;
}

footer>div {
	margin-top: 5px;
	display: inline-block;
	font-size: 17px;
	vertical-align: bottom;
}

footer>div>input {
	height: 30px;
}

#preView
{
	margin-left: 7.5%;
	border: 0px;
	background-color: #e6ffec;
	height: 50px;
	width: 15%;
	font-size: 20px;
	border: 2px solid #88ff99;
}

#preView:hover {
	background-color: #33ff66;
	cursor: pointer;
}

#submit {
	margin-left: 7.5%;
	border: 0px;
	background-color: #e6ecff;
	height: 50px;
	width: 15%;
	font-size: 20px;
	border: 2px solid #3366ff;
}

#submit:hover {
	background-color: #3366ff;
	cursor: pointer;
}


#search_button:hover {
	cursor: pointer;
}
</style>

<script>
<!-- 처음 로드 될때 분류1에 리스트로 출력될 항목들 설정 -->
window.onload = function () {
	<%ArrayList<Classification> arrLi = cf.selectAll();
cf.close();%>
	
	var arrFirst = new Array();
	var arr = new Array();
	
	<%for (int i = 0; i < arrLi.size(); i++) {%>
		arr.push(["<%=arrLi.get(i).getFirst()%>","<%=arrLi.get(i).getSecond()%>","<%=arrLi.get(i).getCode()%>"]);
<%}%>
	var preString = "";

		for ( var i in arr) {
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
		
		var c1Obj = document.getElementById("first");
	    for (var i = 0; i < c1Obj.options.length; i++) {
	        if (c1Obj.options[i].value === "<%=news.getFirst()%>") {
	            c1Obj.selectedIndex = i;
	            break;
	        }
	    }
		
		var c2Obj = document.getElementById("second");

		for ( var i in arr) {
			if (arr[i][0] == c1Obj.value) {
				var optionObj = document.createElement("option");
				optionObj.setAttribute("value", arr[i][1]);
				var t = document.createTextNode(arr[i][1]);
				optionObj.appendChild(t);
				c2Obj.appendChild(optionObj);
			}
		}
	    for (var i = 0; i < c2Obj.options.length; i++) {
	        if (c2Obj.options[i].value === "<%=news.getSecond()%>") {
	            c2Obj.selectedIndex = i;
	            break;
	        }
	    }
		document.getElementById("code").value = <%=news.getCode()%>;
		
		var status = document.getElementById("status")
	    for (var i = 0; i < 2; i++) {
	        if (status.options[i].value === "<%=news.getStatus()%>") {
	        	status.selectedIndex = i;
	        	break;
	        }
	    }
		
		<!--분류 1이 선택되었을때 그에 맞는 분류 2의 항목들을 설정-->
		document.getElementById("first").onchange = function() {

			var c1Obj = document.getElementById("first");
			var c2Obj = document.getElementById("second");
			for (var i = c2Obj.children.length - 1; i >= 1; i--) {
				c2Obj.remove(i);
			}

			for ( var i in arr) {
				if (arr[i][0] == c1Obj.value) {
					var optionObj = document.createElement("option");
					optionObj.setAttribute("value", arr[i][1]);
					var t = document.createTextNode(arr[i][1]);
					optionObj.appendChild(t);
					c2Obj.appendChild(optionObj);
				}
			}
			document.getElementById("code").value = "";
		}
		<!--분류 1,2 모두 선택되었을때 그에 맞는 코드 자동 입력-->
		document.getElementById("second").onchange = function() {
			var c1Obj = document.getElementById("first");
			var c2Obj = document.getElementById("second");
			for ( var i in arr) {
				if (arr[i][0] == c1Obj.value) {
					if (arr[i][1] == c2Obj.value) {
						document.getElementById("code").value = arr[i][2];
						return;
					}

				}

			}
		}
	}
</script>
</head>
<body>
	<%@ include file="/header.jsp"%>
	<div id="middle_blank"></div>

	<article>
		<form method="post" action="updateNewsActionForm.jsp?id=<%=id %>" enctype="multipart/form-data">
			<div id="current_category">기사 수정하기</div>
			<div style="padding: 30px 60px; border: 2px solid #a6a6a6;">
				<div class="block" style="border-top: 1px solid #e5e5e5;">
					분류1 : <select name="first" id="first" class="input_block" style="width: 17%; font-size: 15px" required="required">
						<option value="" selected disabled>분류를 선택해주세요.</option>

					</select> 분류2 : <select name="second" id="second" class="input_block" style="width: 17%; font-size: 15px" required="required">
						<option value="" selected>분류를 선택해주세요.</option>

					</select> 분류 코드 : <input type="text" name="code" id="code" class="input_block" readonly style="height: 44px; width: 9%; background-color: #e5e5e5; font-size: 20px; text-align: center;"> 등록 상태 : <select name="status" id="status" class="input_block" style="width: 11.5%; margin-right: 0px; font-size: 15px">
						<option value="등록완료" selected>등록완료</option>
						<option value="등록대기">등록대기</option>
					</select>
				</div>
				<div class="block">
					기사취재일 : <input type="date" name="reportDay" class="input_block" style="height: 44px; width: 17%;" value="<%=news.getReportDay() %>" required> 기자 이름 : <input type="text" name="reporterName" class="input_block" style="height: 44px; width: 15%;" value="<%=news.getReporterName()%>" required> 기자 이메일 : <input type="email" name="reporterEmail" class="input_block" style="height: 44px; width: 26%; margin-right: 0px;" value="<%=news.getReporterEmail()%>"required>
				</div>
				<div class="block">
					제목 : <input type="text" name="title" id="title" class="input_block" style="height: 44px; width: 93.5%; margin-right: 0px;" value="<%=news.getTitle()%>"required>
				</div>
				<div class="block">
					<em style="color: gray; font-size: 15px">내용 입력 안내 : <br> 글 중간에 사진을 넣고 싶은 경우 그 위치에 맞게 사진을 넣은 다음 그 다음 입력창에 입력을 이어가 주세요. <br>내용1과 썸네일 이미지는 필수 입력란입니다."</em>
				</div>
				<div class="block">
					내용1 :<br>
					<textarea name="content1" class="input_block" style="height: 300px; width: 93.7%; margin-right:0px;" required><%=news.getContent1()%></textarea>
				</div>
				<div class="block">
				<img src="./upload/<%=news.getImage1() %>" width="60%" height="60%"><br>
					본문 이미지1 수정: <input type="file" name="image1"><br>
				</div>
				<div class="block">
					내용2 :<br>
					<textarea name="content2" class="input_block" style="height: 300px; width: 93.7%; margin-right: 0px;"><%=news.getContent2() %></textarea>
				</div>
				<div class="block">
				<img src="./upload/<%=news.getImage2() %>" width="60%" height="60%"><br>
					본문 이미지2 수정 : <input type="file" name="image2"><br>
				</div>
				<div class="block">
					내용3 :<br>
					<textarea name="content3" class="input_block" style="height: 300px; width: 93.7%; margin-right: 0px;"><%=news.getContent3() %></textarea>
				</div>
				<div class="block" >
				<img src="./upload/<%=news.getImage3() %>" width="60%" height="60%"><br>
					본문 이미지3 수정: <input type="file" name="image3"><br>
				</div>
				<div class="block" style="border-bottom: 1px solid #e5e5e5">
				<img src="./upload/<%=news.getThumbnail()%>" width="60%" height="60%"><br>
					썸네일 이미지 수정: <input type="file" name="thumbnail">
				</div>
			</div>

			<footer>
			<br><br><br>
				<button type="submit" id="submit">수정</button>
			</footer>
		</form>
	</article>
<br><br><br><br><br>
</body>
</html>