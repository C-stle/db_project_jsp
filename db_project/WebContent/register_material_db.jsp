<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS Magician</title>
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
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	
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
	
	String str = "";
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
				checkID = 0;
				break;
			}
		}
		if(checkID == 1) {
			stmt.executeUpdate(insert_material);
			str = "재료 등록 완료";
			%><script>alert('<%=str%>');location.replace('main_magician.jsp');</script><%
		} else {
			str = "재료 등록 실패\\n동일한 ID가 존재합니다.";
			%><script>alert('<%=str%>');location.replace('register_material.jsp');</script><%
		}
	} catch (SQLException e) {
		e.printStackTrace();
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