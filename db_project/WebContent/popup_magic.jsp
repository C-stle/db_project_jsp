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
	<p>���� �� ����
	<p>���̵� : <%=m_id %>
	<p>�̸� : <%=result.getString(2) %>
	<p>���� : <%=result.getString(3) %>
	<p>Ŭ���� : <%=result.getString(4) %>
	<p>�Ӽ� : <%=result.getString(5) %>
	<p>���� : <%=result.getString(6) %>
	<p>ȿ���� : <%=result.getString(7) %>
	<p>�����Һ� : <%=result.getString(8) %>
	<p>���� : <%=result.getString(9) %>
	<p>â��������ID : <%=result.getString(10) %>
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
<input type="button" value="����" onclick="window.close();">

</body>
</html>