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
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
<%
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>location.replace('login.jsp');</script><%
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
	String prev_id = (String)session.getAttribute("id");
	
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
	
	ResultSet result = null;
	Statement stmt = null;
	Connection conn = null;
	ResultSet resultID = null;
	
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
		if(!id.equals(prev_id)){	// 마법사 ID 중복 입력 확인
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
			for (int i=0;i<count; i++) { // 마법 상회 ID 입력 확인
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
				for (String checkID1: ms_id) {	// 마법 상회 ID 중복 입력 확인
					for (String checkID2: ms_id) {
						if(checkID1.equals(checkID2)){
							overlap_count++;
						}
					}
				}
			} else {
				overlap_count = count;
			}
		}
		
		
		if(checkID == 1 && checkMSID == 1) {
			if(overlap_count == count) {
				String updateMagician = "update magician set Magician_ID = '" + id + 
						"', Magician_Password = '" + password + "', Magician_Name = '" + name + 
						"', Age = '" + age + "', Species = '" + species + "', Country_Of_Origin = '" + country +
						"', Job = '" + job + "', Magician_Class = '" + m_class + "', Magician_Attribute = '" + attribute +
						"', Mana = '" + mana + "', Money = '" + money + "' where Magician_ID = '" + prev_id + "';";
				if(!id.equals(prev_id)) {
					session.removeAttribute("id");
					session.setAttribute("id",id);
				}
				stmt.executeUpdate(updateMagician);
				if(count != 0) {
					String deleteMSB = "delete from Magician_Belong where Magician_ID = '" + id + "';";
					stmt.executeUpdate(deleteMSB);
					
					for(String msIDModified : ms_id) {
						String insertMSB = "insert into Magician_Belong values('" + id +"', '" + msIDModified + "');";
						stmt.executeUpdate(insertMSB);
					}
				}
				%>
				<div><h1>수정 완료</h1></div>
				<div>
					<input type="button" value="돌아가기" onclick="location.replace('main_magician.jsp')">
				</div>
				<%
			} else {
				%>
				<div>
					<h1>등록 실패</h1>
					<p>중복된 마법 상회 ID를 입력하였습니다.
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.replace('info_magician_modified.jsp')">
				</div>
				<%
			}
		} else if (checkID == 1 && checkMSID == 0) {
			%>	
				<div>
					<h1>등록 실패</h1>
					<p>등록되지 않은 마법 상회 ID가 있습니다.
				</div>
				<div>
					<input type="button" value="돌아가기" onclick="location.replace('info_magician_modified.jsp')">
				</div>
			<%
			
		} else if (checkID == 0 && checkMSID == 1) {
			%>			
			<div>
				<h1>등록 실패</h1>
				<p>중복된 마법사 ID 입니다.
			</div>
			<div>
				<input type="button" value="돌아가기" onclick="location.replace('info_magician_modified.jsp')">
			</div>
		<%
		} else if (checkID == 0 && checkMSID == 0) {
			%>
			<div>
				<h1>등록 실패</h1>
				<p>중복된 마법사 ID 입니다.
				<p>등록되지 않은 마법사 상회 ID 입니다.
			</div>
			<div>
				<input type="button" value="돌아가기" onclick="location.replace('info_magician_modified.jsp')">
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