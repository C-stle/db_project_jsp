<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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

#div_button {
	position:relative;
	left:50px;
	margin-bottom: 10px;
}

#div_name{
position:relative;
left:127px;
}

</style>
</head>
<body>
	
<%
	String id = (String)session.getAttribute("id");
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
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	ResultSet result = null;
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
		
		String update_magician = 
				"update magician set Magician_Password = '" + password + "', Magician_Name = '" + name + 
				"', Age = '" + age + "', Species = '" + species + "', Country_Of_Origin = '" + country +
				"', Job = '" + job + "', Magician_Class = '" + m_class + "', Magician_Attribute = '" + attribute +
				"', Mana = '" + mana + "', Money = '" + money + "' where Magician_ID = '" + id + "';";
				
		stmt.executeQuery(update_magician);
		%>
		<h1>수정 완료</h1>
		<div id="div_button">
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
		</div>
		<%
	} catch (SQLException e) {
		
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