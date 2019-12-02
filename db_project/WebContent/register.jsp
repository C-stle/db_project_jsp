<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
#div_button {
	position:relative;
	left:130px;
	margin-bottom: 10px;
}

#div_radio {
	position:relative;
	left: 50px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<h1>회원 가입</h1>
	
	<form action="register_check.jsp" method="post">
		<div id="div_radio">
			<input type="radio" name="kind" value="Magician" checked>Magician
			<input type="radio" name="kind" value="MagicStore">MagicStore
			<input type="radio" name="kind" value="Customer">Customer
		
		</div>
		<div id="div_button">
			<input type="submit" value="계속">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
	
</body>
</html>