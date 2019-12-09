<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Magic Store Information</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
</head>
<body>

<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires",0L);
if(request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control","no-store");

String keep_id = (String)session.getAttribute("id");
if(keep_id == null || keep_id.equals("")) {
	%><script>location.replace('login.jsp');</script><%
}
String idToMsID = (String)session.getAttribute("ms_id");
String idToSession = (String)session.getAttribute("id");

String id;
if(idToMsID==null) {
	id = idToSession;
} else {
	id = idToMsID;
}

String password = null;
String name = null;
String address = null;
String representative = null;
String license_class = null;
String money = null;


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
	String query = "select * from magicstore where magicstore_id='" + id + "';";
	result = stmt.executeQuery(query);
	result.next();
	password = result.getString("MagicStore_Password");
	name = result.getString("Company_Name");
	address = result.getString("Address");
	representative = result.getString("Representative");
	license_class = result.getString("License_Class");
	money = result.getString("Money");
		
%>
<h1>LoDos Magic Store</h1>	
<div id="div_logout">
	<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
</div>
<p><%=id %> ����
<form action="info_magicstore_modified.jsp" method ="post" name="main">
	<div>
		<div>���̵� : <%=id %></div>
		<div>��й�ȣ : <%=password %></div>
		<div>ȸ�� �̸� : <%=name %></div>
		<div>�ּ� : <%=address %></div>
		<div>��ǥ�� : <%=representative %></div>
		<div>�ŷ��㰡 Ŭ���� : <%=license_class %></div>
		<div>������ : <%=money %></div>
	</div>
		
	<BR>
	<div>
		<input type="submit" value="����">
		<%
		if(idToMsID==null) {
			%>
			<input type="button" value="���ư���" onclick="location.href='main_magicstore.jsp'">
			<%
		} else {
			%>
			<input type="button" value="���ư���" onclick="location.href='info_magician.jsp'">
			<%
		}
		
		%>
	</div>
</form>
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