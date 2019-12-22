<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);

	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	
	String id = keep_id;
	String password = null;
	String name = null;
	String age = null;
	String species = null;
	String country = null;
	String job = null;
	String m_class = null;
	String attribute = null;
	String mana = null;
	String money = null;
	
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
		String query = "select *, AES_DECRYPT(Magician_Password, Magician_ID) from magician where magician_id='" + id + "';";
		result = stmt.executeQuery(query);
		result.next();
		password = result.getString(12);
		name = result.getString(3);
		age = result.getString(4);
		species = result.getString(5);
		country = result.getString(6);
		job = result.getString(7);
		m_class = result.getString(8);
		attribute = result.getString(9);
		mana = result.getString(10);
		money = result.getString(11);
%>
	<h1>���� ����</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=id %> ����
	<form action="info_magician_db.jsp" method ="post">
		<div>
			<div>���̵� : <input name="id" type="text" value='<%=id %>' required=""></div>
			<div>��й�ȣ : <input name="password" type="text" value='<%=password %>' required=""></div>
			<div>�̸� : <input name="name" type="text" value='<%=name %>' required=""></div>
			<div>���� : <input name="age" type="number" min='1' value='<%=age %>' required=""></div>
			<div>���� : <input name="species" type="text" value='<%=species %>' required=""></div>
			<div>����� : <input name="country" type="text" value='<%=country %>' required=""></div>
			<div>���� : <input name="job" type="text" value='<%=job %>' required=""></div>
			<div>Ŭ���� : <input name="class" type="number" min='1' max='9' value='<%=m_class %>' required=""></div>
			<div>�Ӽ� : <input name="attribute" type="text" value='<%=attribute %>' required="" disabled></div>
			<div>������ : <input name="mana" type="number" min='100' value='<%=mana %>' required=""></div>
			<div>������ : <input name="money" type="number" min='0' value='<%=money %>' required=""></div>
		</div>
		<BR>
		<div>
			<input type="submit" value="����">
			<input type="button" value="���ư���" onclick="location.replace('info_magician.jsp')">
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