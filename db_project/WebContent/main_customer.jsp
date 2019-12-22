<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage="error.jsp"%>
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
	
	// 거래처 등록/삭제 - 전체 마법상회 목록 표출, 검색기능
	// 마법 구매 - 거래처인 마법상회 목록 표출, 선택한 마법상회에서 판매하는 마법 리스트 표출, 선택, 구매
	// 재료구매 - 거래처인 마법상회 목록 표출, 선택한 마버상회에서 판매하는 재료 리스트 표출, 선택, 구매
	// 정보 확인, 수정 - 거래처 마법상회(클릭시 정보 표출)
	// 거래내역 확인
	%>

	<div>
		<h1>LoDos Customer</h1>
		<p><%=keep_id %>님 환영합니다.
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('login.jsp')">
		</div>
	</div>
	<div>
		<input type="button" value="거래처  조회" onclick="location.href='search_magicstore_account.jsp'">
	</div>
	<div>
		<input type="button" value="마법 / 재료 구매" onclick="location.href='info_customer_account.jsp'">
	</div>
	<div>
		<input type="button" value="본인 정보 확인" onclick="location.href='info_customer.jsp'">
	</div>
	<div>
		<input type="button" value="마법 거래 내역 확인" onclick="location.href='search_trade_customer_magic.jsp'">
	</div>
	<div>
		<input type="button" value="재료 거래 내역 확인" onclick="location.href='search_trade_customer_material.jsp'">
	</div>
	<div>
		<input type="button" value="회원 탈퇴" onclick="location.href='drop_customer.jsp'">
	</div>
</body>
</html>