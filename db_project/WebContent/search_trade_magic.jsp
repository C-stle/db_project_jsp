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
var count = 0;
var kind = "ms_id";
function filter(){
	var value, radio, table, cell, i;
	value = document.getElementById("value").value;
	table = document.getElementById("table");
	if (kind == "ms_id") {
		cell = 1;
	} else if(kind == "c_id"){
		cell = 2;
	}else if(kind == "m_id"){
		cell = 3;
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
function onMSClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='ms_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=300 width=300 scrollbars=yes');
	form.action ='popup_magicstore.jsp';
	form.target = 'POP';
	form.submit();
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
		<h1>LoDos Customer</h1>
		
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
		<p>창조 마법 거래 내역
		<div>
			<input type="radio" name="kind" id="kind" value="ms_id" onclick="onchecked();" checked>마법 상회 ID
			<input type="radio" name="kind" id="kind" value="c_id" onclick="onchecked();">거래 고객 ID
			<input type="radio" name="kind" id="kind" value="m_id" onclick="onchecked();">구매 마법 ID
			<input type="text" id="value" placeholder = "Searching Trade Magic" onkeyup="filter();">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
		<BR>
		<div style="width:100%; height:200px; overflow:auto">
			<table border="1" width="100%" id="table">
				<tr align="center">
					<th>마법 거래 번호</th>
					<th>마법 상회 ID</th>
					<th>거래 고객 ID</th>
					<th>구매 마법 ID</th>
				</tr>
		<%
		List<String> createMagicID = new ArrayList<String>();
		String selectCreateMID = "select Magic_ID from Magic where Creator_ID = '" + keep_id + "';";
		result = stmt.executeQuery(selectCreateMID);
		if(result.next()){
			do{
				createMagicID.add(result.getString(1));
			} while(result.next());
			
			for(String magic_id : createMagicID){
				String selectTrade = "select * from Magic_Trade where Magic_ID = '" + magic_id + "';";
				resultTrade = stmt.executeQuery(selectTrade);
				
				if(resultTrade.next()){
					%>
					<script>count = count + 1;</script>
					<tr align="center">
						<td><%=resultTrade.getString(1) %></td>
						<td><a href="javascript:void(0);" onclick="onMSClicked('<%=resultTrade.getString(2)%>'); return false;"><%=resultTrade.getString(2) %></a></td>
						<td><a href="javascript:void(0);" onclick="onCClicked('<%=resultTrade.getString(3)%>'); return false;"><%=resultTrade.getString(3) %></a></td>
						<td><a href="javascript:void(0);" onclick="onMClicked('<%=resultTrade.getString(4)%>'); return false;"><%=resultTrade.getString(4) %></a></td>
					</tr>
					<%
				}
			}
		} else {
			String str = "창조 마법 거래 내역이 없습니다.";
			%><script>alert('<%=str%>');location.replace('main_magician.jsp');</script><%
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
	</div>
	<form method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
</body>
</html>