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
		<div>
			<div>아이디 : <input name="id" type="text" required=""></div>
			<div>이름 : <input name="name" type="text" required=""></div>
			<div>원산지 : <input name="origin" type="text" required=""></div>
			<div>종류 : <input name="type" type="text" required=""></div>
			<div>가격 : <input name="price" type="number" min='1' required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>