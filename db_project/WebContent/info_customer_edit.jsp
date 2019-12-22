<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
		String query = "select * from Customer where Customer_id='" + keep_id + "';";
		result = stmt.executeQuery(query);
		result.next();
		
%>
	<h1>LoDos Customer</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=keep_id %> 정보
	<form action="info_customer_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" value='<%=result.getString(1) %>' required></div>
			<div>비밀번호 : <input name="password" type="text" value='<%=result.getString(2) %>' required></div>
			<div>이름 : <input name="name" type="text" value='<%=result.getString(3) %>' required></div>
			<div>나이 : <input name="age" type="number" min='1' value='<%=result.getString(4) %>' required></div>
			<div>주소 : <input name="address" type="text" value='<%=result.getString(5) %>' required></div>
			<div>속성 : <input name="attribute" type="text" value='<%=result.getString(6) %>' required></div>
			<div>소지금 : <input name="money" type="number" value='<%=result.getString(7) %>' required></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="수정">
			<input type="button" value="돌아가기" onclick="location.replace('info_customer.jsp')">
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
	</div>
	
</body>
</html>