<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>�� ȸ�� ����</h1>
	<form action="register_customer_db.jsp" method ="post">
		<div>
			<div>���̵� : <input name="id" type="text" required=""></div>
			<div>��й�ȣ : <input name="password" type="text" required=""></div>
			<div>�̸� : <input name="name" type="text" required=""></div>
			<div>���� : <input name="age" type="number" min='1' required=""></div>
			<div>�ּ� : <input name="address" type="text" required=""></div>
			<div>�Ӽ� : <input name="attribute" type="text" required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.replace(login.jsp)">
		</div>
	</form>
</body>
</html>