<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
String c_id = request.getParameter("c_id");

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
	String select = "select * from Customer where Customer_ID = '" + c_id + "';";
	result = stmt.executeQuery(select);
	result.next();
	%>
	<p>고객 상세 정보
	<p>아이디 : <%=c_id %>
	<p>이름 : <%=result.getString(2) %>
	<p>나이 : <%=result.getString(3) %>
	<p>주소 : <%=result.getString(4) %>
	<p>속성 : <%=result.getString(5) %>
	<BR>
	<%
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