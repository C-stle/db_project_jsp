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
<h1>LoDos Magician</h1>
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
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	
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
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	
	Statement stmt = null;
	Connection conn = null;
	ResultSet result = null;
	ResultSet resultID = null;
	ResultSet resultMSClass = null;
	
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
		
		int checkID = 1;
		if(!id.equals(keep_id)){	// ������ ID �ߺ� �Է� Ȯ��
			String selectMagicianID = "select Magician_ID from Magician;";
			result = stmt.executeQuery(selectMagicianID);
			checkID = 1;
			while(result.next()) {
				if(id.equals(resultID.getString(1))) {
					checkID = 0;
					break;
				}
			}
		}
		
		int m_class_int = Integer.parseInt(m_class);
		int checkMSClass = 1;
		String selectMS = "select MagicStore_ID from Magician_Belong where Magician_ID = '" + keep_id + "';";
		result = stmt.executeQuery(selectMS);
		while(result.next()){
			String selectMSClass = "select License_Class from MagicStore where MagicStore_ID = '" + result.getString(1) + "';";
			resultMSClass = stmt.executeQuery(selectMSClass);
			resultMSClass.next();
			if(m_class_int > Integer.parseInt(resultMSClass.getString(1))){
				checkMSClass = 0;
				break;
			}
		}
		
		String selectCreateM = "select Magic_Class from Magic where Creator_ID = '" + keep_id + "';";
		result = stmt.executeQuery(selectCreateM);
		int checkCreateM = 1;
		while(result.next()){
			if(m_class_int < result.getInt(1)){
				checkCreateM = 0;
				break;
			}
		}
		
		int check = 1;
		str = "���� ���� ����";
		if(checkID == 0){
			check = 0;
			str = str + "\\n������ ID�� �ߺ��Ǿ����ϴ�.";
		}
		if(checkMSClass == 0){
			check = 0;
			str = str + "\\n�Է��� Ŭ������ �Ҽ� ���� ��ȸ�� �ŷ��㰡 Ŭ������ �ʰ��Ͽ����ϴ�.";
		}
		if(checkCreateM == 0){
			check = 0;
			str = str + "\\nâ���� ���� Ŭ���� ���� ���� Ŭ������ �Է��Ͽ����ϴ�.";
		}
		if(check == 1){
			String updateMagician = "update magician set Magician_ID = '" + id + 
					"', Magician_Password = AES_ENCRYPT('" + password + "', '" + id + "'), Magician_Name = '" + name + 
					"', Age = '" + age + "', Species = '" + species + "', Country_Of_Origin = '" + country +
					"', Job = '" + job + "', Magician_Class = '" + m_class + "', Magician_Attribute = '" + attribute +
					"', Mana = '" + mana + "', Money = '" + money + "' where Magician_ID = '" + keep_id + "';";
			if(!id.equals(keep_id)) {
				session.removeAttribute("id");
				session.setAttribute("id",id);
			}
			session.removeAttribute("class");
			session.setAttribute("class",m_class);
			
			stmt.executeUpdate(updateMagician);
			str = "���� ���� �Ϸ�";
			%><script>alert('<%=str%>');location.replace('info_magician.jsp');</script><%
		} else {
			%><script>alert('<%=str%>');location.replace('info_magician_edit.jsp');</script><%
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