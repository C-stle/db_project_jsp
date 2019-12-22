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
	%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
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
			<p>정보 수정 완료
			<%
		} else {
			%>
			<p>마법 상회 소속 마법사보다 낮은 클래스로 수정할 수 없습니다.
			<p>소속 마법사를 소속 해제하고 다시 시도하세요.
			<%
		}
	} else {	// 중복된 아이디를 입력한 경우
		%>
		<p>중복된 아이디를 입력하셨습니다.
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
	<input type="button" value="돌아가기" onclick="location.replace('main_magicstore.jsp')">
</div>
</body>
</html>