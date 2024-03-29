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
<title>LoDoS Customer</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
</head>
<body>
	<div>
		<h1>LoDos Customer</h1>
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
	int [] sellAmount;
	int count =0;
	if(stringAmount != null){
		intAmount = new int[stringAmount.length];
		sellAmount = new int[stringAmount.length];
		count = material_id.length;
	} else {
		intAmount = new int[0];
		sellAmount = new int[0];
	}
	String ms_id = (String)session.getAttribute("ms_id");
	
	if(count != 0){
		Statement stmt = null;
		Connection conn = null;
		ResultSet result = null;
		ResultSet resultMoney = null;
		ResultSet resultAmount = null;
		
		ResultSet resultTrade = null;
		String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
		String dbUser = "root";
		String dbPass = "maria12";
		
		String str = "재료 구매 실패";
		
		try {
			String driver = "org.mariadb.jdbc.Driver";
			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			String selectCMoney = "select Money from Customer where Customer_ID = '" + keep_id + "';";
			resultMoney = stmt.executeQuery(selectCMoney);
			resultMoney.next();
			int customerMoney = resultMoney.getInt(1);
			String selectMSMoney = "select Money from MagicStore where MagicStore_ID = '" + ms_id + "';";
			resultMoney = stmt.executeQuery(selectMSMoney);
			resultMoney.next();
			int msMoney = resultMoney.getInt(1);
			
			String selectMASMT = "select A.Material_ID, A.Amount, SUM(B.Trade_Amount) as Trade_Amount "
					+ "from Material_Sell as A left outer join Material_Trade as B on A.Material_ID = B.Material_ID "
					+ "where A.MagicStore_ID = '" + ms_id + "' group by A.Material_ID;";
			resultTrade = stmt.executeQuery(selectMASMT);
			// 판매 재료 중 구매가 일어난 경우, 값이 넘어오게 됨, 원래 보유량을 체크해서 보유량을 제외하고 구매 발생
			int checkBuy = 0;
			int beforeAmount = 0;
			while(resultTrade.next()){
				for(int i = 0 ; i<count;i++){
					if(material_id[i].equals(resultTrade.getString(1))){ // 넘어온 데이터의 재료 id 와 MS가 판매중인 재료 id가 같은 경우
						beforeAmount = resultTrade.getInt(3);
						intAmount[i] = Integer.valueOf(stringAmount[i]);
						if(beforeAmount == intAmount[i]){ // 보유량과 구매량이 같은 경우
							intAmount[i] = 0;
						} else if (beforeAmount > intAmount[i]){
							str = str + "\\n보유량보다 적은 양을 입력한 재료가 있습니다.\\n재료 ID = " + material_id[i] +", 보유량 = " + beforeAmount + ", 구매량 = " + intAmount[i];
						} else if (beforeAmount < intAmount[i]) {
							intAmount[i] = intAmount[i] - beforeAmount;
							sellAmount[i] = resultTrade.getInt(2);
							if(intAmount[i] > sellAmount[i]){
								str = str + "\\n판매량보다 많은 양을 입력한 재료가 있습니다.\\n재료 ID = " + material_id[i] +", 판매량 = " + resultTrade.getInt(2) + ", 구매량 = " + intAmount[i];
							} else {
								checkBuy++;
							}
						}
						break;
					}
				}
			}
			int totalPrice = 0;
			for (int i = 0 ;i <count;i++){
				totalPrice = totalPrice + (intAmount[i] * Integer.parseInt(stringPrice[i]));
			}
			int check = 1;
			
			if(customerMoney < totalPrice){
				check = 0;
				str = str + "\\n" + keep_id + "님의 소지금이 부족합니다.\\n총 구매 금액 = " + String.valueOf(totalPrice) + "\\n현재 소지금 = " + String.valueOf(customerMoney);
			}
			if(checkBuy == 0){
				check = 0;
			}
			if(totalPrice == 0){
				check = 0;
				str = "재료 구매 실패\\n구매한 재료가 없습니다.";
			}
			if(check == 1){
				for(int i = 0; i<count;i++){
					String insertTrade = "";
					String updateMASell = "";
					
					if(sellAmount[i] > intAmount[i]) {
						sellAmount[i] = sellAmount[i] - intAmount[i];
						updateMASell = "update Material_Sell set Amount = " + sellAmount[i] + " where MagicStore_ID = '" + ms_id + "' and Material_ID = '" + material_id[i] + "';";
					} else if (sellAmount[i] == intAmount[i]){
						updateMASell = "delete from Material_Sell where MagicStore_ID = '" + ms_id + "' and Material_ID = '" + material_id[i] + "';";
					}
					stmt.executeUpdate(updateMASell);
					insertTrade = "insert into material_trade(MagicStore_ID, Customer_ID, Material_ID, Trade_Amount) values('" + ms_id + "', '" + keep_id + "', '" + material_id[i] + "', " + String.valueOf(intAmount[i]) +");";
					stmt.executeUpdate(insertTrade);
				}
				msMoney += totalPrice;
				customerMoney -= totalPrice;
				String updateMoney = "update MagicStore set Money = " + String.valueOf(msMoney) + " where MagicStore_ID = '" + ms_id + "';";
				stmt.executeUpdate(updateMoney);
				updateMoney = "update Customer set Money = " + String.valueOf(customerMoney) + " where Customer_ID = '" + keep_id + "';";
				stmt.executeUpdate(updateMoney);
				str = "재료 구매 완료\\n구매 금액 = " + String.valueOf(totalPrice) + "\\n남은 소지금 = " + String.valueOf(customerMoney);
				%><script>alert('<%=str%>');location.replace('info_customer_account.jsp');</script><%
			} else {
				%><script>alert('<%=str%>');location.replace('info_customer_account.jsp');</script><%
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
	} else {
		%><script>alert('잘못 입력하셨거나 구매한 재료가 없습니다.\n거래처 선택 화면으로 돌아갑니다.');location.replace('info_customer_account.jsp');</script><%
	}
	%>
</body>
</html>