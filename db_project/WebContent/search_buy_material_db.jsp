<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
	<div>
		<h1>LoDos Customer</h1>
		<div id="div_logout">
			<input type="button" value="Logout" onclick="location.replace('logout.jsp')">
		</div>
	</div>
	<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires",0L);
	
	String keep_id = (String)session.getAttribute("id");
	if(keep_id == null || keep_id.equals("")) {
		%><script>alert('�α��� ������ ����Ǿ��ų�, �߸��� ���� �Դϴ�.');location.replace('login.jsp');</script><%
	}
	
	String [] material_id = request.getParameterValues("ma_id");
	String [] stringAmount = request.getParameterValues("ma_amount");
	String [] stringPrice = request.getParameterValues("ma_price");
	int [] intAmount;
	int [] sellAmount;
	int count =0;
	if(stringAmount != null){
		intAmount = new int[stringAmount.length];
		sellAmount = new int[stringAmount.length];
		count = material_id.length;
	} else {
		intAmount = new int[0];
		sellAmount = new int[0];
	}
	String ms_id = (String)session.getAttribute("ms_id");
	
	if(count != 0){
		Statement stmt = null;
		Connection conn = null;
		ResultSet result = null;
		ResultSet resultMoney = null;
		ResultSet resultAmount = null;
		
		ResultSet resultTrade = null;
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
			String selectCMoney = "select Money from Customer where Customer_ID = '" + keep_id + "';";
			resultMoney = stmt.executeQuery(selectCMoney);
			resultMoney.next();
			int customerMoney = resultMoney.getInt(1);
			String selectMSMoney = "select Money from MagicStore where MagicStore_ID = '" + ms_id + "';";
			resultMoney = stmt.executeQuery(selectMSMoney);
			resultMoney.next();
			int msMoney = resultMoney.getInt(1);
			
			String selectMASMT = "select A.Material_ID, A.Amount, SUM(B.Trade_Amount) as Trade_Amount "
					+ "from Material_Sell as A left outer join Material_Trade as B on A.Material_ID = B.Material_ID "
					+ "where A.MagicStore_ID = '" + ms_id + "' group by A.Material_ID;";
			resultTrade = stmt.executeQuery(selectMASMT);
			// �Ǹ� ��� �� ���Ű� �Ͼ ���, ���� �Ѿ���� ��, ���� �������� üũ�ؼ� �������� �����ϰ� ���� �߻�
			int checkBuy = 0;
			int beforeAmount = 0;
			while(resultTrade.next()){
				for(int i = 0 ; i<count;i++){
					if(material_id[i].equals(resultTrade.getString(1))){ // �Ѿ�� �������� ��� id �� MS�� �Ǹ����� ��� id�� ���� ���
						beforeAmount = resultTrade.getInt(3);
						intAmount[i] = Integer.valueOf(stringAmount[i]);
						if(beforeAmount == intAmount[i]){ // �������� ���ŷ��� ���� ���
							intAmount[i] = 0;
						} else if (beforeAmount > intAmount[i]){
							%><script>alert('���������� ���� ���� �Է��� ��ᰡ �ֽ��ϴ�.\n��� ID = <%=material_id[i]%>, ������ = <%=beforeAmount%>, ���ŷ� = <%=intAmount[i]%>\n���Ÿ� ����ϰ� �ŷ�ó �������� ���ư��ϴ�.');location.replace('info_customer_account.jsp')</script><%
						} else if (beforeAmount < intAmount[i]) {
							intAmount[i] = intAmount[i] - beforeAmount;
							sellAmount[i] = resultTrade.getInt(2);
							if(intAmount[i] > sellAmount[i]){
								%><script>alert('�Ǹŷ����� ���� ���� �Է��� ��ᰡ �ֽ��ϴ�.\n��� ID = <%=material_id[i]%>, �Ǹŷ� = <%=resultTrade.getInt(2)%>, ���ŷ� = <%=intAmount[i]%>\n���Ÿ� ����ϰ� �ŷ�ó �������� ���ư��ϴ�.');location.replace('info_customer_account.jsp')</script><%
							}
							checkBuy++;
						}
					}
				}
			}
			if(checkBuy == 0){
				%><script>alert('������ ��ᰡ �����ϴ�.\n�ŷ�ó ���� ȭ������ ���ư��ϴ�.');location.replace('info_customer_account.jsp')</script><%
			}
			int totalPrice = 0;
			for (int i = 0 ;i <count;i++){
				totalPrice = totalPrice + (intAmount[i] * Integer.parseInt(stringPrice[i]));
			}
			
			if(customerMoney >= totalPrice){ // �� �������� ����� ���, ��� �ŷ����� �߰�, ��, ������ȸ ������ ��ȭ
				int sellAmountCheck = 0;	// �������� ���� ���� �Է��� ��� Ȯ��
				for(int i = 0; i<count;i++){
					%><script>alert('intA <%=intAmount[i]%>\n sellA <%=sellAmount[i]%>');</script><%
					if(intAmount[i] > 0 && sellAmount[i] > intAmount[i]){
						String insertTrade = "";
						String updateMASell = "";
						
						if(sellAmount[i] > intAmount[i]) {
							sellAmount[i] = sellAmount[i] - intAmount[i];
							updateMASell = "update Material_Sell set Amount = " + sellAmount[i] + " where MagicStore_ID = '" + ms_id + "' and Material_ID = '" + material_id[i] + "';";
						} else if (sellAmount[i] == intAmount[i]){
							updateMASell = "delete from Material_Sell where MagicStore_ID = '" + ms_id + "' and Material_ID = '" + material_id[i] + "';";
						}
						stmt.executeUpdate(updateMASell);
						%><script>alert('test2');</script><%
						insertTrade = "insert into material_trade(MagicStore_ID, Customer_ID, Material_ID, Trade_Amount) values('" + ms_id + "', '" + keep_id + "', '" + material_id[i] + "', " + String.valueOf(intAmount[i]) +");";
						stmt.executeUpdate(insertTrade);
						%><script>alert('test3');</script><%
						sellAmountCheck = 1;
					}
				}
				if(sellAmountCheck == 1){
					msMoney += totalPrice;
					customerMoney -= totalPrice;
					String updateMoney = "update MagicStore set Money = " + String.valueOf(msMoney) + " where MagicStore_ID = '" + ms_id + "';";
					stmt.executeUpdate(updateMoney);
					%><script>alert('test4');</script><%
					updateMoney = "update Customer set Money = " + String.valueOf(customerMoney) + " where Customer_ID = '" + keep_id + "';";
					stmt.executeUpdate(updateMoney);
					%><script>alert('test5');</script><%
					%><script>alert('��� ���Ÿ� �Ϸ��Ͽ����ϴ�.\n���� �ݾ� = <%=totalPrice%>\n���� ������ = <%=customerMoney%>');location.replace('info_customer_account.jsp');</script><%
				} else {	// ������ ����� ���� ���
					%><script>alert('������ ��ᰡ �����ϴ�.');location.replace('info_customer_account.jsp');</script><%
				}
			} else { // ���� �������� ������ ���
				%><script>alert('<%=keep_id%> ���� �������� �����մϴ�.\n���� �ݾ� = <%=totalPrice%>\n���� ������ = <%=customerMoney%>');location.replace('info_customer_account.jsp');</script><%
			}
		} catch(SQLException e){
			e.printStackTrace();
			%><script>alert('test6');</script><%
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} else {
		%><script>alert('�߸� �Է��ϼ̰ų� ������ ��ᰡ �����ϴ�.\n�ŷ�ó ���� ȭ������ ���ư��ϴ�.');location.replace('info_customer_account.jsp');</script><%
	}
	%>
</body>
</html>