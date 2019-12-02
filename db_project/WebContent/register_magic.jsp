<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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


</style>
<script type="text/javascript">
	var count = 1;

	function addForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		var str = "";
		count++;
		str+="<BR>"
		str+="재료"+count+" ID <input name='m_id' type='text' required>";
		str+="&nbsp;필요량 <input name='amount' type='number' min='1' required><BR>";
		var addedDiv = document.createElement("div");
		addedDiv.id = "added_"+count;
		addedDiv.innerHTML  = str;
		addedFormDiv.appendChild(addedDiv);
		document.baseForm.count.value=count;
	}

	function delForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		if(count >1){
			var addedDiv = document.getElementById("added_"+(count--));
			addedFormDiv.removeChild(addedDiv);
		} else{
			document.baseForm.reset();
		}
	}
</script>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");	
	%>
	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<h1>마법 등록</h1>
	<p>마법 정보 입력
		<input type="button" value="재료 추가" onclick="addForm()">
		<input type="button" value="재료 삭제" onclick="delForm()">
	<form action="register_magic_db.jsp" method ="post">
		<div id="div_text">
			<div id="div_text_margin"><label>아이디</label></div>
			<div id="div_text_margin"><label>이름</label></div>
			<div id="div_text_margin"><label>설명</label></div>
			<div id="div_text_margin"><label>클래스</label></div>
			<div id="div_text_margin"><label>속성</label></div>
			<div id="div_text_margin"><label>종류</label></div>
			<div id="div_text_margin"><label>효과량</label></div>
			<div id="div_text_margin"><label>마나소비량</label></div>
			<div id="div_text_margin"><label>가격</label></div>
		</div>
		
		<div id="div_input">
			<div id="div_input_margin"><input name="id" type="text" required></div>
			<div id="div_input_margin"><input name="name" type="text" required></div>
			<div id="div_input_margin"><input name="explain" type="text" required></div>
			<div id="div_input_margin"><input name="class" type="number" min='1' max='9' value='1' required></div>
			<div id="div_input_margin"><input name="attribute" type="text" required></div>
			<div id="div_input_margin"><input name="type" type="text" required></div>
			<div id="div_input_margin"><input name="effect" type="number" min='1' required></div>
			<div id="div_input_margin"><input name="mana" type="number" min='1' required></div>
			<div id="div_input_margin"><input name="price" type="number" min ='1' required><BR><BR></div>
		</div>
		<div id="addedFormDiv">
			<div id="added_1">
				재료1 ID <input name='m_id' type='text' required>
				필요량 <input name='amount' type='number' min='1' required>
			</div>
		</div>
		<div>
			<input type="hidden" name="count" value="1">
		</div>
		<BR>
		<div id="div_button">
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
		<BR>
	</form>
</body>
</html>