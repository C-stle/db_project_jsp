<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
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
		String keep_id = (String)session.getAttribute("id");
		if(keep_id == null || keep_id.equals("")) {
			%><script>location.replace('login.jsp');</script><%
		}
	%>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
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