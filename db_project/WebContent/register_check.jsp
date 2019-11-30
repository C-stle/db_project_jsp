<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>종류 확인</h1>
<%
	String kind = request.getParameter("kind");
	String redirect = null;

	if(kind.equals("Magician")) {
		redirect = "register_magician.jsp";
	} else if (kind.equals("MagicStore")) {
		redirect = "register_magicstore.jsp";
	} else {
		redirect = "register_customer.jsp";
	}
	response.sendRedirect(redirect);
%>
</body>
</html>