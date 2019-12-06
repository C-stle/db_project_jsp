<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}

#div_button{
margin_bottom: 3px;
}
</style>
</head>
<body>

	<%
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setDateHeader("Expires",0L);
		
		String id = (String)session.getAttribute("id");
		if(id == null || id.equals("")) {
			%><script>location.replace('login.jsp');</script><%
		}
	%>

	<div>
		<h1>LoDos Magician</h1>
		<p><%=id%>님 환영합니다.
	</div>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('login.jsp')">
	</div>
	<div>
		<input type="button" value="재료 등록" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="마법 등록" onclick="location.href='register_magic.jsp'">
	</div>
	<div>
		<input type="button" value="본인 정보 확인" onclick="location.href='info_magician.jsp'">
	</div>
	<div>
		<input type="button" value="창조 마법 확인" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="창조 마법 거래내역 확인" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="회원 탈퇴" onclick="location.href='register_material.jsp'">
	</div>
</body>
</html>