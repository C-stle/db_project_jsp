<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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

String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String age = request.getParameter("age");
String address = request.getParameter("address");
String attribute = request.getParameter("attribute");
String money = request.getParameter("money");

String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";


Statement stmt = null;
Connection conn = null;
ResultSet result = null;

try {
	String driver = "org.mariadb.jdbc.Driver";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} 
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	int checkID = 1;
	if(!id.equals(keep_id)){	// 마법사 ID 중복 입력 확인
		String selectCustomerID = "select Customer_ID from Customer;";
		result = stmt.executeQuery(selectCustomerID);
		checkID = 1;
		while(result.next()) {
			if(id.equals(result.getString(1))) {
				checkID = 0;
				break;
			}
		}
	}
	String str = "";
	if(checkID == 1){
		String updateCustomer = "update Customer set Customer_ID = '" + id + 
				"', Customer_Password = AES_ENCRYPT('" + password + "', '" + id + "'), Name = '" + name + 
				"', Age = " + age + ", Address = '" + address + "', Attribute = '" + attribute +
				"', Money = " + money + " where Customer_ID = '" + keep_id + "';";
		stmt.executeUpdate(updateCustomer);
		
		session.setAttribute("id", id);
		str = "수정 완료";
		%><script>alert('<%=str%>');location.replace('main_customer.jsp');</script><%
	} else {
		str = "중복된 고객 ID를 입력하셨습니다.";
		%><script>alert('<%=str%>');location.replace('info_customer.jsp');</script><%
	}
	
} catch(SQLException e){
	
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