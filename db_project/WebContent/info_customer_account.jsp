<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
function onClicked(){
	var form = document.getElementById("mainForm");
	form.action ='search_buy_material.jsp';
	form.submit();
}
</script>
</head>
<body>
	<% //���� ����, ��� ���Ÿ� ���� ���� ��ȸ ���� ȭ��
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
		<h1>�ŷ�ó ����</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<p><%=keep_id %> �ŷ�ó ����
	</div>
	<form action="search_buy_magic.jsp" method="post" id="mainForm">
		<%
		Statement stmt = null;
		Connection conn = null;
		ResultSet result = null;
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
			
			//�ŷ�ó ���� ��ȸ ID�� ������
			String select = "select MagicStore_ID from Customer_Account where Customer_ID = '" + keep_id + "';";
			result = stmt.executeQuery(select);
			int check = 0;	// �ϳ��� checked ������ ���� ����
			if(result.next()){	// �ŷ�ó ���� ��ȸ�� �ִ� ���
				do {
					if(check==0){	// ù��° �ŷ�ó ���� ��ȸ�� ���, checked ����
						%>
						<div>
							<input type="radio" name="ms_id" value="<%=result.getString(1) %>" checked> <%=result.getString(1) %>
						</div>
						<%
						check++;
					} else {	// �ι�° �̻��� �ŷ�ó ���� ��ȸ�� ���
						%>
						<div>
							<input type="radio" name="ms_id" value="<%=result.getString(1) %>"> <%=result.getString(1) %>
						</div>
						<%
					}
				} while(result.next());
			} else {	// �ŷ�ó ���� ��ȸ�� ���� ���
				%><script>alert('�ŷ�ó ���� ��ȸ�� �����ϴ�.');location.replace('main_customer.jsp');</script><%
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
		<BR>
		<div>
			<input type="submit" value="�Ǹ� ���� ����">
			<input type="button" value="�Ǹ� ��� ����" onclick="onClicked();">
			<input type="button" value="���ư���" onclick="location.replace('main_customer.jsp');">
		</div>
	</form>
</body>
</html>