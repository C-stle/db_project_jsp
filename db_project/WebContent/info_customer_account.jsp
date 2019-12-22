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
	<% //고객이 마법, 재료 구매를 위한 마법 상회 선택 화면
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
	}
	%>
	<div>
		<h1>거래처 선택</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
		<p><%=keep_id %> 거래처 선택
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
			
			//거래처 마법 상회 ID를 가져옴
			String select = "select MagicStore_ID from Customer_Account where Customer_ID = '" + keep_id + "';";
			result = stmt.executeQuery(select);
			int check = 0;	// 하나만 checked 설정을 위한 변수
			if(result.next()){	// 거래처 마법 상회가 있는 경우
				do {
					if(check==0){	// 첫번째 거래처 마법 상회인 경우, checked 설정
						%>
						<div>
							<input type="radio" name="ms_id" value="<%=result.getString(1) %>" checked> <%=result.getString(1) %>
						</div>
						<%
						check++;
					} else {	// 두번째 이상의 거래처 마법 상회인 경우
						%>
						<div>
							<input type="radio" name="ms_id" value="<%=result.getString(1) %>"> <%=result.getString(1) %>
						</div>
						<%
					}
				} while(result.next());
			} else {	// 거래처 마법 상회가 없는 경우
				%><script>alert('거래처 마법 상회가 없습니다.');location.replace('main_customer.jsp');</script><%
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
			<input type="submit" value="판매 마법 보기">
			<input type="button" value="판매 재료 보기" onclick="onClicked();">
			<input type="button" value="돌아가기" onclick="location.replace('main_customer.jsp');">
		</div>
	</form>
</body>
</html>