<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, myBean.*, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- java Beans를 이용하여 ArrayList에 객체로 저장 --%>
<%-- 모든 코드를 출력하기때문에 select * from classification의 형태로 받아옴 --%>
<%
ClassificationDB cf = new ClassificationDB();
ArrayList<Classification> arr = cf.selectAll();
cf.close();
%>
<title>Insert title here</title>
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
	height: auto;
	padding: 10px 10px;
	line-height: 50px;
	font-size: 17px;
	font-weight: bold;
}

.label {
	display: inline-block;
	vertical-align: top;
	height: 50px;
	width: 24%;
	text-align: center;
	font-size: 23px;
}

.block>div>div>div {
	display: inline-block;
	vertical-align: top;
	width: 24.1%;
	text-align: center;
	margin-top: 10px;
}

input[type=text] {
	font-size: 22px;
	text-align: center;
	width: 70%;
	padding-top: 10px;
	padding-bottom: 10px;
	background-color: #e5e5e5;
}

input[type=button] {
	font-size: 22px;
	width: 30%;
	margin-left: 5%;
	text-align: center;
}

input[type=button]:hover {
	background-color: #50bcdf;
	border-style: none;
	cursor: pointer;
}
</style>
<script>
<%--태그 추가하는 메소드 + validation check--%> 
	function add() {
	var f = document.getElementsByName("first")[0].value;
	var s = document.getElementsByName("second")[0].value;
	var c = document.getElementsByName("code")[0].value;
	if(f =="" || s =="" || c=="")
	{
		alert("모든 값을 기입해주세요.");
		return false;
	}
	
	<%for (int i = 0; i < arr.size(); i++) {%>	
		if (f == "<%=arr.get(i).getFirst()%>" && s == "<%=arr.get(i).getSecond()%>") 
		{
			alert("이미 존재하는 분류명입니다");
			return false;
		}
		else if(c == "<%=arr.get(i).getCode()%>") {
			alert("중복된 분류 코드입니다");
			return false;
		}
		else if(c < 1000 || c >= 9000)
		{
			alert("코드 입력 (1000 ~ 8999사이의 미사용 코드)");
			return false;
		}
		
<%}%>
	alert("분류가 추가 되었습니다.\n분류1 :"+f+"\n분류2 : "+s+"\n코드 : "+c);
	location.href = "addClassificationActionForm.jsp?first=" + f
				+ "&&second=" + s + "&&code=" + c;
	}
<%--수정버튼을 클릭하면 저장이라는 버튼으로 바뀌고 readonly가 풀림--%>
	function modify(nowObj)
	{
		var parent = nowObj.parentElement.parentElement;
		parent.childNodes[1].childNodes[1].readOnly = false;
		parent.childNodes[1].childNodes[1].style.backgroundColor = "white";
		parent.childNodes[3].childNodes[1].readOnly = false;
		parent.childNodes[3].childNodes[1].style.backgroundColor = "white";
		parent.childNodes[7].childNodes[1].value = "저장";
		parent.childNodes[7].childNodes[1].setAttribute("onClick","save(this)");
		
	}
<%--수정에서 저장버튼으로 바뀌었을때 저장버튼을 클릭하면 사용되는 메소드로 실제 수정액션폼으로 전달--%>
	function save(nowObj)
	{
		var parent = nowObj.parentElement.parentElement;
		alert("수정되었습니다.");
		location.href = "updateClassificationActionForm.jsp?first="+parent.childNodes[1].childNodes[1].value+"&&second="+parent.childNodes[3].childNodes[1].value+"&&code="+parent.childNodes[5].childNodes[1].value;
	}
<%--삭제 여부 물어본 후 삭제 액션폼으로 전달--%>
	function del(num)
	{
		if(confirm('정말 삭제하시겠습니까?'))
		{
			location.href="deleteClassificationActionForm.jsp?code="+num;
		}
		
	}
	
	
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="middle_blank"></div>
	<article>
		<div id="current_category">기사 분류 관리</div>
		<div style="padding: 30px 60px; border: 2px solid #a6a6a6;">
			<div class="block" style="border: 1px solid #e5e5e5;">
				<div>
					<div class="label">분류1</div>
					<div class="label">분류2</div>
					<div class="label">코드</div>
					<div class="label">비고</div>
					<%--  위에서 beans로 받아온 객체를 이용하여 화면구성--%>
					<%
					String preString = "";
					for (int i = 0; i < arr.size() - 1; i++) {
						if (!preString.equals(arr.get(i).getFirst())) {
					%>
				</div>
				<div style="margin-top: 20px;">
					<%
					preString = arr.get(i).getFirst();
					}
					%>
					<div>
						<div>
							<input type="text" value="<%=arr.get(i).getFirst()%>" readonly>
						</div>
						<div>
							<input type="text" value="<%=arr.get(i).getSecond()%>" readonly>
						</div>
						<div>
							<input type="text" value="<%=arr.get(i).getCode()%>" readonly>
						</div>
						<div>
							<input type="button" value="수정" onclick="modify(this)" /><input type="button" value="삭제" onclick="del(<%=arr.get(i).getCode()%>)" />
						</div>
					</div>
					<%
					}
					%>
					<div style="margin-top: 20px;">
						<div>
							<input type="text" value="<%=arr.get(arr.size()-1).getFirst()%>" readonly>
						</div>
						<div>
							<input type="text" value="<%=arr.get(arr.size()-1).getSecond()%>" readonly>
						</div>
						<div>
							<input type="text" value="<%=arr.get(arr.size()-1).getCode()%>" readonly>
						</div>
					</div>
				</div>
				<div style="margin-top: 20px">
					<div>
						<div>
							<input type="text" name="first" value="" style="background-color: white;">
						</div>
						<div>
							<input type="text" name="second" value="" style="background-color: white;">
						</div>
						<div>
							<input type="text" name="code" value="" style="background-color: white;">
						</div>
						<div>
							<input type="button" value="분류 추가하기" style="width: 60%" onclick="add()" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>

</body>

</html>