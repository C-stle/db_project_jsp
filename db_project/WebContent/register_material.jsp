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
	<h1>��� ���</h1>
	<form action="register_material_db.jsp" method ="post">
		<div>
			<div>���̵� : <input name="id" type="text" required=""></div>
			<div>�̸� : <input name="name" type="text" required=""></div>
			<div>������ : <input name="origin" type="text" required=""></div>
			<div>���� : <input name="type" type="text" required=""></div>
			<div>���� : <input name="price" type="number" min='1' required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>