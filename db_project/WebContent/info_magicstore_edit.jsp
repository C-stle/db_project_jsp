<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
		
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	
	Statement stmt = null;
	Connection conn = null;
	ResultSet result = null;
	
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String query = "select *, AES_DECRYPT(MagicStore_Password, MagicStore_ID) from magicstore where magicstore_id='" + keep_id + "';";
		result = stmt.executeQuery(query);
		result.next();
		String password = result.getString(8);
		String name = result.getString(3);
		String address = result.getString(4);
		String representative = result.getString(5);
		String ms_class = result.getString(6);
		String money = result.getString(7);
		%>
		<h1>마법상회 정보 수정</h1>	
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<form action="info_magicstore_db.jsp" method="post">
			<div>
				<p><%=keep_id %> 정보 
				<input type="submit" value="수정 완료">
				<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
			</div>
			<div>
				<div>아이디 : <input type="text" name="id" value="<%=keep_id %>" required></div>
				<div>비밀번호 : <input type="text" name="password" value="<%=password %>" required></div>
				<div>회사 이름 : <input type="text" name="name" value="<%=name %>" required></div>
				<div>주소 : <input type="text" name="address" value="<%=address %>" required></div>
				<div>대표자 : <input type="text" name="representative" value="<%=representative %>" required></div>
				<div>거래허가 클래스 : <input type="number" name="class" value="<%=ms_class %>" min='1' max='9' required></div>
				<div>소지금 : <input type="number" name="money" value="<%=money %>" min='0' required></div>
			</div>
		</form>
		<%
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