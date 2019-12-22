<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS MagicStore</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
<script type="text/javascript">
function onMClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML = "";
	var str = "";
	str+="<input name='m_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=420 width=300 scrollbars=yes');
	form.action ='popup_magician.jsp';
	form.target = 'POP';
	form.submit();
	
}

function onMAClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML = "";
	var str = "";
	str+="<input name='ma_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=300 width=300 scrollbars=yes');
	form.action ='popup_material.jsp';
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
	
	String password = null;
	String name = null;
	String address = null;
	String representative = null;
	String license_class = null;
	String money = null;
	
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	
	Statement stmt = null;
	Connection conn = null;
	ResultSet result = null;
	
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		String query = "select *, AES_DECRYPT(MagicStore_Password, MagicStore_ID) from magicstore where magicstore_id='" + keep_id + "';";
		result = stmt.executeQuery(query);
		result.next();
		password = result.getString(8);
		name = result.getString(3);
		address = result.getString(4);
		representative = result.getString(5);
		license_class = result.getString(6);
		money = result.getString(7);
			
	%>
	<h1>������ȸ ���� Ȯ��</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<form action="info_magicstore_edit.jsp" method ="post" name="main">
	<div>
		<p><%=keep_id %> ���� 
		<input type="submit" value="���� ����">
		<input type="button" value="���ư���" onclick="location.href='main_magicstore.jsp'">
	</div>
		<div>
			<div>���̵� : <%=keep_id %></div>
			<div>��й�ȣ : <%=password %></div>
			<div>ȸ�� �̸� : <%=name %></div>
			<div>�ּ� : <%=address %></div>
			<div>��ǥ�� : <%=representative %></div>
			<div>�ŷ��㰡 Ŭ���� : <%=license_class %></div>
			<div>������ : <%=money %></div>
		</div>
		<BR>
	</form>
	<div>
		<div>�Ҽ� ������</div>
		<%	
		//�Ҽ� ������ �̸� ���, Ŭ���� ���� ǥ��
		String selectM = "select Magician_ID from Magician_Belong where MagicStore_ID = '" + keep_id + "';";
		result = stmt.executeQuery(selectM);
		List<String> listM = new ArrayList<String>();
		while(result.next()){
			listM.add(result.getString(1));
		}
		if(listM.isEmpty()){
			%>- �Ҽ� �����簡 �����ϴ�.<%
		} else {
			for(int i=0;i<listM.size();i++) {
				%>
				<div>
				- <a href="javascript:void(0);" onclick="onMClicked('<%=listM.get(i) %>'); return false;"><%=listM.get(i) %></a>
				</div>
				<%
			}
		}
		%>
	</div>
	<BR>
	<div>
		<div>���� ��� / ������</div>
		<%	
		// ���� ���, ������ ǥ�� Ŭ���� ���� ǥ��
		String selectMA = "select Material_ID, Amount from Material_Sell where MagicStore_ID = '" + keep_id + "';";
		result = stmt.executeQuery(selectMA);
		List<String> listMA = new ArrayList<String>();
		List<Integer> listMAAmount = new ArrayList<Integer>();
		while(result.next()){
			listMA.add(result.getString(1));
			listMAAmount.add(result.getInt(2));
		}
		if(listMA.isEmpty()){
			%>- ���� ��ᰡ �����ϴ�.<%
		} else {
			for(int i=0;i<listMA.size();i++) {
				%>
				<div>
				- <a href="javascript:void(0);" onclick="onMAClicked('<%=listMA.get(i) %>'); return false;"><%=listMA.get(i) %></a> / <%=listMAAmount.get(i) %>
				</div>
				<%
			}
		}
		%>
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
	<form action="info_magician_alert.jsp" method="post" id="hideForm">
		<div id="addedFormDiv">
		</div>
	</form>
</body>
</html>