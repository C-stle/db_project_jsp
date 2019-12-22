<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
var countM = 0;
var countMA = 0;
var kindM = "c_id";
var kindMA = "c_id";
function filterM(){
	var value, table, cell, i;
	value = document.getElementById("valueM").value;
	table = document.getElementById("tableM");
	if (kindM == "c_id") {
		cell = 1;
	} else if(kindM == "m_id"){
		cell = 2;
	}

	for(i=1;i<=countM;i++){
		if(table.rows[i].cells[cell].innerHTML.indexOf(value) > -1){
			table.rows[i].style.display="";
		} else {
			table.rows[i].style.display="none";
		}
	}
}
function filterMA(){
	var value, table, cell, i;
	value = document.getElementById("valueMA").value;
	table = document.getElementById("tableMA");
	if (kindMA == "c_id") {
		cell = 1;
	} else if(kindMA == "ma_id"){
		cell = 2;
	} else if(kindMA == "amount"){
		cell = 3;
	}

	for(i=1;i<=countMA;i++){
		if(cell == 3){
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
function oncheckedM(){
	var radio = document.getElementsByName("kindM");
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			kindM = radio[i].value;
		}
	}
}
function oncheckedMA(){
	var radio = document.getElementsByName("kindMA");
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			kindMA = radio[i].value;
		}
	}
}
function onMClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='m_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=450 width=300 scrollbars=yes');
	form.action ='popup_magic.jsp';
	form.target = 'POP';
	form.submit();
}
function onMAClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='ma_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=300 width=300 scrollbars=yes');
	form.action ='popup_material.jsp';
	form.target = 'POP';
	form.submit();
}
function onCClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='c_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=300 width=300 scrollbars=yes');
	form.action ='popup_customer.jsp';
	form.target = 'POP';
	form.submit();
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
		<h1>LoDos MagciStore</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('login.jsp')">
		</div>
	</div>
	<%
	Statement stmt = null;
	Connection conn = null;
	ResultSet resultTrade = null;
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
		
		%>
		<p>마법 거래 내역
		<div>
			<input type="radio" name="kindM" id="kindM" value="c_id" onclick="oncheckedM();" checked>거래 고객 ID
			<input type="radio" name="kindM" id="kindM" value="m_id" onclick="oncheckedM();">구매 마법 ID
			<input type="text" id="valueM" placeholder = "Searching Trade Magic" onkeyup="filterM();">
			<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
		</div>
		<BR>
		<%
		String selectTrade = "select Trade_Number, Customer_ID, Magic_ID from Magic_Trade where MagicStore_ID = '" + keep_id + "';";
		resultTrade = stmt.executeQuery(selectTrade);
		
		if(resultTrade.next()){
			%>
			<div style="width:100%; height:30%; overflow:auto">
				<table border="1" width="600" id="tableM">
					<tr align="center">
						<th>마법 거래 번호</th>
						<th>거래 고객 ID</th>
						<th>구매 마법 ID</th>
					</tr>
				<%
			do{
				%>
				<script>countM = countM + 1;</script>
					<tr align="center">
						<td><%=resultTrade.getString(1) %></td>
						<td><a href="javascript:void(0);" onclick="onCClicked('<%=resultTrade.getString(2)%>'); return false;"><%=resultTrade.getString(2) %></a></td>
						<td><a href="javascript:void(0);" onclick="onMClicked('<%=resultTrade.getString(3)%>'); return false;"><%=resultTrade.getString(3) %></a></td>
						
					</tr>
				</table>
				</div>
				<%
			} while(resultTrade.next());
		} else {
			%><p>마법 거래 내역이 없습니다.<BR><%
		}
		%>
		<BR>
		<p>재료 거래 내역
		<div>
			<input type="radio" name="kindMA" id="kindMA" value="c_id" onclick="oncheckedMA();" checked>거래 고객 ID
			<input type="radio" name="kindMA" id="kindMA" value="ma_id" onclick="oncheckedMA();">구매 재료 ID
			<input type="radio" name="kindMA" id="kindMA" value="amount" onclick="oncheckedMA();">구매량
			<input type="text" id="valueMA" placeholder = "Searching Material" onkeyup="filterMA();">
		</div>
		<BR>
		<%
		selectTrade = "select Trade_Number, Customer_ID, Material_ID, Trade_Amount from Material_Trade where MagicStore_ID = '" + keep_id + "';";
		resultTrade = stmt.executeQuery(selectTrade);
		
		if(resultTrade.next()){
			%>
			<div style="width:100%; height:30%; overflow:auto">
			<table border="1" width="100%" id="tableMA">
				<tr align="center">
					<th>재료 거래 번호</th>
					<th>거래 고객 ID</th>
					<th>구매 재료 ID</th>
					<th>구매량</th>
				</tr>
			<%
			do{
				%>
				<script>countMA = countMA + 1;</script>
				<tr align="center">
					<td><%=resultTrade.getString(1) %></td>
					<td><a href="javascript:void(0);" onclick="onCClicked('<%=resultTrade.getString(2)%>'); return false;"><%=resultTrade.getString(2) %></td>
					<td><a href="javascript:void(0);" onclick="onMAClicked('<%=resultTrade.getString(3)%>'); return false;"><%=resultTrade.getString(3) %></td>
					<td><%=resultTrade.getString(4) %></td>
				</tr>
				<%
			} while(resultTrade.next());
			%>
			</table>
			</div>
			<%
			
		} else {
			%><p>재료 거래 내역이 없습니다.<BR><%
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
	<form method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
</body>
</html>