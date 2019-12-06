<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>마법상회 회원 가입</h1>
	<form action="register_magicstore_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" required=""></div>
			<div>비밀번호 : <input name="password" type="text" required=""></div>
			<div>상호 : <input name="name" type="text" required=""></div>
			<div>주소 : <input name="address" type="text" required=""></div>
			<div>대표자 이름 : <input name="representatvie" type="text" required=""></div>
			<div>거래허가 클래스 : <input name="class" type="number" min='1' max='9' value='1' required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>