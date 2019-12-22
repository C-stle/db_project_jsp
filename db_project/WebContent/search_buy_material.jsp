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
	} else if (kind == "origin") {
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
		<p>판매 재료 조회
	</div>
	<div>
		<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>아이디
		<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">이름
		<input type="radio" name="kind" id="kind" value="origin" onclick="onchecked();">원산지
		<input type="radio" name="kind" id="kind" value="type" onclick="onchecked();">종류
		<input type="radio" name="kind" id="kind" value="price" onclick="onchecked();">가격
		<input type="text" id="value" placeholder = "Searching Material" onkeyup="filter();">
		<input type="button" value="재료 구매" onclick="onBuyClicked();">
		<input type="button" value="돌아가기" onclick="location.href='info_customer_account.jsp'">
	</div>
	<BR>
	<%
	Statement stmt = null;
	Connection conn = null;
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
		
		String selectMASMT = "select A.Material_ID, A.Amount, SUM(B.Trade_Amount) as Trade_Amount "
							+ "from Material_Sell as A left outer join Material_Trade as B on A.Material_ID = B.Material_ID "
							+ "where A.MagicStore_ID = '" + ms_id + "' group by A.Material_ID;";
		resultTrade = stmt.executeQuery(selectMASMT);
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
		if(resultTrade.next()){
			do {
				String selectMA = "select * from Material where Material_ID = '" + resultTrade.getString(1) + "';";
				result = stmt.executeQuery(selectMA);
				result.next();
				%>
				<script>count = count + 1;</script>
				<tr align="center">
					<td><%=result.getString(1) %></td>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(3) %></td>
					<td><%=result.getString(4) %></td>
					<td><%=result.getString(5) %></td>
				<%
				if(resultTrade.getString(3) == null){
				%>
					<td><input type="number" name="amount" id="<%=result.getString(1) %>" value="0" min='0' max='<%=resultTrade.getString(2)%>' required></td>
				<%	
				} else {
				%>
					<td><input type="number" name="amount" id="<%=result.getString(1) %>" value="<%=resultTrade.getString(3)%>" min='<%=resultTrade.getString(3)%>' max = '<%=resultTrade.getString(2)%>' required></td>
				<%	
				}
				%>
				</tr>
				<%
				
			} while(resultTrade.next());
			
		} else {
			%>
			<p>판매 중인 재료가 없습니다.
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
	<form action="search_buy_material_db.jsp" method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
</body>
</html>