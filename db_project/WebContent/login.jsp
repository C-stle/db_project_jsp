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
			아이디 : <input name="id" type="text" required="">
			</div>
			<div>
			비밀번호 : <input name="password" type="password" required="" />
			</div>
			<%
			if(session.getAttribute("kind") == null){
				%>
				<BR>
				<%
			} else if ((int)session.getAttribute("kind") == 1){
				%>
				<p> 등록된 아이디가 없습니다.
				<%
				session.removeAttribute("kind");
			} else if ((int)session.getAttribute("kind") == 2){
				%>
				<p> 잘못된 비밀 번호 입니다.
				<%
				session.removeAttribute("kind");
			}
			
			%>
			<div>
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='register.jsp'">
			</div>
		</form>
	</div>


</body>
</html>