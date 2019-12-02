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

#div_text {
	position:relative;
	height: auto;
	weight:auto;
	left:50px;
	float: left;
	margin-right: 3px;
}

#div_text_margin {
weight: auto;
height: 21px;
text-align: right;
margin-right: 10px;
margin-top:3px;
margin-bottom: 5.8px;
}

#div_input {
	position:relative;
	left:50px;
}
#div_input_margin {
	margin-bottom: 3px;
}
#div_button {
	position:relative;
	left:130px;
	margin-bottom: 10px;
}

#div_radio {
	position:relative;
	left: 50px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div id="div_top">
		<h1>LoDoS</h1>
	</div>
	<div>
		<form action="login_check.jsp" method="post">
			<div id="div_radio">
				<input type="radio" name="kind" value="Magician" checked>Magician
				<input type="radio" name="kind" value="MagicStore">MagicStore
				<input type="radio" name="kind" value="Customer">Customer
			</div>
				<div id="div_text">
					<div id="div_text_margin">
						<label>아이디</label>
					</div>
					<div id="div_text_margin">
						<label>비밀번호</label>
					</div>
				</div>
				<div id="div_input">
					<div  id="div_input_margin">
						<input name="id" type="text" required="">
					</div>
					<div  id="div_input_margin">
						<input name="password" type="password" required="" />
					</div>
				</div>
			<BR>
			<div id="div_button">
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='register.jsp'">
			</div>
		</form>
	</div>


</body>
</html>