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
		<h1>LoDos MagicStore</h1>
		<p><%=id %>�� ȯ���մϴ�.
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('login.jsp')">
		</div>
	</div>
	<div>
		<input type="button" value="�Ҽ� ������  ��ȸ" onclick="location.href='search_belong_magician.jsp'">
	</div>
	<div>
		<input type="button" value="��� ��� ���" onclick="location.href='search_sell_material.jsp'">
	</div>
	<div>
		<input type="button" value="������ȸ ���� Ȯ��" onclick="location.href='register_material.jsp'">
	</div>
</body>
</html>