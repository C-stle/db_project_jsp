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
<title>LoDoS MagicStore</title>
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
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	
	String [] magician_id = request.getParameterValues("m_id");
	
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
		String deleteAll = "delete from Magician_Belong where MagicStore_ID = '" + keep_id + "';";
		stmt.executeUpdate(deleteAll);
		if(magician_id!=null){
			for (String m_id : magician_id){
				String insertBelong = "insert into Magician_Belong values ('" + m_id + "', '" + keep_id + "');";
				stmt.executeUpdate(insertBelong);
			}
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
	<script>alert('소속 수정 완료');location.replace('main_magicstore.jsp');</script>

</body>
</html>