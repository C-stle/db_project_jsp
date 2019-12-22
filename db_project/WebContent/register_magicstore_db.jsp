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
		String address = request.getParameter("address");
		String representative = request.getParameter("representatvie");
		String m_class = request.getParameter("class");
		
		String selectMagicStoreID = "select MagicStore_ID from magicstore;";
		ResultSet resultID = null;
		
		String insert_magicstore = 
				"insert into magicstore values('" + id + "', AES_ENCRYPT('" + password + "', '" + id + "'), '" + name + "', '" +
				 address + "', '" + representative + "', '" + m_class + "', '10000');";
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
			resultID = stmt.executeQuery(selectMagicStoreID);

			int checkID = 1;
			System.out.println("check1");
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					
					%>
					<h1>동일한 ID가 존재합니다.</h1>
					<input type="button" value="돌아가기" onclick="location.replace('register_magicstore.jsp')">
					<%
					checkID = 0;
					break;
				}
			}
		
			if(checkID == 1) {
				stmt.executeUpdate(insert_magicstore);
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