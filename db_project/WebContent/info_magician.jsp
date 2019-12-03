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
	var count = 1;
	
	function newPage() {
		
	}
	
	function addForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		var str = "";
		count++;
		str+="<BR>"
		str+="재료"+count+" ID <input name='m_id' type='text' required>";
		str+="&nbsp;필요량 <input name='amount' type='number' min='1' required><BR>";
		var addedDiv = document.createElement("div");
		addedDiv.id = "added_"+count;
		addedDiv.innerHTML  = str;
		addedFormDiv.appendChild(addedDiv);
		document.baseForm.count.value=count;
	}

	function delForm(){
		var addedFormDiv = document.getElementById("addedFormDiv");
		if(count >1){
			var addedDiv = document.getElementById("added_"+(count--));
			addedFormDiv.removeChild(addedDiv);
		} else{
			document.baseForm.reset();
		}
	}
</script>
</head>
<body>
<%!
	public void setSession(HttpSession session, HttpServletResponse response, String ms_id) {
		session.removeAttribute("ms_id");
		session.setAttribute("ms_id", ms_id);
		
		//response.sendRedirect("info_magicstore.jsp");
	}

%>


<%
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
		String ms_id = null;
%>


	<h1>LoDos Magician</h1>	
	<div id="div_logout">
		<input type="button" value="Logout" onclick="location.href='login.jsp'">
	</div>
	<p><%=id %> 정보
	<form action="info_magician_db.jsp" method ="post">
		<div>
			<div>아이디 : <input name="id" type="text" value='<%=id %>' required=""></div>
			<div>비밀번호 : <input name="password" type="text" value='<%=password %>' required=""></div>
			<div>이름 : <input name="name" type="text" value='<%=name %>' required=""></div>
			<div>나이 : <input name="age" type="number" min='1' value='<%=age %>' required=""></div>
			<div>종족 : <input name="species" type="text" value='<%=species %>' required=""></div>
			<div>출신지 : <input name="country" type="text" value='<%=country %>' required=""></div>
			<div>직업 : <input name="job" type="text" value='<%=job %>' required=""></div>
			<div>클래스 : <input name="class" type="number" min='1' max='9' value='<%=m_class %>'></div>
			<div>속성 : <input name="attribute" type="text" value='<%=attribute %>' required=""></div>
			<div>마나량 : <input name="mana" type="number" min='100' value='<%=mana %>'></div>
			<div>소지금 : <input name="money" type="number" min='1' value='<%=money %>'></div>
		
			<div id="div_input_ms">
			<%
			int count=1;
			while(result.next()) {
				
				ms_id = result.getString("MagicStore_ID");
				%>
				<div id="added_<%=count%>">
					소속 상회 <%=count%> : <input name="ms_id" type="text" value='<%=ms_id%>' onclick="setSession(<%=session%>, <%=ms_id%>)" ondblclick="location.href='info_magicstore.jsp'"">
				</div>
				<%
				count++;
			}
		%>
		</div>
	</div>
		
	<BR>
	<div>
		<input type="submit" value="수정">
		<input type="button" value="돌아가기" onclick="location.href='main_magician.jsp'">
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