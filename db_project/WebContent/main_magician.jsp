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
	// ��� ���, ���� ���, ���� ���� Ȯ��/����, ������ â���� ���� Ȯ��/����
%>

	<div>
		<h1>LoDos Magician</h1>
		<p><%=id %>�� ȯ���մϴ�.
	</div>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<div>
		<input type="button" value="���  ���" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="���� ���" onclick="location.href='register_magic.jsp'">
	</div>
	<div>
		<input type="button" value="���� ���� Ȯ��" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="â�� ���� Ȯ��" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="â�� ���� �ŷ����� Ȯ��" onclick="location.href='register_material.jsp'">
	</div>
</body>
</html>