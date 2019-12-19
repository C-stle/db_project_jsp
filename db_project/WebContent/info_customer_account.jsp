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
%>
<div>
	<h1>LoDos Customer</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=keep_id %> 거래처 선택
</div>
<form action="search_buy_magic.jsp" method="post">
<%
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
	String select = "select MagicStore_ID from Customer_Account where Customer_ID = '" + keep_id + "';";
	result = stmt.executeQuery(select);
	
	while(result.next()){
		%>
		<div>
			<input type="radio" name="ms_id" value="<%=result.getString(1) %>"> <%=result.getString(1) %>
		</div>
		<%
	}
	
} catch(SQLException e){
	
} finally {
	try {
		conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
%>
<BR>
<div>
	<input type="submit" value="판매 마법 보기">
	<input type="button" value="돌아가기" onclick="location.replace('main_customer.jsp');">
</div>
</form>
</body>
</html>