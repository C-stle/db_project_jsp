<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>������ ȸ�� ����</h1>
	<form action="register_magician_db.jsp" method ="post">
		<div>
			<div>���̵� : <input name="id" type="text" required=""></div>
			<div>��й�ȣ : <input name="password" type="text" required=""></div>
			<div>�̸� : <input name="name" type="text" required=""></div>
			<div>���� : <input name="age" type="number" min='1' required=""></div>
			<div>���� : <input name="species" type="text" required=""></div>
			<div>����� : <input name="country" type="text" required=""></div>
			<div>���� : <input name="job" type="text" required=""></div>
			<div>Ŭ���� : <input name="class" type="number" min='1' max='9' value='1'></div>
			<div>�Ӽ� : <input name="attribute" type="text" required=""></div>
			<div>������ : <input name="mana" type="number" min='100' value='100'></div>
		</div>
		
		<BR>
		<div>
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>