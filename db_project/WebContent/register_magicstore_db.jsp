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
<title>Insert title here</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
		String dbUser = "root";
		String dbPass = "maria12";
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String representative = request.getParameter("representatvie");
		String m_class = request.getParameter("class");
		
		String selectMagicStoreID = "select MagicStore_ID from magicstore;";
		ResultSet resultID = null;
		
		String insert_magicstore = 
				"insert into magicstore values('" + id + "', AES_ENCRYPT('" + password + "', '" + id + "'), '" + name + "', '" +
				 address + "', '" + representative + "', '" + m_class + "', '10000');";
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
			resultID = stmt.executeQuery(selectMagicStoreID);

			int checkID = 1;
			System.out.println("check1");
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					checkID = 0;
					break;
				}
			}
		
			if(checkID == 1) {
				stmt.executeUpdate(insert_magicstore);
				String str = "회원 가입 완료";
				%><script>alert('<%=str%>');location.replace('login.jsp');</script><%
			} else {
				String str = "회원 가입 실패\\n동일한 ID가 존재합니다.";
				%><script>alert('<%=str%>');location.replace('register_magicstore.jsp');</script><%
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