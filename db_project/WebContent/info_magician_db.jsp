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

</style>
</head>
<body>
<h1>LoDos Magician</h1>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);

	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String species = request.getParameter("species");
	String country = request.getParameter("country");
	String job = request.getParameter("job");
	String m_class = request.getParameter("class");
	String attribute = request.getParameter("attribute");
	String mana = request.getParameter("mana");
	String money = request.getParameter("money");
	
	String[] ms_id = request.getParameterValues("ms_id");
	int count;
	if(ms_id == null){
		count = 0;
	} else {
		count = ms_id.length;
	}
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	
	Statement stmt = null;
	Connection conn = null;
	ResultSet result = null;
	ResultSet resultID = null;
	ResultSet resultMSClass = null;
	
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
		if(!id.equals(keep_id)){	// ������ ID �ߺ� �Է� Ȯ��
			String selectMagicianID = "select Magician_ID from Magician;";
			resultID = stmt.executeQuery(selectMagicianID);
			checkID = 1;
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					checkID = 0;
					break;
				}
			}
		}

		int checkMSID=0;
		int overlap_count = 0;
		if(ms_id!=null) {
			String selectMSID;
			for (int i=0;i<count; i++) { // ���� ��ȸ ID �Է� Ȯ��
				selectMSID = "select MagicStore_ID from MagicStore where MagicStore_ID = '" + ms_id[i] +"';";
				resultID = stmt.executeQuery(selectMSID);
				if(resultID.next()) {
					checkMSID = 1;
				} else {
					checkMSID = 0;
					break;
				}
			}
			
			if(count > 1) {
				for (String checkID1: ms_id) {	// ���� ��ȸ ID �ߺ� �Է� Ȯ��
					for (String checkID2: ms_id) {
						if(checkID1.equals(checkID2)){
							overlap_count++;
						}
					}
				}
			} else {
				overlap_count = count;
			}
		} else {
			checkMSID = 1;
		}
		int m_class_int = Integer.parseInt(m_class);
		int checkClass = 1;
		for (int i=0; i<count;i++){
			String selectMSClass = "select License_Class from MagicStore where MagicStore_ID = '" + ms_id[i] + "';";
			resultMSClass = stmt.executeQuery(selectMSClass);
			resultMSClass.next();
			checkClass = Integer.parseInt(resultMSClass.getString(1));
			if(m_class_int > checkClass){
				checkClass = 0;
				break;
			}
		}
		if(checkID == 1) {
			if(checkMSID == 1) {
				if(overlap_count == count) {
					if(checkClass > 0) {
						String updateMagician = "update magician set Magician_ID = '" + id + 
								"', Magician_Password = '" + password + "', Magician_Name = '" + name + 
								"', Age = '" + age + "', Species = '" + species + "', Country_Of_Origin = '" + country +
								"', Job = '" + job + "', Magician_Class = '" + m_class + "', Magician_Attribute = '" + attribute +
								"', Mana = '" + mana + "', Money = '" + money + "' where Magician_ID = '" + keep_id + "';";
						if(!id.equals(keep_id)) {
							session.removeAttribute("id");
							session.setAttribute("id",id);
						}
						session.removeAttribute("class");
						session.removeAttribute("attribute");
						session.setAttribute("class",m_class);
						session.setAttribute("attribute",attribute);
						
						stmt.executeUpdate(updateMagician);
						
						String deleteMSB = "delete from Magician_Belong where Magician_ID = '" + id + "';";
						stmt.executeUpdate(deleteMSB);
						
						if(count != 0) {
							for(String msIDModified : ms_id) {
								String insertMSB = "insert into Magician_Belong values('" + id +"', '" + msIDModified + "');";
								stmt.executeUpdate(insertMSB);
							}
						}
						%>
						<div><p>���� ���� �Ϸ�</div>
						<div>
							<input type="button" value="���ư���" onclick="location.replace('main_magician.jsp');">
						</div>
						<%
					}
					else { // �Է��� Ŭ������ �Ҽ� ��ȸ�� �ŷ��㰡 Ŭ������ �ʰ��ϴ� ���
						%>
						<div>
							<p>��� ����
							<p>- �Է��� Ŭ������ �Ҽ� ���� ��ȸ�� �ŷ��㰡 Ŭ������ �ʰ��Ͽ����ϴ�.
							<p>- ���� ��ȸ �Ҽ��� �����ϰ� �ٽ� �õ��ϼ���.
						</div>
						<div>
							<input type="button" value="���ư���" onclick="location.replace('info_magician_edit.jsp');">
						</div>
						<%
					}
				} else {
					%>
					<div>
						<p>��� ����
						<p>- �ߺ��� ���� ��ȸ ID�� �Է��Ͽ����ϴ�.
					</div>
					<div>
						<input type="button" value="���ư���" onclick="location.replace('info_magician_edit.jsp');">
					</div>
					<%
				}
			} else {
				%>
				<div>
					<p>��� ����
					<p>- ��ϵ��� ���� ���� ��ȸ ID�� �ֽ��ϴ�.
				</div>
				<div>
					<input type="button" value="���ư���" onclick="location.replace('info_magician_edit.jsp');">
				</div>
				<%
			}
		} else if (checkID == 0 && checkMSID == 1) {
			%>			
			<div>
				<p>��� ����
				<p>- �ߺ��� ������ ID �Դϴ�.
			</div>
			<div>
				<input type="button" value="���ư���" onclick="location.replace('info_magician_edit.jsp');">
			</div>
		<%
		} else if (checkID == 0 && checkMSID == 0) {
			%>
			<div>
				<p>��� ����
				<p>- �ߺ��� ������ ID �Դϴ�.
				<p>- ��ϵ��� ���� ������ ��ȸ ID �Դϴ�.
			</div>
			<div>
				<input type="button" value="���ư���" onclick="location.replace('info_magician_edit.jsp');">
			</div>
		<%
		}
	} catch (SQLException e) {
		
	} finally {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>