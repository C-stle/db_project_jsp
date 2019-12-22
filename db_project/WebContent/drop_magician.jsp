<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS Magician</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
</head>
<body>
	<%
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setDateHeader("Expires",0L);
		
		String keep_id = (String)session.getAttribute("id");
		if(keep_id == null || keep_id.equals("")) {
			%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
		}
	%>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('login.jsp')">
	</div>
	<form action="drop_magician_db.jsp" method="post">
		<h1>회원 탈퇴</h1>
		<p>본인 확인을 위해 비밀번호를 입력해주세요.
		<p>비밀번호 : <input type="password" name="pw" required>
		<BR>
		<div>
			<input type="submit" value="회원 탈퇴">
			<input type="button" value="돌아가기" onclick="location.replace('main_magician.jsp')">
		</div>
	</form>
	
</body>
</html>