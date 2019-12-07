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
<script type="text/javascript">
	var count = 1;

	function addForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		var str = "";
		count++;
		str+="<BR>"
		str+="재료"+count+" ID : <input name='m_id' type='text' required>";
		str+="&nbsp;필요량 : <input name='amount' type='number' min='1' required><BR>";
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
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>location.replace('login.jsp');</script><%
	}
	%>
	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	
	<h1>마법 등록</h1>
	<p>마법 정보 입력
		<input type="button" value="재료 추가" onclick="addForm()">
		<input type="button" value="재료 삭제" onclick="delForm()">
	<form action="register_magic_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" required></div>
			<div>이름 : <input name="name" type="text" required></div>
			<div>설명 : <input name="explain" type="text" required></div>
			<div>클래스 : <input name="class" type="number" min='1' max='9' value='1' required></div>
			<div>속성 : <input name="attribute" type="text" required></div>
			<div>종류 : <input name="type" type="text" required></div>
			<div>효과량 : <input name="effect" type="number" min='1' required></div>
			<div>마나소비량 : <input name="mana" type="number" min='1' required></div>
			<div>가격 : <input name="price" type="number" min ='1' required><BR><BR></div>
		</div>
		<div id="addedFormDiv">
			<div id="added_1">
				재료1 ID : <input name='m_id' type='text' required>
				필요량 : <input name='amount' type='number' min='1' required>
			</div>
		</div>
		<div>
			<input type="hidden" name="count" value="1">
		</div>
		<BR>
		<div>
			<input type="submit" value="등록">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>