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
String ms_id = request.getParameter("ms_id");

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
	String select = "select Company_Name, Address, Representative, License_Class from Magicstore where MagicStore_ID = '" + ms_id + "';";
	result = stmt.executeQuery(select);
	while(result.next()){
		%>
		<p>���� ��ȸ �� ����
		<p>���̵� : <%=ms_id %>
		<p>��ȣ�� : <%=result.getString(1) %>
		<p>�ּ� : <%=result.getString(2) %>
		<p>��ǥ�� : <%=result.getString(3) %>
		<p>�ŷ��㰡 Ŭ���� : <%=result.getString(4) %>
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
<input type="button" value="����" onclick="window.close();">

</body>
</html>