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
	session.setAttribute("ms_id",request.getParameter("ms_id"));
%>
<script>
	location.replace("info_magicstore.jsp");
</script>
</body>
</html>