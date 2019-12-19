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
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	
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
					<h1>동일한 ID가 존재합니다.</h1>
					<input type="button" value="돌아가기" onclick="location.replace('register_customer.jsp')">
					<%
					checkID = 0;
					break;
				}
			}
		
			if(checkID == 1) {
				stmt.executeUpdate(insert_customer);
			%>			
				<div>
					<h1>등록 완료</h1>
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.replace('login.jsp')">
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