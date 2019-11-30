<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;

		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
			String dbUser = "root";
			String dbPass = "maria12";
			String selectMagician = "select Magician_ID, Magician_Password, Magician_Class from magician;";
			String selectMagicStore = "select MagicStore_ID, MagicStore_Password, License_Class from magicstore;";
			String selectCustomer = "select Customer_ID, Customer_Password from customer;";

			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();

			String redirect = null;
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String kind = request.getParameter("kind");

			if (kind.equals("Magician")) {
				result = stmt.executeQuery(selectMagician);
			} else if (kind.equals("MagciStore")) {
				result = stmt.executeQuery(selectMagicStore);
			} else {
				result = stmt.executeQuery(selectCustomer);
			}

			int checkID = 1;
			while (result.next()) {
				if (id.equals(result.getString(1))) {
					if (password.equals(result.getString(2))) {
						session.setAttribute("id", id);
						checkID = 0;
						if (kind.equals("Magician")) {
							session.setAttribute("class",result.getString(3));
							redirect = "main_magician.jsp";
						} else if (kind.equals("MagciStore")) {
							session.setAttribute("class",result.getString(3));
							redirect = "main_magicstore.jsp";
						} else {
							redirect = "main_customer.jsp";
						}
						response.sendRedirect(redirect);
					} else { // id O, pw X
	%>
	<div>
		<h1>비밀 번호가 틀렸습니다.</h1>
		<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
	</div>
	<%
		checkID = 0;
						break;
					}
				}
			}
			if (checkID == 1) {
	%>
	<div>
		<h1>존재하지 않는 ID입니다.</h1>
		<input type="button" value="돌아가기" onclick="location.href='login.jsp'">
	</div>
	<%
			}
		} catch (NumberFormatException e) {
		%>
			<h1>이런</h1>
			<p>올바르지 않은 정보입니다.
			
		<%
		} catch (Exception e) {
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