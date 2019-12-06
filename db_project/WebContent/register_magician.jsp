<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>마법사 회원 가입</h1>
	<form action="register_magician_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" required=""></div>
			<div>비밀번호 : <input name="password" type="text" required=""></div>
			<div>이름 : <input name="name" type="text" required=""></div>
			<div>나이 : <input name="age" type="number" min='1' required=""></div>
			<div>종족 : <input name="species" type="text" required=""></div>
			<div>출신지 : <input name="country" type="text" required=""></div>
			<div>직업 : <input name="job" type="text" required=""></div>
			<div>클래스 : <input name="class" type="number" min='1' max='9' value='1'></div>
			<div>속성 : <input name="attribute" type="text" required=""></div>
			<div>마나량 : <input name="mana" type="number" min='100' value='100'></div>
		</div>
		
		<BR>
		<div>
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>