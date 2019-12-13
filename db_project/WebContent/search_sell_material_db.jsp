<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
<body>
<div>
	<h1>LoDos MagicStore</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",0L);

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>location.replace('login.jsp');</script><%
}

String [] material_id = request.getParameterValues("ma_id");
String [] stringAmount = request.getParameterValues("ma_amount");
String [] stringPrice = request.getParameterValues("ma_price");
int [] intAmount = new int[stringAmount.length];

Statement stmt = null;
Connection conn = null;
ResultSet result = null;
ResultSet resultMoney = null;
ResultSet resultAmount = null;
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
	String selectMoney = "select Money from magicstore where MagicStore_ID = '" + keep_id + "';";
	resultMoney = stmt.executeQuery(selectMoney);
	resultMoney.next();
	int money = Integer.parseInt(resultMoney.getString(1));
	
	String selectAmount = "select Material_ID, Inventory_Volume from material_sell where MagicStore_ID = '" + keep_id + "';";
	resultAmount = stmt.executeQuery(selectAmount);
	while(resultAmount.next()) {
		for (int i = 0 ; i<material_id.length;i++){
			if(material_id[i].equals(resultAmount.getString(1))) {
				int beforeAmount = Integer.parseInt(resultAmount.getString(2)); 
				int newAmount = Integer.parseInt(stringAmount[i]);
				if(beforeAmount < newAmount){
					stringAmount[i] = String.valueOf(newAmount);
					intAmount[i] = newAmount - beforeAmount;
				} else if (beforeAmount == newAmount){
					intAmount[i] = 0;
				}
				break;
			}
		}
	}
	
	
	int totalPrice = 0;
	for (int i = 0 ;i <stringAmount.length;i++){
		totalPrice = totalPrice + (intAmount[i] * Integer.parseInt(stringPrice[i]));
	}
	if(money >= totalPrice) {
		String deleteAll = "delete from Material_Sell where MagicStore_ID = '" + keep_id + "';";
		stmt.executeUpdate(deleteAll);
		
		for (int i = 0; i < material_id.length;i++) {
			String insertSell = "insert into Material_Sell values ('" + keep_id + "', '" + material_id[i] + "', " + stringAmount[i] + ");";
			stmt.executeUpdate(insertSell);
		}
		money = money - totalPrice;
		String updateMoneyMS = "update magicstore set Money = " + money + " where MagicStore_ID = '" + keep_id + "';";
		stmt.executeUpdate(updateMoneyMS);
		%>
		<p>재료 구매 완료
		</div>
		<div>
			<input type="button" value="돌아가기" onclick="location.replace('main_magicstore.jsp')"> 
		</div>
		<%
	} else {
		%>
		<p>소지금이 부족합니다.
		</div>
		<div>
			<input type="button" value="돌아가기" onclick="location.replace('search_sell_material.jsp')"> 
		</div>
		<%
	}
	
	
	
} catch(SQLException e){
	e.printStackTrace();
}
%>
</body>
</html>