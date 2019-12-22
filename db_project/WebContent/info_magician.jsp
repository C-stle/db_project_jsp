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
<title>LoDoS Magician</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
<script type="text/javascript">
function onClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='ms_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=300 width=300 scrollbars=yes');
	form.action ='popup_magicstore.jsp';
	form.target = 'POP';
	form.submit();
	
}

</script>

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
		
		query = "select MagicStore_ID from magician_belong where Magician_ID = '" + id + "';";
		result = stmt.executeQuery(query);
		List<String> ms_id = new ArrayList<String>();
		while(result.next()){
			ms_id.add(result.getString(1));
		}
		session.setAttribute("ms_count",ms_id.size());
%>
	<h1>LoDos Magician</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=id %> ����
	<div>
		<div>���̵� : <%=id %></div>
		<div>��й�ȣ : <%=password %></div>
		<div>�̸� : <%=name %></div>
		<div>���� : <%=age %></div>
		<div>���� : <%=species %></div>
		<div>����� : <%=country %></div>
		<div>���� : <%=job %></div>
		<div>Ŭ���� : <%=m_class %></div>
		<div>�Ӽ� : <%=attribute %></div>
		<div>������ : <%=mana %></div>
		<div>������ : <%=money %></div>
		<BR>
		<div id="div_input_ms">
		<%
		if(ms_id.isEmpty()) {
			%>- �Ҽ� ��ȸ�� �����ϴ�.<%
		} else {
			
			%><div>�Ҽ� ���� ��ȸ</div><%
			for(int i=0;i<ms_id.size();i++) {
				%>
				<div>
					- <a href="javascript:void(0);" onclick="onClicked('<%=ms_id.get(i)%>'); return false;"><%=ms_id.get(i)%></a>
				</div>
				<%
			}
		}
	%>
		</div>
	</div>
	<BR>
	<div>
		<input type="button" value="����" onclick="location.replace('info_magician_edit.jsp');">
		<input type="button" value="���ư���" onclick="location.href='main_magician.jsp'">
	</div>

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
	<form method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
	
</body>
</html>