<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
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
	<h1>�� ȸ�� ����</h1>
	<form action="register_customer_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>���̵�</label></div>
			<div id="div_text_margin"><label>��й�ȣ</label></div>
			<div id="div_text_margin"><label>�̸�</label></div>
			<div id="div_text_margin"><label>����</label></div>
			<div id="div_text_margin"><label>�ּ�</label></div>
			<div id="div_text_margin"><label>�Ӽ�</label></div>
		</div>
		
		<div id="div_input">
			<div><input name="id" type="text" required=""></div>
			<div><input name="password" type="text" required=""></div>
			<div><input name="name" type="text" required=""></div>
			<div><input name="age" type="number" min='1' required=""></div>
			<div><input name="address" type="text" required=""></div>
			<div><input name="attribute" type="text" required=""></div>
		</div>
		<div id="div_button">
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>