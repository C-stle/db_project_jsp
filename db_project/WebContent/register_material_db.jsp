<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
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
</head>
<body>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
		String dbUser = "root";
		String dbPass = "maria12";
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String origin = request.getParameter("origin");
		String type = request.getParameter("type");
		String price = request.getParameter("price");
		
		String selectMagicianID = "select Material_ID from material;";
		ResultSet resultID = null;
		
		String insert_material = 
				"insert into material values('" + id + "', '" + name + "', '" + origin + "', '" +
				 type + "', '" + price + "');";
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
					<input type="button" value="���ư���" onclick="location.href='register_material.jsp'">
					<%
					checkID = 0;
					break;
				}
			}
			if(checkID == 1) {
				stmt.executeUpdate(insert_material);
			%>			
				<div>
					<h1>��� �Ϸ�</h1>
					<p>SQL ���๮
					<p><%=insert_material %>
				</div>
				<div>
					<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
				</div>
			<%
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
		}
	%>
	
</body>
</html>