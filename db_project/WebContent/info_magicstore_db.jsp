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
<title>Insert title here</title>
</head>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
</head>
<body>
<h1>LoDos Magic Store</h1>
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
String address = request.getParameter("address");
String representative = request.getParameter("representative");
String m_class = request.getParameter("class");
String money = request.getParameter("money");

String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
String dbUser = "root";
String dbPass = "maria12";

Statement stmt = null;
Connection conn = null;
ResultSet result = null;
ResultSet resultM = null;
ResultSet resultClass = null;
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
	if(!keep_id.equals(id)){
		String selectMS = "select MagicStore_ID from MagicStore where MagicStore_ID = '" + id + "';";
		result = stmt.executeQuery(selectMS);
		if(result.next()){
			checkID  = 0;
		}
	}
	int ms_class = Integer.parseInt(m_class);
	String selectM = "select Magician_ID from Magician_Belong where MagicStore_ID = '" + keep_id + "';";
	resultM = stmt.executeQuery(selectM);
	int checkClass = 1;
	while(resultM.next()){
		String m_id = resultM.getString(1);
		String selectClass = "select Magician_Class from Magician where Magician_ID = '" + m_id + "';";
		resultClass = stmt.executeQuery(selectClass);
		resultClass.next();
		checkClass = Integer.parseInt(resultClass.getString(1));
		if(ms_class < checkClass){
			checkClass = 0;
			break;
		}
	}
	
	if(checkID == 1){
		if(checkClass > 0) {
			String updateMS = "update magicstore set MagicStore_ID = '" + id + "', MagicStore_Password = AES_ENCRYPT('" + password + "', '" + id + "'), " + 
							"Company_Name = '" + name + "', Address = '" + address + "', Representative = '" + representative +
							"', License_Class = '" + m_class + "', Money = '" + money + "' where MagicStore_ID = '" + keep_id + "';";
			stmt.executeUpdate(updateMS);
			if(!keep_id.equals(id)){
				session.removeAttribute("id");
				session.setAttribute("id",id);
			}
			session.removeAttribute("ms_class");
			session.setAttribute("ms_class",m_class);
			%>
			<p>���� ���� �Ϸ�
			<%
		} else {
			%>
			<p>���� ��ȸ �Ҽ� �����纸�� ���� Ŭ������ ������ �� �����ϴ�.
			<p>�Ҽ� �����縦 �Ҽ� �����ϰ� �ٽ� �õ��ϼ���.
			<%
		}
	} else {	// �ߺ��� ���̵� �Է��� ���
		%>
		<p>�ߺ��� ���̵� �Է��ϼ̽��ϴ�.
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
<div>
	<input type="button" value="���ư���" onclick="location.replace('main_magicstore.jsp')">
</div>
</body>
</html>