<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS Customer</title>
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
	
	// �ŷ�ó ���/���� - ��ü ������ȸ ��� ǥ��, �˻����
	// ���� ���� - �ŷ�ó�� ������ȸ ��� ǥ��, ������ ������ȸ���� �Ǹ��ϴ� ���� ����Ʈ ǥ��, ����, ����
	// ��ᱸ�� - �ŷ�ó�� ������ȸ ��� ǥ��, ������ ������ȸ���� �Ǹ��ϴ� ��� ����Ʈ ǥ��, ����, ����
	// ���� Ȯ��, ���� - �ŷ�ó ������ȸ(Ŭ���� ���� ǥ��)
	// �ŷ����� Ȯ��
	%>

	<div>
		<h1>LoDos Customer</h1>
		<p><%=keep_id %>�� ȯ���մϴ�.
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('login.jsp')">
		</div>
	</div>
	<div>
		<input type="button" value="�ŷ�ó  ��ȸ" onclick="location.href='search_magicstore_account.jsp'">
	</div>
	<div>
		<input type="button" value="���� / ��� ����" onclick="location.href='info_customer_account.jsp'">
	</div>
	<div>
		<input type="button" value="���� ���� Ȯ��" onclick="location.href='info_customer.jsp'">
	</div>
	<div>
		<input type="button" value="���� �ŷ� ���� Ȯ��" onclick="location.href='search_trade_customer_magic.jsp'">
	</div>
	<div>
		<input type="button" value="��� �ŷ� ���� Ȯ��" onclick="location.href='search_trade_customer_material.jsp'">
	</div>
	<div>
		<input type="button" value="ȸ�� Ż��" onclick="location.href='drop_customer.jsp'">
	</div>
</body>
</html>