<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>고객 회원 가입</h1>
	<form action="register_customer_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" required=""></div>
			<div>비밀번호 : <input name="password" type="text" required=""></div>
			<div>이름 : <input name="name" type="text" required=""></div>
			<div>나이 : <input name="age" type="number" min='1' required=""></div>
			<div>주소 : <input name="address" type="text" required=""></div>
			<div>속성 : <input name="attribute" type="text" required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.replace(login.jsp)">
		</div>
	</form>
</body>
</html>