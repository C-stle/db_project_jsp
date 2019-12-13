<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<Form action="info_magician_to_info_ms_db.jsp" method="post" name="mainForm">
	<input type="hidden" id="ms_id" name="ms_id">
</Form>

<script type="text/javascript">
	document.getElementById("ms_id").value=sessionStorage.getItem("ms_id");
	document.mainForm.submit();
</script>

</body>
</html>