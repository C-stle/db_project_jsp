<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS Magician</title>
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
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('login.jsp')">
	</div>
	<form action="drop_magician_db.jsp" method="post">
		<h1>ȸ�� Ż��</h1>
		<p>���� Ȯ���� ���� ��й�ȣ�� �Է����ּ���.
		<p>��й�ȣ : <input type="password" name="pw" required>
		<BR>
		<div>
			<input type="submit" value="ȸ�� Ż��">
			<input type="button" value="���ư���" onclick="location.replace('main_magician.jsp')">
		</div>
	</form>
	
</body>
</html>