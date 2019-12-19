<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
</style>
<script type="text/javascript">
var count = 0;
var kind = "id";
function filter(){
	var value, radio, table, cell, i;
	value = document.getElementById("value").value;
	table = document.getElementById("table");
	if (kind == "id") {
		cell = 0;
	} else if(kind == "name"){
		cell = 1;
	} else if (kind == "explain") {
		cell = 2;
	} else if (kind == "class"){
		cell = 3;
	} else if (kind == "attribute"){
		cell = 4;
	} else if (kind == "type"){
		cell = 5;
	} else if (kind == "effect"){
		cell = 6;
	} else if (kind == "mana"){
		cell = 7;
	} else if (kind == "price"){
		cell = 8;
	} else if (kind == "creator"){
		cell = 9;
	}

	for(i=1;i<=count;i++){
		if(cell == 3 || cell == 6 || cell == 7 || cell == 8){
			if(value == ""){
				table.rows[i].style.display="";
			} else {
				if(table.rows[i].cells[cell].innerHTML == value){
					table.rows[i].style.display="";
				} else {
					table.rows[i].style.display="none";
				}
			}
		} else {
			if(table.rows[i].cells[cell].innerHTML.indexOf(value) > -1){
				table.rows[i].style.display="";
			} else {
				table.rows[i].style.display="none";
			}
		}
	}
}

function onchecked(){
	var radio = document.getElementsByName("kind");
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			kind = radio[i].value;
		}
	}
}

function onBuyClicked(){
	var checkbox, table;
	checkbox = document.getElementsByName("buy");
	
	for(var i = 0;i<checkbox.length;i++){
		if(checkbox[i].checked==true){
			
			var addedFormDiv = document.getElementById("addedFormDiv");
			var str = "";
			str+="<input name='m_id' type='hidden' value='"+ checkbox[i].value + "'>";
			str+="<input name='m_price' type='hidden' value='" + checkbox[i].id + "'>";
			var addedDiv = document.createElement("div");
			addedDiv.id = "added";
			addedDiv.innerHTML  = str;
			addedFormDiv.appendChild(addedDiv);
		}
	}
	
	document.getElementById("hideForm").submit();
}

</script>
</head>
<body>
<%
// ��ü ������ ��� ǥ��, ���� (�㰡 Ŭ���� ���� üũ)
// ������ ��Ͽ� ���� �˻���� ����
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",0L);

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
}
%>
<div>
	<h1>LoDos Customer</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p>�Ǹ� ���� ��ȸ
</div>
<div>
	<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>���̵�
	<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">�̸�
	<input type="radio" name="kind" id="kind" value="explain" onclick="onchecked();">����
	<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">Ŭ����
	<input type="radio" name="kind" id="kind" value="attribute" onclick="onchecked();">�Ӽ�
	<input type="radio" name="kind" id="kind" value="type" onclick="onchecked();">����
	<input type="radio" name="kind" id="kind" value="effect" onclick="onchecked();">ȿ����
	<input type="radio" name="kind" id="kind" value="mana" onclick="onchecked();">�����Һ�
	<input type="radio" name="kind" id="kind" value="price" onclick="onchecked();">����
	<input type="radio" name="kind" id="kind" value="creator" onclick="onchecked();">â����
	<input type="text" id="value" placeholder = "Searching Magic" onkeyup="filter();">
	<input type="button" value="���� ����" onclick="onBuyClicked();">
	<input type="button" value="���ư���" onclick="location.href='main_customer.jsp'">
</div>
<BR>
<%
Statement stmt = null;
Connection conn = null;
ResultSet resultM = null;
ResultSet result = null;
ResultSet resultTrade = null;

String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";
String ms_id = request.getParameter("ms_id");
session.setAttribute("ms_id", ms_id);
try {
	String driver = "org.mariadb.jdbc.Driver";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	String selectMSBelongM = "select Magician_ID from Magician_Belong where MagicStore_ID = '" + ms_id + "';";
	resultM = stmt.executeQuery(selectMSBelongM);
	if(resultM.next()){
		%>
		<table border="1" width="900" id="table">
			<tr align="center">
				<th>���̵�</th>
				<th>�̸�</th>
				<th>����</th>
				<th>Ŭ����</th>
				<th>�Ӽ�</th>
				<th>����</th>
				<th>ȿ����</th>
				<th>�����Һ�</th>
				<th>����</th>
				<th>â����</th>
				<th>���ſ���</th>
			</tr>
		<%
		
		do {
			String selectMagic = "select * from Magic where Creator_ID = '" + resultM.getString(1) + "';";
			result = stmt.executeQuery(selectMagic);
			while(result.next()){
				%>
				<tr align="center">
					<td><%=result.getString(1) %></td>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(3) %></td>
					<td><%=result.getString(4) %></td>
					<td><%=result.getString(5) %></td>
					<td><%=result.getString(6) %></td>
					<td><%=result.getString(7) %></td>
					<td><%=result.getString(8) %></td>
					<td><%=result.getString(9) %></td>
					<td><%=result.getString(10) %></td>
				<%
				String selectTrade = "select * from magic_trade where Customer_ID = '" + keep_id + "' and Magic_ID ='" + result.getString(1) + "';";
				resultTrade = stmt.executeQuery(selectTrade);
				if(resultTrade.next()){
				%>
					<td><input type="checkbox" name="buy" id="<%=result.getString(9) %>" value="<%=result.getString(1) %>" checked disabled></td>
				<%		
				} else {
				%>
					<td><input type="checkbox" name="buy" id="<%=result.getString(9) %>" value="<%=result.getString(1) %>"></td>
				<%		
				}
			}
		}
		while(resultM.next());
		
	} else {
		%>
		<p>�Ǹ� ���� ������ �����ϴ�.
		<%
	}
} catch (SQLException e){
	e.printStackTrace();
} finally {
	try {
		conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
%>
</table>
<form action="search_buy_magic_db.jsp" method="post" id="hideForm">
	<div id="addedFormDiv">
	</div>
</form>
</body>
</html>