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
	<h1>������ ȸ�� ����</h1>
	<form action="register_magician_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>���̵�</label></div>
			<div id="div_text_margin"><label>��й�ȣ</label></div>
			<div id="div_text_margin"><label>�̸�</label></div>
			<div id="div_text_margin"><label>����</label></div>
			<div id="div_text_margin"><label>����</label></div>
			<div id="div_text_margin"><label>�����</label></div>
			<div id="div_text_margin"><label>����</label></div>
			<div id="div_text_margin"><label>Ŭ����</label></div>
			<div id="div_text_margin"><label>�Ӽ�</label></div>
			<div id="div_text_margin"><label>������</label></div>
		</div>
		
		<div id="div_input">
			<div id="div_input_margin"><input name="id" type="text" required=""></div>
			<div id="div_input_margin"><input name="password" type="text" required=""></div>
			<div id="div_input_margin"><input name="name" type="text" required=""></div>
			<div id="div_input_margin"><input name="age" type="number" min='1' required=""></div>
			<div id="div_input_margin"><input name="species" type="text" required=""></div>
			<div id="div_input_margin"><input name="country" type="text" required=""></div>
			<div id="div_input_margin"><input name="job" type="text" required=""></div>
			<div id="div_input_margin"><input name="class" type="number" min='1' max='9' value='1'></div>
			<div id="div_input_margin"><input name="attribute" type="text" required=""></div>
			<div id="div_input_margin"><input name="mana" type="number" min='100' value='100'></div>
		</div>
		<BR>
		<div id="div_button">
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>