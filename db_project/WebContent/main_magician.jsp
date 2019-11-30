<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
margin_bottom: 10px;
}

</style>
</head>
<body>
	
<%
	String id = (String)session.getAttribute("id");
	String url = request.getHeader("referer");
	// 재료 등록, 마법 등록, 본인 정보 확인/수정, 본인이 창조한 마법 확인/수정
%>

	<div>
		<h1>LoDos Magician</h1>
		<p><%=id %>님 환영합니다.
	</div>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<div>
		<input type="button" value="재료  등록" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="마법 등록" onclick="location.href='register_magic.jsp'">
	</div>
	<div>
		<input type="button" value="본인 정보 확인" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="창조 마법 확인" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="창조 마법 거래내역 확인" onclick="location.href='register_material.jsp'">
	</div>
</body>
</html>