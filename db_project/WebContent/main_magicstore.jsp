<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
<%
	String id = (String) session.getAttribute("id");
	String url = request.getHeader("referer");
	
%>

	<div>
		<h1>LoDos MagicStore</h1>
		<p><%=id %>�� ȯ���մϴ�.
		
	</div>
	<div>
		<input type="button" value="������  ���" onclick="location.href='register_edit.jsp'">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
</body>
</html>