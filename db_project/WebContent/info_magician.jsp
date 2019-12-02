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

#div_text {
	position:relative;
	height: auto;
	weight:auto;
	left:50px;
	float: left;
	margin-right: 3px;
}

#div_text_margin {
weight: auto;
height: 21px;
text-align: right;
margin-right: 10px;
margin-top:3px;
margin-bottom: 5.8px;
}

#div_input {
	position:relative;
	left:50px;
}
#div_input_margin {
	margin-bottom: 3px;
}
#div_button {
	position:relative;
	left:130px;
	margin-bottom: 10px;
}

#div_name{
position:relative;
left:130px;
}

</style>
</head>
<body>
	
<%
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
	
	String query = "select * from magician where magician_id='" + id + "';";
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
		
		
		
	} catch (SQLException e) {
		
	} finally {
		
	}
%>

	<div>
		<h1>LoDos Magician</h1>
	</div>
	<div id="div_name">
		<p><%=id %> 정보
	</div>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<div id="div_text">
		<div id="div_text_margin"><label>아이디</label></div>
		<div id="div_text_margin"><label>비밀번호</label></div>
		<div id="div_text_margin"><label>이름</label></div>
		<div id="div_text_margin"><label>나이</label></div>
		<div id="div_text_margin"><label>종족</label></div>
		<div id="div_text_margin"><label>출신지</label></div>
		<div id="div_text_margin"><label>직업</label></div>
		<div id="div_text_margin"><label>클래스</label></div>
		<div id="div_text_margin"><label>속성</label></div>
		<div id="div_text_margin"><label>마나량</label></div>
		<div id="div_text_margin"><label>소지금</label></div>
	</div>
	<form action="info_edit.jsp" method ="post">
		<div id="div_input">
			<div id="div_input_margin"><input name="id" type="text" value='<%=id %>'required=""></div>
			<div id="div_input_margin"><input name="password" type="text" value='<%=password %>' required=""></div>
			<div id="div_input_margin"><input name="name" type="text" value='<%=name %>' required=""></div>
			<div id="div_input_margin"><input name="age" type="number" min='1' value='<%=age %>' required=""></div>
			<div id="div_input_margin"><input name="species" type="text" value='<%=species %>' required=""></div>
			<div id="div_input_margin"><input name="country" type="text" value='<%=country %>' required=""></div>
			<div id="div_input_margin"><input name="job" type="text" value='<%=job %>' required=""></div>
			<div id="div_input_margin"><input name="class" type="number" min='1' max='9' value='<%=m_class %>'></div>
			<div id="div_input_margin"><input name="attribute" type="text" value='<%=attribute %>' required=""></div>
			<div id="div_input_margin"><input name="mana" type="number" min='100' value='<%=mana %>'></div>
			<div id="div_input_margin"><input name="money" type="number" min='1' value='<%=money %>'></div>
		</div>
	<BR>
	<div id="div_button">
		<input type="submit" value="수정">
		<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
	</div>
	</form>
</body>
</html>