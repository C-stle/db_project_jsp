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
	weight:auto;
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
	left: 0px;
}
#div_input_margin {
	margin-bottom: 3px;
}
#div_button {
	position:relative;
	left:130px;
	margin-bottom: 10px;
}

</style>
</head>
<body>
	<h1>마법상회 회원 가입</h1>
	<form action="register_magicstore_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>아이디</label></div>
			<div id="div_text_margin"><label>비밀번호</label></div>
			<div id="div_text_margin"><label>상호</label></div>
			<div id="div_text_margin"><label>주소</label></div>
			<div id="div_text_margin"><label>대표자이름</label></div>
			<div id="div_text_margin"><label>거래허가클래스</label></div>
		</div>
		
		<div id="div_input">
			<div id="div_input_margin"><input name="id" type="text" required=""></div>
			<div id="div_input_margin"><input name="password" type="text" required=""></div>
			<div id="div_input_margin"><input name="name" type="text" required=""></div>
			<div id="div_input_margin"><input name="address" type="text" required=""></div>
			<div id="div_input_margin"><input name="representatvie" type="text" required=""></div>
			<div id="div_input_margin"><input name="class" type="number" min='1' max='9' value='1' required=""></div>
		</div>
		<BR>
		<div id="div_button">
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
		</div>
	</form>
</body>
</html>