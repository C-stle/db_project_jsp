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
	weight:auto;
	left:50px;
	float: left;
	margin-right: 3px;
}

#div_text_margin {
weight: auto;
height: 21px;
text-align: right;
margin-right: 10px;
margin-top:3px;
margin-bottom: 5.8px;
}

#div_input {
	position:relative;
	left:50px;
}
#div_input_margin {
	margin-bottom: 3px;
}
#div_button {
	position:relative;
	left:130px;
	margin-bottom: 10px;
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
		<div id="div_text">
			<div id="div_text_margin"><label>���̵�</label></div>
			<div id="div_text_margin"><label>�̸�</label></div>
			<div id="div_text_margin"><label>������</label></div>
			<div id="div_text_margin"><label>����</label></div>
			<div id="div_text_margin"><label>����</label></div>
		</div>
		
		<div id="div_input">
			<div id="div_input_margin"><input name="id" type="text" required=""></div>
			<div id="div_input_margin"><input name="name" type="text" required=""></div>
			<div id="div_input_margin"><input name="origin" type="text" required=""></div>
			<div id="div_input_margin"><input name="type" type="text" required=""></div>
			<div id="div_input_margin"><input name="price" type="number" min='1' required=""></div>
		</div>
		<BR>
		<div id="div_button">
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>