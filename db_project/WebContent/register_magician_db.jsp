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
		String species = request.getParameter("species");
		String country = request.getParameter("country");
		String job = request.getParameter("job");
		String m_class = request.getParameter("class");
		String attribute = request.getParameter("attribute");
		String mana = request.getParameter("mana");
		String money = request.getParameter("money");
		
		String selectMagicianID = "select Magician_ID from magician;";
		ResultSet resultID = null;
		
		String insert_magician = 
				"insert into magician values('" + id + "', AES_ENCRYPT('" + password + "', '" + id + "'), '" + name + "', '" +
				 age + "', '" + species + "', '" + country + "', '" + job + "', '" + m_class + 
				 "', '" + attribute + "', '" + mana + "', '" + "1000');";
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
			resultID = stmt.executeQuery(selectMagicianID);
			int checkID = 1;
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					
					%>
					<h1>������ ID�� �����մϴ�.</h1>
					<input type="button" value="���ư���" onclick="location.replace('register_magician.jsp')">
					<%
					checkID = 0;
					break;
				}
			}
			if(checkID == 1) {
				stmt.executeUpdate(insert_magician);
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