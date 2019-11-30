<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
#div_text {
	position:relative;
	height: auto;
	text-align:rigth;
	left:50px;
	float: left;
	margin: 5px;
}

#div_input {
	position:relative;
	left:50px;
	weight: 350px;
	margin-right: 50px;
}

#div_text_margin {
height: 23.5px;
margin-right: 3px;
text-align:right;
}

#div_button {
position:relative;
top:10px;
left:50px;
}

</style>
</head>
<body>
	<h1>마법사 회원 가입</h1>
	<form action="register_magician_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>아이디</label></div>
			<div id="div_text_margin"><label>비밀번호</label></div>
			<div id="div_text_margin"><label>이름</label></div>
			<div id="div_text_margin"><label>나이</label></div>
			<div id="div_text_margin"><label>종족</label></div>
			<div id="div_text_margin"><label>출신지</label></div>
			<div id="div_text_margin"><label>직업</label></div>
			<div id="div_text_margin"><label>클래스</label></div>
			<div id="div_text_margin"><label>속성</label></div>
			<div id="div_text_margin"><label>마나량</label></div>
		</div>
		
		<div id="div_input">
			<div><input name="id" type="text" required=""></div>
			<div><input name="password" type="text" required=""></div>
			<div><input name="name" type="text" required=""></div>
			<div><input name="age" type="number" min='1' required=""></div>
			<div><input name="species" type="text" required=""></div>
			<div><input name="country" type="text" required=""></div>
			<div><input name="job" type="text" required=""></div>
			<div><input name="class" type="number" min='1' max='9' value='1'></div>
			<div><input name="attribute" type="text" required=""></div>
			<div><input name="mana" type="number" min='100' value='100'></div>
		</div>
		<div id="div_button">
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>