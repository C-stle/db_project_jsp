<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>
#div_top {
	weight: 100%;
	background-color: #0000FF;
	text-align: center;
}
</style>
</head>
<body>
	<div id="div_top">
		<h1>LoDoS</h1>
	</div>
	<div>
		<form action="login_check.jsp" method="post">
			<div>
				<input type="radio" name="kind" value="Magician" checked>Magician
				<input type="radio" name="kind" value="MagicStore">MagicStore
				<input type="radio" name="kind" value="Customer">Customer
			</div>
			<div>
			���̵� : <input name="id" type="text" required="">
			</div>
			<div>
			��й�ȣ : <input name="password" type="password" required="" />
			</div>
			<%
			if(session.getAttribute("kind") == null){
				%>
				<BR>
				<%
			} else if ((int)session.getAttribute("kind") == 1){
				%>
				<p> ��ϵ� ���̵� �����ϴ�.
				<%
				session.removeAttribute("kind");
			} else if ((int)session.getAttribute("kind") == 2){
				%>
				<p> �߸��� ��� ��ȣ �Դϴ�.
				<%
				session.removeAttribute("kind");
			}
			
			%>
			<div>
				<input type="submit" value="�α���">
				<input type="button" value="ȸ������" onclick="location.href='register.jsp'">
			</div>
		</form>
	</div>


</body>
</html>