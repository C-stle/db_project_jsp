<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LoDoS Customer</title>
<style>
#div_logout{
position: absolute;
top: 10px;
right: 10px;
}
</style>
<script type="text/javascript">
function onMSClicked(value){
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
function onMClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
	var str = "";
	str+="<input name='m_id' type='hidden' value='"+ value + "'>";
	
	var addedDiv = document.createElement("div");
	addedDiv.id = "added";
	addedDiv.innerHTML  = str;
	addedFormDiv.appendChild(addedDiv);
	
	var form = document.getElementById("hideForm");
	window.open('','POP','height=450 width=300 scrollbars=yes');
	form.action ='popup_magic.jsp';
	form.target = 'POP';
	form.submit();
}
function onMAClicked(value){
	var addedFormDiv = document.getElementById("addedFormDiv");
	addedFormDiv.innerHTML="";
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
	
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	ResultSet resultC = null;
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
		
		// �α����� ���� ���� ��������
		String query = "select *, AES_DECRYPT(Customer_Password, Customer_ID) from Customer where Customer_ID='" + keep_id + "';";
		resultC = stmt.executeQuery(query);
		resultC.next();
		
		// �α����� ���� �ŷ�ó ���� ��ȸ ID ��������
		query = "select MagicStore_ID from Customer_Account where Customer_ID = '" + keep_id + "';";
		result = stmt.executeQuery(query);
		List<String> ms_id = new ArrayList<String>();
		while(result.next()){
			ms_id.add(result.getString(1));
		}
		session.setAttribute("ms_count",ms_id.size());
		
		// �α����� ���� ������ ���� ID ��������
		query = "select Magic_ID from Magic_Trade where Customer_ID = '" + keep_id + "';";
		result = stmt.executeQuery(query);
		List<String> m_id = new ArrayList<String>();
		while(result.next()){
			m_id.add(result.getString(1));
		}
		
		// �α����� ���� ������ ��� ID, �� �ŷ��� ��������
		query = "select Material_ID, SUM(Trade_Amount) from Material_Trade where Customer_ID = '" + keep_id + "' group by Material_ID;" ;
		result = stmt.executeQuery(query);
		List<String> ma_id = new ArrayList<String>();
		List<String> ma_amount = new ArrayList<String>();
		while(result.next()){
			ma_id.add(result.getString(1));
			ma_amount.add(result.getString(2));
		}
	%>
	<h1>LoDos Customer</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<div>
		<p><%=keep_id %> ����
		<input type="button" value="����" onclick="location.replace('info_customer_edit.jsp');">
		<input type="button" value="���ư���" onclick="location.href='main_customer.jsp'">
		
	</div>
	<div>
		<div>���̵� : <%=resultC.getString(1) %></div>
		<div>��й�ȣ : <%=resultC.getString(8)%></div>
		<div>�̸� : <%=resultC.getString(3) %></div>
		<div>���� : <%=resultC.getString(4) %></div>
		<div>�ּ� : <%=resultC.getString(5) %></div>
		<div>�Ӽ� : <%=resultC.getString(6) %></div>
		<div>������ : <%=resultC.getString(7) %></div>
		<BR>
		<div id="div_input_ms">
		<%
		// �ŷ�ó ���� ��ȸ ��� ����
		if(ms_id.isEmpty()) {
			%>- �ŷ�ó ���� ��ȸ�� �����ϴ�.<BR><%
		} else {
			%><div>�ŷ�ó ���� ��ȸ</div><%
			for(int i=0;i<ms_id.size();i++) {
				%>
				<div>
					- <a href="javascript:void(0);" onclick="onMSClicked('<%=ms_id.get(i)%>'); return false;"><%=ms_id.get(i)%></a>
				</div>
				<%
			}
		}
		%><BR><%
		// ������ ���� ��� ����
		if(m_id.isEmpty()) {
			%>- ������ ������ �����ϴ�.<BR><%
		} else {
			
			%><div>������ ���� ���</div><%
			for(int i=0;i<m_id.size();i++) {
				%>
				<div>
					- <a href="javascript:void(0);" onclick="onMClicked('<%=m_id.get(i)%>'); return false;"><%=m_id.get(i)%></a>
				</div>
				<%
			}
		}
		%><BR><%
		// ������ ��� ��� ����
		if(ma_id.isEmpty()) {
			%>- ������ ��ᰡ �����ϴ�.<BR><%
		} else {
			
			%><div>������ ��� ��� / ������</div><%
			for(int i=0;i<ma_id.size();i++) {
				%>
				<div>
					- <a href="javascript:void(0);" onclick="onMAClicked('<%=ma_id.get(i)%>'); return false;"><%=ma_id.get(i)%></a> / <%=ma_amount.get(i)%>
				</div>
				<%
			}
		}
		%>
		</div>
	</div>
	<BR>
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
</html>