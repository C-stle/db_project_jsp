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
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
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
		
		String selectAmount = "select Material_ID, Amount from material_sell where MagicStore_ID = '" + keep_id + "';";
		resultAmount = stmt.executeQuery(selectAmount);
		while(resultAmount.next()) {
			for (int i = 0 ; i<count;i++){
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
		for (int i = 0 ;i <count;i++){
			totalPrice = totalPrice + (intAmount[i] * Integer.parseInt(stringPrice[i]));
		}
		if(money >= totalPrice) {
			String deleteAll = "delete from Material_Sell where MagicStore_ID = '" + keep_id + "';";
			stmt.executeUpdate(deleteAll);
			
			for (int i = 0; i < count;i++) {
				String insertSell = "insert into Material_Sell values ('" + keep_id + "', '" + material_id[i] + "', " + stringAmount[i] + ");";
				stmt.executeUpdate(insertSell);
			}
			money = money - totalPrice;
			String updateMoneyMS = "update MagicStore set Money = " + String.valueOf(money) + " where MagicStore_ID = '" + keep_id + "';";
			stmt.executeUpdate(updateMoneyMS);
			String str = "��� ���� �Ϸ�\\n�� ���Ű��� : " + String.valueOf(totalPrice) + "\\n���� ������ : " + String.valueOf(money);
			%><script>alert('<%=str%>');location.replace('main_magicstore.jsp');</script><%
		} else {
			String str = "��� ���� ����\\n�������� �����մϴ�\\n�� ���Ű��� : " + String.valueOf(totalPrice) + "\\n���� ������ : " + String.valueOf(money);
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