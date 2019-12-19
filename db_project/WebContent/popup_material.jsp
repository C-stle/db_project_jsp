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
</head>
<body>
<h1>LoDos</h1>
<%
String ma_id = request.getParameter("ma_id");

Statement stmt = null;
Connection conn = null;
ResultSet result = null;
String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";

try {
	String driver = "org.mariadb.jdbc.Driver";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	String select = "select Name, Country_Of_Origin, material_Type, Price from Material where Material_ID = '" + ma_id + "';";
	result = stmt.executeQuery(select);
	while(result.next()){
		%>
		<p>재료 상세 정보
		<p>아이디 : <%=ma_id %>
		<p>이름 : <%=result.getString(1) %>
		<p>원산지 : <%=result.getString(2) %>
		<p>종류 : <%=result.getString(3) %>
		<p>가격 : <%=result.getString(4) %>
		<BR>
		<%
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
<BR>
<input type="button" value="종료" onclick="window.close();">

</body>
</html>