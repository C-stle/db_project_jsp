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
			%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
		}
	%>

	<div>
		<h1>LoDos Magician</h1>
		<p><%=id%>�� ȯ���մϴ�.
	</div>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('login.jsp')">
	</div>
	<div>
		<input type="button" value="��� ���" onclick="location.href='register_material.jsp'">
	</div>
	<div>
		<input type="button" value="���� ���" onclick="location.href='register_magic.jsp'">
	</div>
	<div>
		<input type="button" value="���� ���� Ȯ��" onclick="location.href='info_magician.jsp'">
	</div>
	<div>
		<input type="button" value="â�� ���� Ȯ��" onclick="location.href='info_magic.jsp'">
	</div>
	<div>
		<input type="button" value="â�� ���� �ŷ����� Ȯ��" onclick="location.href='search_trade_magic.jsp'">
	</div>
	<div>
		<input type="button" value="ȸ�� Ż��" onclick="location.href='register_material.jsp'">
	</div>
</body>
</html>