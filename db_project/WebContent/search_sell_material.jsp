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
	} else if (kind == "home") {
		cell = 2;
	} else if (kind == "type"){
		cell = 3;
	} else if (kind == "price"){
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

function onBuyClicked(){
	var amount, table;
	amount = document.getElementsByName("amount");
	table = document.getElementById("table");
	for(var i = 0;i<amount.length;i++){
		if(amount[i].value=="0" || amount[i].value=="" || amount[i].value == null){
			
		} else {
			var addedFormDiv = document.getElementById("addedFormDiv");
			var str = "";
			str+="<input name='ma_id' type='hidden' value='"+ amount[i].id + "'>";
			str+="<input name='ma_amount' type='hidden' value='" + amount[i].value + "'>";
			str+="<input name='ma_price' type='hidden' value='" + table.rows[i+1].cells[4].innerHTML + "'>";
			var addedDiv = document.createElement("div");
			addedDiv.id = "added";
			addedDiv.innerHTML = str;
			addedFormDiv.appendChild(addedDiv);
		}
	}
	
	document.getElementById("hideForm").submit();
}

</script>
</head>
<body>
<%
// 전체 마법사 목록 표출, 선택 (허가 클래스 조건 체크)
// 마법사 목록에 대한 검색기능 제공
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",0L);
String a;
String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>location.replace('login.jsp');</script><%
}
%>
<div>
	<h1>LoDos MagicStore</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=keep_id %> 보유 재료 조회
</div>
<div>
	<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>아이디
	<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">이름
	<input type="radio" name="kind" id="kind" value="home" onclick="onchecked();">원산지
	<input type="radio" name="kind" id="kind" value="type" onclick="onchecked();">종류
	<input type="radio" name="kind" id="kind" value="price" onclick="onchecked();">가격
	<input type="text" id="value" placeholder = "Searching Material" onkeyup="filter();">
	<input type="button" value="재료 구매" onclick="onBuyClicked();">
	<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
</div>
<BR>
<%
Statement stmt = null;
Connection conn = null;
ResultSet resultMaterial = null;
ResultSet resultSellMT = null;
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
	String selectMaterial = "select * from Material";
	resultMaterial = stmt.executeQuery(selectMaterial);
	%>
	<table border="1" width="900" id="table">
		<tr align="center">
			<th>아이디</th>
			<th>이름</th>
			<th>원산지</th>
			<th>종류</th>
			<th>가격</th>
			<th>보유량</th>
		</tr>
	<%
	while(resultMaterial.next()){
		String ma_id = resultMaterial.getString(1);
		String selectSellMT = "select Inventory_Volume from Material_Sell where MagicStore_ID = '" + keep_id + "' and Material_ID = '" + ma_id + "';";
		resultSellMT = stmt.executeQuery(selectSellMT);
		%>
		<script>count = count + 1;</script>
		<tr align="center">
			<td><%=ma_id %></td>
			<td><%=resultMaterial.getString(2) %></td>
			<td><%=resultMaterial.getString(3) %></td>
			<td><%=resultMaterial.getString(4) %></td>
			<td><%=resultMaterial.getString(5) %></td>
		<%
		
		if(resultSellMT.next()){
			%>
			<td><input type="number" name="amount" id="<%=ma_id %>" value="<%=resultSellMT.getString(1) %>" min="<%=resultSellMT.getString(1) %>"></td>
			<%
		} else {
			%>
			 <td><input type="number" name="amount" id="<%=ma_id %>" value="0" min="0"></td>
			<%
		}
		%>
		</tr>
		<%
	}
} catch (SQLException e){
	e.printStackTrace();
}
%>
</table>
<form action="search_sell_material_db.jsp" method="post" id="hideForm">
	<div id="addedFormDiv">
	</div>
</form>
</body>
</html>