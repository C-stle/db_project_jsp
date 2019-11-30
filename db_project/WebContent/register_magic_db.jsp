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
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
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
		
		String [] material_id = request.getParameterValues("m_id");
		String [] material_amount = request.getParameterValues("amount");
		int count = Integer.parseInt(request.getParameter("count"));

		String selectMagicID = "select Magic_ID from magic;";
		ResultSet resultID = null;
		
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
			resultID = stmt.executeQuery(selectMagicID);
			int checkID = 1;
			int checkMe = 0;
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					checkID = 0;
					break;
				}
			}
			String selectMaterialID = null;
			for (int i=0;i<count;i++) {
				selectMaterialID = "select Material_ID from material where Material_ID='" + material_id[i] + "';";
				resultID = stmt.executeQuery(selectMaterialID);
				if(resultID.next()) {
					checkMe = 1;
					break;
				}
			}
			if(checkID == 1 && checkMe == 1) {
				if(Integer.parseInt(m_class) <= Integer.parseInt(creator_class)) {
					String insert_magic = 
							"insert into magic values('" + id + "', '" + name + "', '" + explain + "', '" +
							 m_class + "', '" + attribute + "', '" + type + "', '" + effect + "', '" + mana + 
							 "', '" + price + "', '" + creator_id + "');";
					stmt.executeUpdate(insert_magic);
					for (int i=0;i<count;i++) {
						String insert_material_use =
								"insert into material_use values('" + id + "', '" + material_id[i] +"', '" + 
								material_amount[i] + "');"; 
						stmt.executeQuery(insert_material_use);
					}
					%>			
					<div>
						<h1>등록 완료</h1>
					</div>
					<div>
						<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
					</div>
					<%
				} else {
					Exception classExc = new Exception("class 초과");
					throw classExc;
				}
			} else if (checkID == 1 && checkMe == 0) {
				%>	
				<div>
					<h1>등록 실패</h1>
					<p>등록되지 않은 재료가 있습니다.
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.href='register_magic.jsp'">
				</div>
			<%
			} else if (checkID == 0 && checkMe == 1) {
				%>			
				<div>
					<h1>등록 실패</h1>
					<p>중복된 마법 ID 입니다.
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.href='register_magic.jsp'">
				</div>
			<%
			} else if (checkID == 0 && checkMe == 0) {
				%>
				<div>
				<h1>등록 실패</h1>
				<p>중복된 마법 ID 입니다.
				<p>등록되지 않은 재료 입니다.
			</div>
			<div>
				<input type="button" value="돌아가기" onclick="location.href='register_magic.jsp'">
			</div>
			<%
			}
		} catch (SQLException e) {
			e.printStackTrace();
			%>
				<div>
					<h1>등록 실패</h1>
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.href='register_magic.jsp'">
				</div>
			<%
		} catch (Exception classExc) {
			%>
			<div>
				<h1>등록 실패</h1>
				<p>마법의 클래스가 창조 마법사의 클래스보다 높습니다.
			</div>
			<div>
				<input type="button" value="돌아가기" onclick="location.href='register_magic.jsp'">
			</div>
		<%
			
		} finally {
			
		}
	%>
	
</body>
</html>