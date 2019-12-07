<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
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
		%><script>location.replace('login.jsp');</script><%
	}
	String id = (String)session.getAttribute("id");
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
		String query = "select * from magician where magician_id='" + id + "';";
		result = stmt.executeQuery(query);
		result.next();
		password = result.getString("Magician_Password");
		name = result.getString("Magician_Name");
		age = result.getString("Age");
		species = result.getString("Species");
		country = result.getString("Country_Of_Origin");
		job = result.getString("Job");
		m_class = result.getString("Magician_Class");
		attribute = result.getString("Magician_Attribute");
		mana = result.getString("Mana");
		money = result.getString("Money");
		
		query = "select MagicStore_ID from magician_belong where Magician_ID = '" + id + "';";
		result = stmt.executeQuery(query);
		List<String> ms_id = new ArrayList<String>();
		while(result.next()){
			ms_id.add(result.getString("MagicStore_ID"));
		}
		session.setAttribute("ms_count", ms_id.size());
%>
	<h1>LoDos Magician</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=id %> 정보
	<form action="info_magician_pass.jsp" method ="post" name="main">
		<div>
			<div>아이디 : <%=id %></div>
			<div>비밀번호 : <%=password %></div>
			<div>이름 : <%=name %></div>
			<div>나이 : <%=age %></div>
			<div>종족 : <%=species %></div>
			<div>출신지 : <%=country %></div>
			<div>직업 : <%=job %></div>
			<div>클래스 : <%=m_class %></div>
			<div>속성 : <%=attribute %></div>
			<div>마나량 : <%=mana %></div>
			<div>소지금 : <%=money %></div>
			<div id="div_input_ms">
			<%
			if(ms_id.isEmpty()) {
				%><label>소속 상회가 없습니다.</label><%
			} else {
				session.setAttribute("ms_id", ms_id);
				%><div>소속 마법 상회</div><%
				for(int i=0;i<ms_id.size();i++) {
					%>
					<div id="added_<%=(i+1)%>">
						- <%=ms_id.get(i)%>
					</div>
					<%
				}
			}
		%>
		</div>
	</div>
	<BR>
	<div>
		<input type="submit" value="수정">
		<input type="button" value="마법 상회 상세 정보 보기" onclick="location.href='info_magicstore_list.jsp'">
		<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
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