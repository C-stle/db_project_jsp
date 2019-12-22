<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
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
String m_id = request.getParameter("m_id");

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
	String select = "select * from Magic where Magic_ID = '" + m_id + "';";
	result = stmt.executeQuery(select);
	result.next();
	%>
	<p>마법 상세 정보
	<p>아이디 : <%=m_id %>
	<p>이름 : <%=result.getString(2) %>
	<p>설명 : <%=result.getString(3) %>
	<p>클래스 : <%=result.getString(4) %>
	<p>속성 : <%=result.getString(5) %>
	<p>종류 : <%=result.getString(6) %>
	<p>효과량 : <%=result.getString(7) %>
	<p>마나소비량 : <%=result.getString(8) %>
	<p>가격 : <%=result.getString(9) %>
	<p>창조마법사ID : <%=result.getString(10) %>
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