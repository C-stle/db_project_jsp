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
<title>LoDoS MagicStore</title>
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
		<h1>LoDos Magic Store</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
	</div>
	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	
	String [] material_id = request.getParameterValues("ma_id");
	String [] stringAmount = request.getParameterValues("ma_amount");
	String [] stringPrice = request.getParameterValues("ma_price");
	int [] intAmount;
	int count;
	if(stringAmount != null){
		intAmount = new int[stringAmount.length];
		count = material_id.length;
	} else {
		intAmount = new int[0];
		count = 0;
	}
	Statement stmt = null;
	Connection conn = null;
	ResultSet result = null;
	ResultSet resultMoney = null;
	ResultSet resultAmount = null;
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	String str = "재고 등록 실패";
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
		int money = Integer.parseInt(resultMoney.getString(1));	// 마법 상회 소지금
		
		String selectAmount = "select Material_ID, Amount from material_sell where MagicStore_ID = '" + keep_id + "';";
		resultAmount = stmt.executeQuery(selectAmount);	
		while(resultAmount.next()) {
			for (int i = 0 ; i<count;i++){
				if(material_id[i].equals(resultAmount.getString(1))) {
					int beforeAmount = Integer.parseInt(resultAmount.getString(2));	// 현재 마법 상회가 판매 중인 재료들의 양
					intAmount[i] = Integer.valueOf(stringAmount[i]);				// 재고 등록한 양
					if(beforeAmount < intAmount[i]){								// 재고 등록한 양이 더 많은 경우, 구매가 일어남
						stringAmount[i] = String.valueOf(intAmount[i]);
						intAmount[i] = intAmount[i] - beforeAmount;
					} else if (beforeAmount == intAmount[i]){						// 재고 등록한 양과 판매중인 양이 같은 경우, 구매가 일어나지 않음
						intAmount[i] = 0;
					} else {														// 판매 중인 재료 양보다 적게 입력한 경우, 오류 발생
						str = str + "보유량보다 적은 양을 입력한 재료가 있습니다.\n재료 ID = " + material_id[i] + ", 보유량 = " + beforeAmount + ", 구매량 = " + intAmount[i];
					}
					break;
				}
			}
		}
		int totalPrice = 0;		// 총 구매 가격 계산
		for (int i = 0 ;i <count;i++){
			totalPrice = totalPrice + (intAmount[i] * Integer.parseInt(stringPrice[i]));
		}
		if(totalPrice == 0){
			str = "새롭게 재고 등록한 재료가 없습니다.";
			%><script>alert('<%=str%>');location.replace('search_sell_material.jsp');</script><%
		}
		if(totalPrice > 0 && money >= totalPrice) {		// 소지금 보다 총 구매 가격이 더 큰 경우
			String deleteAll = "delete from Material_Sell where MagicStore_ID = '" + keep_id + "';";
			stmt.executeUpdate(deleteAll);
			
			for (int i = 0; i < count;i++) {
				String insertSell = "insert into Material_Sell values ('" + keep_id + "', '" + material_id[i] + "', " + stringAmount[i] + ");";
				stmt.executeUpdate(insertSell);
			}
			money = money - totalPrice;
			String updateMoneyMS = "update MagicStore set Money = " + String.valueOf(money) + " where MagicStore_ID = '" + keep_id + "';";
			stmt.executeUpdate(updateMoneyMS);
			str = "재료 구매 완료\\n총 구매가격 : " + String.valueOf(totalPrice) + "\\n남은 소지금 : " + String.valueOf(money);
			%><script>alert('<%=str%>');location.replace('main_magicstore.jsp');</script><%
		} else {
			str = str + "\\n소지금이 부족합니다\\n총 구매가격 : " + String.valueOf(totalPrice) + "\\n현재 소지금 : " + String.valueOf(money);
			%><script>alert('<%=str%>');location.replace('search_sell_material.jsp');</script><%
		}
	} catch(SQLException e){
		e.printStackTrace();
	} finally {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>