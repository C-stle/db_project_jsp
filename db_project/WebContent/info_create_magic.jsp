<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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
<script type="text/javascript">
var count = 0;
var kind = "name";
function filter(){
	var value, radio, table, cell, i;
	value = document.getElementById("value").value;
	table = document.getElementById("table");
	if(kind == "id"){
		cell = 0;
	} else if (kind == "name"){
		cell = 1;
	} else if (kind == "class"){
		cell = 3;
	} else if (kind == "type"){
		cell = 5;
	}
	for(i=1;i<=count;i++){
		if(table.rows[i].cells[cell].innerHTML.indexOf(value) > -1){
			table.rows[i].style.display="";
		} else {
			table.rows[i].style.display="none";
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
</script>
</head>
<body>
<div>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	%>
	<div>
		<h1>â�� ���� ����</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<p><%=keep_id %>���� â���Ͻ� ���� ���
	</div>
	<div>
		<input type="radio" name="kind" id="kind" value="id" onclick="onchecked();" checked>���̵�
		<input type="radio" name="kind" id="kind" value="name" onclick="onchecked();">�̸�
		<input type="radio" name="kind" id="kind" value="class" onclick="onchecked();">Ŭ����
		<input type="radio" name="kind" id="kind" value="type" onclick="onchecked();">����
		<input type="text" id="value" placeholder = "Searching Magic" onkeyup="filter();">
		<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
	</div>
	<BR>
	<%
	Statement stmt = null;
	Connection conn = null;
	ResultSet resultMagic = null;
	ResultSet resultMaterial = null;
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
		
		String selectMagic = "select * from Magic where Creator_ID = '" + keep_id + "';";
		resultMagic = stmt.executeQuery(selectMagic);
		%>
		<table border="1" width="100%" id="table">
			<tr align="center">
				<th>���̵�</th>
				<th>�̸�</th>
				<th>����</th>
				<th>Ŭ����</th>
				<th>�Ӽ�</th>
				<th>����</th>
				<th>ȿ����</th>
				<th>������</th>
				<th>����</th>
				<th>��� ��� / ��뷮</th>
			</tr>
		<%
		while(resultMagic.next()){
			String m_id = resultMagic.getString(1);
			String selectMagicUseMaterial = "select Material_ID, Amount_Used from Material_Use where Magic_ID = '" + m_id + "';";
			resultMaterial = stmt.executeQuery(selectMagicUseMaterial);
			%>
			<script>count = count + 1;</script>
			<tr align="center">
				<td><%=m_id %></td>
				<td><%=resultMagic.getString(2) %></td>
				<td><%=resultMagic.getString(3) %></td>
				<td><%=resultMagic.getString(4) %></td>
				<td><%=resultMagic.getString(5) %></td>
				<td><%=resultMagic.getString(6) %></td>
				<td><%=resultMagic.getString(7) %></td>
				<td><%=resultMagic.getString(8) %></td>
				<td><%=resultMagic.getString(9) %></td>
				<td>
				<%
				int startCheck = 0;
				String str = "";
				while(resultMaterial.next()){
					if (startCheck == 0){
						startCheck++;
					} else {
						%><BR><%
					}
					str = resultMaterial.getString(1) + " / " + resultMaterial.getString(2);
					%><%=str%><%
				}
				%>
			</tr>
		<%
		}
		%></table><%
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

</div>
</body>
</html>