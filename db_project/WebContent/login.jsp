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

#div_main {
	weight: 500px;
}

#div_text {
	weight: 150px;
	height: auto;
	float: left;
	margin: 10px;
}

#div_input {
	weight: 350px;
	margin-left: 10px;
	margin: 5px;
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
			<div id="div_main">
				<div id="div_text">
					<div>
						<label>아이디</label>
					</div>
					<div>
						<label>비밀번호</label>
					</div>
				</div>
				<div id="div_input">
					<div>
						<input name="id" type="text" required="">
					</div>
					<div>
						<input name="password" type="password" required="" />
					</div>
				</div>
			</div>
			<div>
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='register.jsp'">
			</div>
		</form>
	</div>


</body>
</html>