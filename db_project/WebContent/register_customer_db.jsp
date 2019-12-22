<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
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
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String address = request.getParameter("address");
	String attribute = request.getParameter("attribute");
	
	String selectCustomerID = "select Customer_ID from customer;";
	ResultSet resultID = null;
	
	String insert_customer = 
			"insert into customer values('" + id + "', AES_ENCRYPT('" + password + "', '" + id + "'), '" + name + "', '" +
			 age + "', '" + address + "', '" + attribute + "', '1000');";
	Statement stmt = null;
	Connection conn = null;
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		resultID = stmt.executeQuery(selectCustomerID);

		int checkID = 1;
		
		while(resultID.next()) {
			if(id.equals(resultID.getString(1))) {
				
				String str = "동일한 ID가 존재합니다.";
				%><script>alert('<%=str%>');location.replace('register_customer.jsp');</script><%
				checkID = 0;
				break;
			}
		}
	
		if(checkID == 1) {
			stmt.executeUpdate(insert_customer);
			String str = "고객 회원 가입 완료";
			%><script>alert('<%=str%>');location.replace('login.jsp');</script><%
		}
	} catch (SQLException e) {
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