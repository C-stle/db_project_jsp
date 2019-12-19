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
<title>Magic Store Information</title>
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
	%><script>alert('로그인 세션이 만료되었거나, 잘못된 접근 입니다.');location.replace('login.jsp');</script><%
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
	String query = "select * from magicstore where magicstore_id='" + keep_id + "';";
	result = stmt.executeQuery(query);
	result.next();
	password = result.getString("MagicStore_Password");
	name = result.getString("Company_Name");
	address = result.getString("Address");
	representative = result.getString("Representative");
	license_class = result.getString("License_Class");
	money = result.getString("Money");
		
%>
<h1>LoDos Magic Store</h1>	
<div id="div_logout">
	<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
</div>
<form action="info_magicstore_edit.jsp" method ="post" name="main">
<div>
	<p><%=keep_id %> 정보 
	<input type="submit" value="정보 수정">
	<input type="button" value="돌아가기" onclick="location.href='main_magicstore.jsp'">
</div>
	<div>
		<div>아이디 : <input type="text" name="id" value="<%=keep_id %>" readonly></div>
		<div>비밀번호 : <input type="text" name="password" value="<%=password %>" readonly></div>
		<div>회사 이름 : <input type="text" name="name" value="<%=name %>" readonly></div>
		<div>주소 : <input type="text" name="address" value="<%=address %>" readonly></div>
		<div>대표자 : <input type="text" name="representative" value="<%=representative %>" readonly></div>
		<div>거래허가 클래스 : <input type="text" name="class" value="<%=license_class %>" readonly></div>
		<div>소지금 : <input type="text" name="money" value="<%=money %>" readonly></div>
	</div>
	<BR>
	<div>
		
	</div>
</form>
	<div>
	<div>소속 마법사</div>
	<%	
	//소속 마법사 이름 출력, 클릭시 정보 표출
	String selectM = "select Magician_ID from Magician_Belong where MagicStore_ID = '" + keep_id + "';";
	result = stmt.executeQuery(selectM);
	List<String> listM = new ArrayList<String>();
	while(result.next()){
		listM.add(result.getString(1));
	}
	if(listM.isEmpty()){
		%>- 소속 마법사가 없습니다.<%
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
	<div>
	<div>보유 재료 / 보유량</div>
	<%	
	// 보유 재료, 보유량 표출 클릭시 정보 표출
	String selectMA = "select Material_ID, Inventory_Volume from Material_Sell where MagicStore_ID = '" + keep_id + "';";
	result = stmt.executeQuery(selectMA);
	List<String> listMA = new ArrayList<String>();
	while(result.next()){
		listMA.add(result.getString(1));
	}
	if(listMA.isEmpty()){
		%>- 보유 재료가 없습니다.<%
	} else {
		for(int i=0;i<listMA.size();i++) {
			%>
			<div>
			- <a href="javascript:void(0);" onclick="onMClicked('<%=listMA.get(i) %>'); return false;"><%=listMA.get(i) %></a>
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