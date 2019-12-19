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
<h1>LoDos Magic Store</h1>	
<div id="div_logout">
	<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
</div>
<form action="info_magicstore_db.jsp" method="post">
	<div>
		<p><%=keep_id %> 정보 
		<input type="submit" value="수정 완료">
		<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
	</div>
	<div>
		<div>아이디 : <input type="text" name="id" value="<%=keep_id %>" required></div>
		<div>비밀번호 : <input type="text" name="password" value="<%=request.getParameter("password") %>" required></div>
		<div>회사 이름 : <input type="text" name="name" value="<%=request.getParameter("name") %>" required></div>
		<div>주소 : <input type="text" name="address" value="<%=request.getParameter("address") %>" required></div>
		<div>대표자 : <input type="text" name="representative" value="<%=request.getParameter("representative") %>" required></div>
		<div>거래허가 클래스 : <input type="number" name="class" value="<%=request.getParameter("class") %>" min='1' max='9' required></div>
		<div>소지금 : <input type="number" name="money" value="<%=request.getParameter("money") %>" min='0' required></div>
	</div>
</form>
</body>
</html>