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
		str+="���"+count+" ID : <input name='m_id' type='text' required>";
		str+="&nbsp;�ʿ䷮ : <input name='amount' type='number' min='1' required><BR>";
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
	
	<h1>���� ���</h1>
	<p>���� ���� �Է�
		<input type="button" value="��� �߰�" onclick="addForm()">
		<input type="button" value="��� ����" onclick="delForm()">
	<form action="register_magic_db.jsp" method ="post">
		<div>
			<div>���̵� : <input name="id" type="text" required></div>
			<div>�̸� : <input name="name" type="text" required></div>
			<div>���� : <input name="explain" type="text" required></div>
			<div>Ŭ���� : <input name="class" type="number" min='1' max='9' value='1' required></div>
			<div>�Ӽ� : <input name="attribute" type="text" required></div>
			<div>���� : <input name="type" type="text" required></div>
			<div>ȿ���� : <input name="effect" type="number" min='1' required></div>
			<div>�����Һ� : <input name="mana" type="number" min='1' required></div>
			<div>���� : <input name="price" type="number" min ='1' required><BR><BR></div>
		</div>
		<div id="addedFormDiv">
			<div id="added_1">
				���1 ID : <input name='m_id' type='text' required>
				�ʿ䷮ : <input name='amount' type='number' min='1' required>
			</div>
		</div>
		<div>
			<input type="hidden" name="count" value="1">
		</div>
		<BR>
		<div>
			<input type="submit" value="���">
			<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
		</div>
	</form>
</body>
</html>