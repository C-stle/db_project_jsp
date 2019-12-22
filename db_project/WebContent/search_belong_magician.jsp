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
	// ��ü ������ ��� ǥ��, ���� (�㰡 Ŭ���� ���� üũ)
	// ������ ��Ͽ� ���� �˻���� ����
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	int ms_class = Integer.parseInt((String)session.getAttribute("ms_class"));
	%>
	<div>
		<h1>LoDos Magic Store</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<p><%=keep_id %> �Ҽ� ������ ��ȸ
	</div>
	<div>
		<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>���̵�
		<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">�̸�
		<input type="radio" name="kind" id="kind" value="age" onclick="onchecked();">����
		<input type="radio" name="kind" id="kind" value="species" onclick="onchecked();">����
		<input type="radio" name="kind" id="kind" value="home" onclick="onchecked();">�����
		<input type="radio" name="kind" id="kind" value="job" onclick="onchecked();">����
		<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">Ŭ����
		<input type="radio" name="kind" id="kind" value="attribute" onclick="onchecked();">�Ӽ�
		<input type="radio" name="kind" id="kind" value="mana" onclick="onchecked();">������
		<input type="text" id="value" placeholder = "Searching Magician" onkeyup="filter();">
		<input type="button" value="�Ҽ� ����" onclick="onEditClicked();">
	<input type="button" value="���ư���" onclick="location.href='main_magicstore.jsp'">
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
					<th>���̵�</th>
					<th>�̸�</th>
					<th>����</th>
					<th>����</th>
					<th>�����</th>
					<th>����</th>
					<th>Ŭ����</th>
					<th>�Ӽ�</th>
					<th>������</th>
					<th>�Ҽӿ���</th>
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
			%><script>alert('�ŷ��㰡 Ŭ�������� ���ų� ���� Ŭ������ ���� �����簡 �����ϴ�.');location.replace('main_magicstore.jsp');</script><%
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