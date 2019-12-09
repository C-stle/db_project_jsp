<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
var kind = "name";
function filter(){
	var value, radio, table, cell, i;
	var test;
	value = document.getElementById("value").value;
	table = document.getElementById("table");
	if(kind == "name"){
		cell = 1;
	} else if (kind == "class"){
		cell = 3;
	} else if (kind == "type"){
		cell = 5;
	}
	for(i=1;i<=count;i++){
		if(table.rows[i].cells[cell].innerHTML.indexOf(value) > -1){
			table.rows[i].style.display="";
		} else {
			table.rows[i].style.display="none";
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


</script>
</head>
<body>
<div>
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
<div>
	<h1>LoDos Created Magic</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=keep_id %>님이 창조하신 마법 목록
</div>
<div>
	<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();" checked>이름
	<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">클래스
	<input type="radio" name="kind" id="kind" value="type" onclick="onchecked();">종류
	<input type="text" id="value" placeholder = "Searching Magic" onkeyup="filter();">
</div>
<BR>
<script type="text/javascript">
document.getElementById("test").value = kind;

</script>
<%
Statement stmt = null;
Connection conn = null;
ResultSet result = null;
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
	String selectMagic = "select * from Magic where Creator_ID = '" + keep_id + "';";
	result = stmt.executeQuery(selectMagic);
	%>
	<table border="1" width="900" id="table">
		<tr align="center">
			<th>아이디</th>
			<th>이름</th>
			<th>설명</th>
			<th>클래스</th>
			<th>속성</th>
			<th>종류</th>
			<th>효과량</th>
			<th>마나량</th>
			<th>가격</th>
		</tr>
	<%
	while(result.next()){
		String m_id = result.getString(1);
		%>
		<script>count = count + 1;</script>
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
		</tr>
		<%
	}
} catch (SQLException e){
	e.printStackTrace();
}
%>
</table>
</div>
<BR>
<div>
<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
</div>
</body>
</html>