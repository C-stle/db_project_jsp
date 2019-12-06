<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<script type="text/javascript">
	var count = <%=(int)session.getAttribute("ms_count")%>;
	var last_check = 0;
	
	function addForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		if(last_check == 0){
			addedFormDiv.removeChild(document.getElementById("empty"));
			last_check = 1;
		}
		var str = "";
		count++;
		str+="소속 상회 " + count + " : <input name='ms_id' type='text' required>";
		var addedDiv = document.createElement("div");
		addedDiv.id = "added_"+count;
		addedDiv.innerHTML  = str;
		addedFormDiv.appendChild(addedDiv);
		document.baseForm.count.value=count;
	}

	function delForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		if(count>0){
			var addedDiv = document.getElementById("added_"+(count--));
			addedFormDiv.removeChild(addedDiv);
		} else{
			addedFormDiv.appendChild(addedDiv);
		}
		
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
		%><script>location.replace('login.jsp');</script><%
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
		String query = "select * from magician where magician_id='" + id + "';";
		result = stmt.executeQuery(query);
		result.next();
		password = result.getString("Magician_Password");
		name = result.getString("Magician_Name");
		age = result.getString("Age");
		species = result.getString("Species");
		country = result.getString("Country_Of_Origin");
		job = result.getString("Job");
		m_class = result.getString("Magician_Class");
		attribute = result.getString("Magician_Attribute");
		mana = result.getString("Mana");
		money = result.getString("Money");
		
		query = "select MagicStore_ID from magician_belong where Magician_ID = '" + id + "';";
		result = stmt.executeQuery(query);
		List<String> ms_id = new ArrayList<String>();
		while(result.next()){
			ms_id.add(result.getString("MagicStore_ID"));
		}
		
%>
	<h1>LoDos Magician</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
	</div>
	<p><%=id %> 정보
		<input type="button" value="마법 상회 추가" onclick="addForm()">
		<input type="button" value="마법 상회 삭제" onclick="delForm()">
	<form action="info_magician_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" value='<%=id %>' required=""></div>
			<div>비밀번호 : <input name="password" type="text" value='<%=password %>' required=""></div>
			<div>이름 : <input name="name" type="text" value='<%=name %>' required=""></div>
			<div>나이 : <input name="age" type="number" min='1' value='<%=age %>' required=""></div>
			<div>종족 : <input name="species" type="text" value='<%=species %>' required=""></div>
			<div>출신지 : <input name="country" type="text" value='<%=country %>' required=""></div>
			<div>직업 : <input name="job" type="text" value='<%=job %>' required=""></div>
			<div>클래스 : <input name="class" type="number" min='1' max='9' value='<%=m_class %>' required=""></div>
			<div>속성 : <input name="attribute" type="text" value='<%=attribute %>' required=""></div>
			<div>마나량 : <input name="mana" type="number" min='100' value='<%=mana %>' required=""></div>
			<div>소지금 : <input name="money" type="number" min='1' value='<%=money %>' required=""></div>
		</div>
		<div id="addedFormDiv">
		<%
			if(ms_id.isEmpty()) {
				%>
				<div id="empty"><label>소속 상회가 없습니다.</label></div>
				<%
			} else {
				for(int i=0;i<ms_id.size();i++) {
					%>
					<div id="added_<%=(i+1)%>">
						소속 상회 <%=(i+1)%> : <input name="ms_id" type="text" value='<%=ms_id.get(i)%>' required="">
					</div>
					<%
				}
			}
		%>
		</div>
		<div>
			<input type="hidden" name="count" value="<%=ms_id.size()%>">
		</div>
		<BR>
		<div>
			<input type="submit" value="수정">
			<input type="button" value="돌아가기" onclick="location.replace('main_magician.jsp')">
		</div>
	</form>

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
	
	
</body>
</html>