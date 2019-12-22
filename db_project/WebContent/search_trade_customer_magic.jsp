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
	} else if(kind == "m_id"){
		cell = 2;
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
		<p>마법 거래 내역
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('login.jsp')">
		</div>
	</div>
	<div>
		<input type="radio" name="kind" id="kind" value="ms_id" onclick="onchecked();" checked>거래 마법 상회 ID
		<input type="radio" name="kind" id="kind" value="m_id" onclick="onchecked();">구매 마법 ID
		<input type="text" id="value" placeholder = "Searching Trade Magic" onkeyup="filter();">
		<input type="button" value="돌아가기" onclick="location.href='main_customer.jsp'">
	</div>
	<BR>
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
		String selectTrade = "select Trade_Number, MagicStore_ID, Magic_ID from Magic_Trade where Customer_ID = '" + keep_id + "';";
		resultTrade = stmt.executeQuery(selectTrade);
		
		if(resultTrade.next()){
			%>
			<div style="width:100%; height:60%; overflow:auto">
			<table border="1" width="100%" id="table">
				<tr align="center">
					<th>마법 거래 번호</th>
					<th>거래 마법 상회 ID</th>
					<th>구매 마법 ID</th>
					<th>부족한 재료 ID / 필요한 재료량</th>
				</tr>
			<%
			List<String> use_ma_id = new ArrayList<String>();
			List<Integer> use_amount = new ArrayList<Integer>();
			List<String> need_ma_id = new ArrayList<String>();
			List<Integer> need_amount = new ArrayList<Integer>();
			int checkMA = 0;
			String strMA = "";
			do{
				String m_id = resultTrade.getString(3);
				String selectMUse = "select  Material_ID, Amount_Used from Material_Use where Magic_ID = '" + m_id + "';";
				result = stmt.executeQuery(selectMUse);
				while(result.next()){
					use_ma_id.add(result.getString(1));
					use_amount.add(result.getInt(2));
				}
				
				for (int i = 0;i <use_ma_id.size();i++){
					String selectOwnMA = "select SUM(Trade_Amount) from Material_Trade where Customer_ID = '" + keep_id + "' and Material_ID = '" + use_ma_id.get(i) + "' group by Material_ID;";
					result = stmt.executeQuery(selectOwnMA);
					if(!result.next()){
						checkMA = 0;
						strMA = strMA + use_ma_id.get(i) + " / " + String.valueOf(use_amount.get(i));
						need_ma_id.add(use_ma_id.get(i));
						need_amount.add(use_amount.get(i));
					} else if (result.getInt(1) < use_amount.get(i)){
						checkMA = 0;
						strMA = strMA + use_ma_id.get(i) + " / " + String.valueOf(use_amount.get(i) - result.getInt(1));
						need_ma_id.add(use_ma_id.get(i));
						need_amount.add(use_amount.get(i) - result.getInt(1));
					} else {
						checkMA = 1;
					}
					if(i < use_ma_id.size() - 1){
						strMA = strMA + "\\n";
					}
				}
				
				if(checkMA == 1){
					strMA = "X";
				}
				%>
				<script>count = count + 1;</script>
				<tr align="center">
					<td><%=resultTrade.getString(1) %></td>
					<td><a href="javascript:void(0);" onclick="onMSClicked('<%=resultTrade.getString(2)%>'); return false;"><%=resultTrade.getString(2) %></a></td>
					<td><a href="javascript:void(0);" onclick="onMClicked('<%=resultTrade.getString(3)%>'); return false;"><%=resultTrade.getString(3) %></a></td>
					<td><% 
							for(int i = 0 ;i<need_ma_id.size();i++){
								%> <a href="javascript:void(0);" onclick="onMAClicked('<%=need_ma_id.get(i)%>'); return false;"><%=need_ma_id.get(i) %></a> / <%=need_amount.get(i)%><BR><%
								if(i < need_ma_id.size()-1){
									%><BR><%
								}
							}
					%> </td>
				</tr>
				<%
				
				use_ma_id.clear();
				use_amount.clear();
				strMA = "";
			} while(resultTrade.next());
		} else {
			String str = "마법 거래 내역이 없습니다.";
			%><script>alert('<%=str%>');location.replace('main_customer.jsp');</script><%
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