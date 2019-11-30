<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 가입</h1>
	
	<form action="register_check.jsp" method="post">
		<div>
			<input type="radio" name="kind" value="Magician" checked>Magician
			<input type="radio" name="kind" value="MagicStore">MagicStore
			<input type="radio" name="kind" value="Customer">Customer
		
		</div>
		<div>
			<input type="submit" value="계속">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
	
</body>
</html>