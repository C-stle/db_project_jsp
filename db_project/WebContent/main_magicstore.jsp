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

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
}
%>

	<div>
		<h1>LoDos Magic Store</h1>
		<p><%=keep_id %>�� ȯ���մϴ�.
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
		<input type="button" value="������ȸ ���� Ȯ��" onclick="location.href='info_magicstore.jsp'">
	</div>
	<div>
		<input type="button" value="�ŷ����� Ȯ��" onclick="location.href='search_trade_ms.jsp'">
	</div>
</body>
</html>