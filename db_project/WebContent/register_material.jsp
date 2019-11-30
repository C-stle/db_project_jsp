<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}

#div_text {
	position:relative;
	height: auto;
	text-align:rigth;
	left:50px;
	float: left;
	margin: 5px;
}

#div_input {
	position:relative;
	left:50px;
	weight: 350px;
	margin-right: 50px;
}

#div_text_margin {
height: 23.5px;
margin-right: 3px;
text-align:right;
}

#div_button {
position:relative;
top:10px;
left:50px;
}

</style>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
	%>
	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<h1>재료 등록</h1>
	<form action="register_material_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>아이디</label></div>
			<div id="div_text_margin"><label>이름</label></div>
			<div id="div_text_margin"><label>원산지</label></div>
			<div id="div_text_margin"><label>종류</label></div>
			<div id="div_text_margin"><label>가격</label></div>
		</div>
		
		<div id="div_input">
			<div><input name="id" type="text" required=""></div>
			<div><input name="name" type="text" required=""></div>
			<div><input name="origin" type="text" required=""></div>
			<div><input name="type" type="text" required=""></div>
			<div><input name="price" type="number" min='1' required=""></div>
		</div>
		<div id="div_button">
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>