<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;

		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
			String dbUser = "root";
			String dbPass = "maria12";
			String selectMagician = "select Magician_ID, Magician_Password, Magician_Class, Magician_Attribute from magician;";
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
			} else if (kind.equals("MagicStore")) {
				result = stmt.executeQuery(selectMagicStore);
			} else {
				result = stmt.executeQuery(selectCustomer);
			}

			int checkID = 1;
			while (result.next()) {
				if (id.equals(result.getString(1))) {	// id check
					if (password.equals(result.getString(2))) {
						session.setAttribute("id", id);
						if (kind.equals("Magician")) {
							session.setAttribute("class",result.getString(3));
							session.setAttribute("attribute", result.getString(4));
							redirect = "main_magician.jsp";
						} else if (kind.equals("MagicStore")) {
							session.setAttribute("ms_class",result.getString(3));
							redirect = "main_magicstore.jsp";
						} else {
							redirect = "main_customer.jsp";
						}
						session.removeAttribute("kind");
						
						%>
						<script>location.replace('<%=redirect%>');</script>
						<%
					} else { // id O, pw X
						session.setAttribute("kind",2);
						checkID = 0;
						%>
						<script>location.replace('login.jsp');</script>
						<%
					}
				}
			}
			if(checkID == 1) {
				session.setAttribute("kind",1);
				%>
				<script>location.replace('login.jsp');</script>
				<%
			}
		} catch (NumberFormatException e) {
		%>
			<h1>�̷�</h1>
			<p>�ùٸ��� ���� �����Դϴ�.
			
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