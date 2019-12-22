<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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
<script type="text/javascript">
var count = 0;
var kind = "id";
function filter(){
	var value, radio, table, cell, i;
	value = document.getElementById("value").value;
	table = document.getElementById("table");
	if (kind == "id") {
		cell = 0;
	} else if(kind == "name"){
		cell = 1;
	} else if (kind == "age") {
		cell = 2;
	} else if (kind == "species"){
		cell = 3;
	} else if (kind == "home"){
		cell = 4;
	} else if (kind == "job"){
		cell = 5;
	} else if (kind == "class"){
		cell = 6;
	} else if (kind == "attribute"){
		cell = 7;
	} else if (kind == "mana"){
		cell = 8;
	}
	for(i=1;i<=count;i++){
		if(cell == 2 || cell == 6 || cell == 8){
			if(value == ""){
				table.rows[i].style.display="";
			} else {
				if(table.rows[i].cells[cell].innerHTML == value){
					table.rows[i].style.display="";
				} else {
					table.rows[i].style.display="none";
				}
			}
		} else {
			if(table.rows[i].cells[cell].innerHTML.indexOf(value) > -1){
				table.rows[i].style.display="";
			} else {
				table.rows[i].style.display="none";
			}
		}
	}
}

function onchecked(){
	var radio = document.getElementsByName("kind");
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			kind = radio[i].value;
		}
	}
}

function onEditClicked(){
	var checkbox, table;
	checkbox = document.getElementsByName("belong");
	
	for(var i = 0;i<checkbox.length;i++){
		if(checkbox[i].checked==true){
			
			var addedFormDiv = document.getElementById("addedFormDiv");
			var str = "";
			str+="<input name='m_id' type='hidden' value='"+ checkbox[i].value + "'>";
			
			var addedDiv = document.createElement("div");
			addedDiv.id = "added";
			addedDiv.innerHTML  = str;
			addedFormDiv.appendChild(addedDiv);
		}
	}
	
	document.getElementById("hideForm").submit();
}

</script>
</head>
<body>
	<%
	// 전체 마법사 목록 표출, 선택 (허가 클래스 조건 체크)
	// 마법사 목록에 대한 검색기능 제공
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	int ms_class = Integer.parseInt((String)session.getAttribute("ms_class"));
	%>
	<div>
		<h1>LoDos Magic Store</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<p><%=keep_id %> 소속 마법사 조회
	</div>
	<div>
		<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>아이디
		<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">이름
		<input type="radio" name="kind" id="kind" value="age" onclick="onchecked();">나이
		<input type="radio" name="kind" id="kind" value="species" onclick="onchecked();">종족
		<input type="radio" name="kind" id="kind" value="home" onclick="onchecked();">출신지
		<input type="radio" name="kind" id="kind" value="job" onclick="onchecked();">직업
		<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">클래스
		<input type="radio" name="kind" id="kind" value="attribute" onclick="onchecked();">속성
		<input type="radio" name="kind" id="kind" value="mana" onclick="onchecked();">마나량
		<input type="text" id="value" placeholder = "Searching Magician" onkeyup="filter();">
		<input type="button" value="소속 수정" onclick="onEditClicked();">
	<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
	</div>
	<BR>
	<%
	Statement stmt = null;
	Connection conn = null;
	ResultSet resultMagician = null;
	ResultSet resultBelongMS = null;
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String selectMagician = "select Magician_ID, Magician_Name, Age, Species, Country_Of_Origin, job, Magician_Class, Magician_Attribute, Mana from Magician";
		int count = 0;
		resultMagician = stmt.executeQuery(selectMagician);
		if(resultMagician.next()){
			%>
			<table border="1" width="100%" id="table">
				<tr align="center">
					<th>아이디</th>
					<th>이름</th>
					<th>나이</th>
					<th>종족</th>
					<th>출신지</th>
					<th>직업</th>
					<th>클래스</th>
					<th>속성</th>
					<th>마나량</th>
					<th>소속여부</th>
				</tr>
			<%
			do {
				int m_class = Integer.parseInt(resultMagician.getString(7));
				if(m_class <= ms_class){
					count++;
					String m_id = resultMagician.getString(1);
					String selectBelongMS = "select * from Magician_Belong where Magician_ID = '" + m_id + "'and MagicStore_ID = '" + keep_id + "';";
					resultBelongMS = stmt.executeQuery(selectBelongMS);
					%>
					<script>count = count + 1;</script>
					<tr align="center">
						<td><%=m_id %></td>
						<td><%=resultMagician.getString(2) %></td>
						<td><%=resultMagician.getString(3) %></td>
						<td><%=resultMagician.getString(4) %></td>
						<td><%=resultMagician.getString(5) %></td>
						<td><%=resultMagician.getString(6) %></td>
						<td><%=resultMagician.getString(7) %></td>
						<td><%=resultMagician.getString(8) %></td>
						<td><%=resultMagician.getString(9) %></td>
					<%
					if(resultBelongMS.next()){
					%>
						<td><input type="checkbox" name="belong" value="<%=m_id %>" checked></td>
					<%		
					} else {
					%>
						<td><input type="checkbox" name="belong" value="<%=m_id %>"></td>
					<%
					}
					%>
					</tr>
			<%
				}
			}while(resultMagician.next());
			%></table><%
		} else {
			%><script>alert('거래허가 클래스보다 낮거나 같은 클래스를 가진 마법사가 없습니다.');location.replace('main_magicstore.jsp');</script><%
		}
	} catch (SQLException e){
		e.printStackTrace();
	} finally {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
	
	<form action="search_belong_magician_db.jsp" method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
</body>
</html>