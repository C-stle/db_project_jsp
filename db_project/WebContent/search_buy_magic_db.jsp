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

function errorAlert(str){
	alert(str);
	location.replace('search_buy_magic.jsp');
}

</script>
</head>
<body>
	<h1>LoDos Customer</h1>
<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",0L);

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
}
String ms_id = (String)session.getAttribute("ms_id");
String [] magic_id = request.getParameterValues("m_id");
String [] magic_price = request.getParameterValues("m_price");
int count;
if(magic_id == null){
	count = 0;
} else {
	count = magic_id.length;
}
Statement stmt = null;
Connection conn = null;
ResultSet result = null;
ResultSet resultM = null;
ResultSet resultMS = null;
ResultSet resultC = null;
String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";

String customer_attribute = "";
int totalPrice = 0;

// 마법 가격

// 구매한 마법을 제외하고 총 가격 계산
// 

try {
	String driver = "org.mariadb.jdbc.Driver";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	String query;
	
	query = "select Magic_ID from magic_trade where Customer_ID = '" + keep_id + "';";
	result = stmt.executeQuery(query);
	
	while(result.next()){
		for (int i=0;i<count;i++){
			if(result.getString(1).equals(magic_id[i])){
				magic_price[i] = "0";
				break;
			}
		}
	}
	

	for(int i=0;i<count;i++){
		totalPrice = totalPrice + Integer.parseInt(magic_price[i]);
	}
	
	query = "select Money, Attribute from Customer where Customer_ID = '" + keep_id + "';";
	resultC = stmt.executeQuery(query);
	int customerMoney = 0;
	
	while(resultC.next()){
		customerMoney = Integer.parseInt(resultC.getString(1));
		customer_attribute = resultC.getString(2);
	}
	if(customerMoney >= totalPrice){
		query = "delete from Magic_Trade where Customer_ID = '" + keep_id + "';";
		stmt.executeUpdate(query);
		for(int i=0;i<count;i++){
			query = "insert into magic_trade values('" + ms_id + "', '" + keep_id + "', '" + magic_id[i] + "');";
			stmt.executeUpdate(query);
			query = "select Creator_ID, Magic_Attribute from Magic where Magic_ID = '" + magic_id[i] + "';";
			result = stmt.executeQuery(query);
			if(result.next()){
				query = "select Money from Magician where Magician_ID = '" + result.getString(1) + "';";
				resultM = stmt.executeQuery(query);
				if(resultM.next()){
					if(result.getString(2).equals(customer_attribute)){
						if(magic_price[i] != "0"){
							int price = (int)((double)Integer.parseInt(magic_price[i]) * 0.9);
							totalPrice = totalPrice - Integer.parseInt(magic_price[i]) + price;
							magic_price[i] = String.valueOf(price);
						}
					}
					int moneyToMS = Integer.parseInt(magic_price[i])/2; // 소수점이 나오는경우 반올림 하게 됨
					int moneyToM = Integer.parseInt(magic_price[i]) - moneyToMS;
					query = "select Money from Magicstore where MagicStore_ID = '" + ms_id + "';";
					resultMS = stmt.executeQuery(query);
					if(resultMS.next()){
						String toMM = String.valueOf(Integer.parseInt(resultM.getString(1)) + moneyToM);
						String toMSM = String.valueOf(Integer.parseInt(resultMS.getString(1)) + moneyToMS);
						query = "update Magician set Money = " + toMM + " where Magician_ID = '" + result.getString(1) + "';";
						stmt.executeUpdate(query);
						query = "update Magicstore set Money = " + toMSM + " where MagicStore_ID = '" + ms_id + "';";
						stmt.executeUpdate(query);
					} else { // 마법상회의 소지금을 가져오지 못한 경우
						String str = "마법 상회의 소지금을 가져오지 못했습니다.";
						%><script>alert('<%=str%>');location.replace('search_buy_magic.jsp');</script><%
						break;
					}
				} else { // 창조 마법사의 소지금을 가져오지 못한 경우
					String str = "창조 마법사의 소지금을 가져오지 못했습니다.";
					%><script>alert('<%=str%>');location.replace('search_buy_magic.jsp');</script><%
					break;
				}
			} else { // 마법을 창조한 마법사를 못 찾은 경우
				String str = "마법을 창조한 마법사를 찾지 못했습니다.";
				%><script>alert('<%=str%>');location.replace('search_buy_magic.jsp');</script><%
				break;
			}
		}
		customerMoney -= totalPrice;
		query = "update Customer set Money = " + String.valueOf(customerMoney) + " where Customer_ID = '" + keep_id + "';";
		stmt.executeUpdate(query);
		
	} else { // 돈이 부족한 경우
		String str = "고객의 소지금이 부족합니다.";
		%><script>alert('<%=str%>');location.replace('search_buy_magic.jsp');</script><%
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
<div>
	<p>마법 구매 완료
	<p>총 가격 : <%=totalPrice %>
</div>
<div id="div_logout">
	<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
</div>
<div>
	<input type="button" value="돌아가기" onclick="location.replace('main_customer.jsp')"> 
</div>
</body>
</body>
</html>