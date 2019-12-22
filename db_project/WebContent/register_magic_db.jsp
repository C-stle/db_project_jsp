<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
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
	%>
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<%
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String explain = request.getParameter("explain");
	String m_class = request.getParameter("class");
	String attribute = request.getParameter("attribute");
	String type = request.getParameter("type");
	String effect = request.getParameter("effect");
	String mana = request.getParameter("mana");
	String price = request.getParameter("price");
	
	String creator_id = (String)session.getAttribute("id");
	String creator_class = (String)session.getAttribute("class");
	String creator_attribute = (String)session.getAttribute("attribute");
	
	String [] material_id = request.getParameterValues("m_id");
	String [] material_amount = request.getParameterValues("amount");
	int count = material_id.length;
	String selectMagicID = "select Magic_ID from magic;";
	ResultSet resultID = null;
	
	Statement stmt = null;
	Connection conn = null;
	String str = "";
	try {
		String driver = "org.mariadb.jdbc.Driver";
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		resultID = stmt.executeQuery(selectMagicID);
		int checkID = 1;
		int checkMA = 1;
		while(resultID.next()) {	// ���� ID �ߺ� Ȯ��
			if(id.equals(resultID.getString(1))) {
				checkID = 0;
				break;
			}
		}
		String selectMaterialID = null;
		for (int i=0;i<count;i++) { // ��� ID ���� ���� Ȯ��
			selectMaterialID = "select Material_ID from material where Material_ID='" + material_id[i] + "';";
			resultID = stmt.executeQuery(selectMaterialID);
			if(!resultID.next()) {
				checkMA = 0;
				break;
			}
		}
		int overlap_count = 0;
		for (String m_id : material_id) { // ��� �ߺ� �Է� Ȯ��
			for (String c_id : material_id) {
				if(m_id.equals(c_id)) {
					overlap_count++;
				}
			}
		}
		int checkInsert = 1;
		str = "���� ��� ����";
		if(checkID == 0){
			str = str + "���� ID�� �ߺ��Ǿ����ϴ�.";
			checkInsert = 0;
		}
		if(checkMA == 0){
			str = str + "\\n��ϵ��� ���� ��Ḧ �Է��Ͽ����ϴ�.";
			checkInsert = 0;
		}
		if(Integer.parseInt(m_class) > Integer.parseInt(creator_class)) {
			str = str + "\\n������ Ŭ������ â�� �������� Ŭ�������� �����ϴ�.";
			checkInsert = 0;
		}
		if(!creator_attribute.equals(attribute)) {
			str = str + "\\n������ â������ �Ӽ��� ��ġ���� �ʽ��ϴ�.";
			checkInsert = 0;
		}
		if(overlap_count != material_id.length) {
			str = str + "\\n��Ḧ �ߺ����� �ԷµǾ����ϴ�.";
			checkInsert = 0;
		}
		if(checkInsert == 1){
			String insert_magic = 
					"insert into magic values('" + id + "', '" + name + "', '" + explain + "', '" +
					 m_class + "', '" + attribute + "', '" + type + "', '" + effect + "', '" + mana + 
					 "', '" + price + "', '" + creator_id + "');";
			stmt.executeUpdate(insert_magic);
			
			for (int i=0;i<count;i++) {
				String insert_material_use =
						"insert into material_use values('" + id + "', '" + material_id[i] +"', '" + 
						material_amount[i] + "');"; 
				stmt.executeUpdate(insert_material_use);
			}
			str = "���� ��� �Ϸ�";
			%><script>alert('<%=str%>');location.replace('main_magician.jsp');</script><%
		} else {
			%><script>alert('<%=str%>');location.replace('register_magician.jsp');</script><%
		}
	} catch (SQLException e) {
		e.printStackTrace();
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