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
				"insert into customer values('" + id + "', '" + password + "', '" + name + "', '" +
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
					
					%>
					<h1>������ ID�� �����մϴ�.</h1>
					<input type="button" value="���ư���" onclick="location.replace('register_customer.jsp')">
					<%
					checkID = 0;
					break;
				}
			}
		
			if(checkID == 1) {
				stmt.executeUpdate(insert_customer);
			%>			
				<div>
					<h1>��� �Ϸ�</h1>
				</div>
				<div>
					<input type="button" value="���ư���" onclick="location.replace('login.jsp')">
				</div>
			<%
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