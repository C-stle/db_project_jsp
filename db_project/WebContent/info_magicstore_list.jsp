<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
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
		%><script>location.replace('login.jsp');</script><%
	}
%>

<div>
	<h1>�Ҽ� ���� ��ȸ
</div>
<div id="div_logout">
	<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
</div>
<form action="info_magicstore.jsp" method="post">
	<%
	List<String> list = (List)session.getAttribute("ms_id");
	if(list == null) {
		%>
		�Ҽӵ� ���� ��ȸ�� �����ϴ�.
		<input type="button" value="���ư���" onclick="location.replace('info_magician.jsp');">
		<%
	} else {
		%>
		���� ��ȸ�� Ŭ�����ּ���
		<%
		for (int i = 0; i<list.size();i++){
			%>
			<div>
				�Ҽ� ��ȸ <%=(i+1) %> : <input type="radio" name="ms_id" value="<%=list.get(i) %>"><%=list.get(i) %>
			</div>
			<%
		}
	}
	
	%>
	<input type="submit" value="���� ����">
	<input type="button" value="���ư���" onclick="location.replace('info_magician.jsp');">
</form>
</body>
</html>