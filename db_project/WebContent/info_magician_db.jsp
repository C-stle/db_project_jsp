<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String species = request.getParameter("species");
	String country = request.getParameter("country");
	String job = request.getParameter("job");
	String m_class = request.getParameter("class");
	String attribute = request.getParameter("attribute");
	String mana = request.getParameter("mana");
	String money = request.getParameter("money");
	String prev_id = (String)session.getAttribute("id");
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	ResultSet result = null;
	Statement stmt = null;
	Connection conn = null;
	ResultSet resultID = null;
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		String selectMagicianID = "select Magician_ID from Magician;";
		resultID = stmt.executeQuery(selectMagicianID);
		int checkID = 1;
		while(resultID.next()) {
			if(id.equals(resultID.getString(1))) {
				
				%>
				<h1>LoDoS Magician</h1>
				<p>중복된 ID 입니다.
				<input type="button" value="돌아가기" onclick="location.href='info_magician.jsp'">
				<%
				checkID = 0;
				break;
			}
		}
		if(checkID == 1) {
			
			String updateMagician = "update magician set Magician_ID = '" + id + 
					"', Magician_Password = '" + password + "', Magician_Name = '" + name + 
					"', Age = '" + age + "', Species = '" + species + "', Country_Of_Origin = '" + country +
					"', Job = '" + job + "', Magician_Class = '" + m_class + "', Magician_Attribute = '" + attribute +
					"', Mana = '" + mana + "', Money = '" + money + "' where Magician_ID = '" + prev_id + "';";
			session.removeAttribute("id");
			session.setAttribute("id",id);
			stmt.executeUpdate(updateMagician);
			%>
			<h1>LoDoS Magician</h1>
			<p>수정 완료
			<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">

			<%
		}
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