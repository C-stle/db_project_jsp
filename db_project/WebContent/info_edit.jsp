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

#div_text {
	position:relative;
	height: auto;
	weight:auto;
	left:50px;
	float: left;
	
	margin-right: 3px;
}

#div_text_margin {
weight: auto;
height: 23.5px;
text-align: right;
margin-right: 10px;
}

#div_info {
	position: relative;
	height: auto;
	left: 50px;
}

#div_info_margin {
	height: 23.5px;
}

#div_button {
	position:relative;
	left:70px;
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
	String password = null;
	String name = null;
	String age = null;
	String species = null;
	String country = null;
	String job = null;
	String m_class = null;
	String attribute = null;
	String mana = null;
	String money = null;
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	String query = "select * from magician where magician_id='" + id + "';";
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
		result = stmt.executeQuery(query);
		result.next();
		password = result.getString("Magician_Password");
		name = result.getString("Magician_Name");
		age = result.getString("Age");
		species = result.getString("Species");
		country = result.getString("Country_Of_Origin");
		job = result.getString("Job");
		m_class = result.getString("Magician_Class");
		attribute = result.getString("Magician_Attribute");
		mana = result.getString("Mana");
		money = result.getString("Money");
		
		
		
	} catch (SQLException e) {
		
	} finally {
		
	}
%>
</body>
</html>