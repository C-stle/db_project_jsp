<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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
	} else if (kind == "address") {
		cell = 2;
	} else if (kind == "representative"){
		cell = 3;
	} else if (kind == "class"){
		cell = 4;
	}
	for(i=1;i<=count;i++){
		if(cell == 4){
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

function onEditClicked(){
	var checkbox, table;
	checkbox = document.getElementsByName("belong");
	
	for(var i = 0;i<checkbox.length;i++){
		if(checkbox[i].checked==true){
			
			var addedFormDiv = document.getElementById("addedFormDiv");
			var str = "";
			str+="<input name='ms_id' type='hidden' value='"+ checkbox[i].value + "'>";
			
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
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",0L);

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
}
%>
<div>
	<h1>LoDos Customer</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=keep_id %> 거래처 조회
</div>
<div>
	<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>아이디
	<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">이름
	<input type="radio" name="kind" id="kind" value="address" onclick="onchecked();">주소
	<input type="radio" name="kind" id="kind" value="representative" onclick="onchecked();">대표자
	<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">거래허가 클래스
	<input type="text" id="value" placeholder = "Searching Magic Store" onkeyup="filter();">
	<input type="button" value="거래처 수정" onclick="onEditClicked();">
<input type="button" value="돌아가기" onclick="location.href='main_customer.jsp'">
</div>
<BR>
<%
Statement stmt = null;
Connection conn = null;
ResultSet resultMS = null;
ResultSet resultAccountMS = null;
String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";


try {
	String driver = "org.mariadb.jdbc.Driver";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	String selectMagician = "select MagicStore_ID, Company_Name, Address, Representative, License_Class from Magicstore";
	int count = 0;
	resultMS = stmt.executeQuery(selectMagician);
	%>
	<table border="1" width="900" id="table">
		<tr align="center">
			<th>아이디</th>
			<th>상호명</th>
			<th>주소</th>
			<th>대표자</th>
			<th>거래허가 클래스</th>
			<th>거래처 여부</th>
		</tr>
	<%
	while(resultMS.next()){
		count++;
		String ms_id = resultMS.getString(1);
		String selectAccountMS = "select * from Customer_Account where MagicStore_ID = '" + ms_id + "'and Customer_ID = '" + keep_id + "';";
		resultAccountMS = stmt.executeQuery(selectAccountMS);
		%>
		<script>count = count + 1;</script>
		<tr align="center">
			<td><%=ms_id %></td>
			<td><%=resultMS.getString(2) %></td>
			<td><%=resultMS.getString(3) %></td>
			<td><%=resultMS.getString(4) %></td>
			<td><%=resultMS.getString(5) %></td>
		<%
		if(resultAccountMS.next()){
		%>
			<td><input type="checkbox" name="belong" value="<%=ms_id %>" checked></td>
		<%		
		} else {
		%>
			<td><input type="checkbox" name="belong" value="<%=ms_id %>"></td>
		<%
		}
		%>
		</tr>
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
<form action="search_magicstore_account_db.jsp" method="post" id="hideForm">
	<div id="addedFormDiv">
	</div>
</form>
<BR>
</body>
</html>