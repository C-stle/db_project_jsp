<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>
#div_top {
	weight: 100%;
	background-color: #0000FF;
	text-align: center;
}
</style>
</head>
<body>
<%!
public static void InsertTableData(Statement stmt, String file_name) {
	
	try {
		String url = "D:\\git-repository\\db_project\\" + file_name + ".txt";
		File file = new File(url);
		FileReader filereader = new FileReader(file);
		BufferedReader bufReader = new BufferedReader(filereader);
		String line = "";
		while((line = bufReader.readLine()) != null){
            stmt.executeUpdate(line);
        }
		bufReader.close();
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch(IOException e){
        e.printStackTrace();
    } finally {
		
	}
}

%>
<%
	String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
	String dbUser = "root";
	String dbPass = "maria12";
	
	String create_table_magician = // 마법사
			"CREATE TABLE IF NOT EXISTS Magician("
			+ "Magician_ID varchar(20) NOT NULL primary key, "
			+ "Magician_Password varchar(20) NOT NULL, "
			+ "Magician_Name varchar(20), "
			+ "Age int, "
			+ "Species varchar(20), "
			+ "Country_Of_Origin varchar(20), "
			+ "Job varchar(20), "
			+ "Magician_Class int, "
			+ "Magician_Attribute varchar(20), "
			+ "Mana int, "
			+ "Money int);";
	
	String create_table_magic = // 마법
			"CREATE TABLE IF NOT EXISTS Magic("
			+ "Magic_ID varchar(20) NOT NULL, "
			+ "Name varchar(20), "
			+ "Explaination varchar(100), "
			+ "Magic_Class int, "
			+ "Magic_Attribute varchar(20), "
			+ "Type varchar(20), "
			+ "Effective_Dose int, "
			+ "Mana_Consumption int, "
			+ "Price int, "
			+ "Creator_ID varchar(20) NOT NULL, "
			+ "PRIMARY KEY (Magic_ID), "
			+ "FOREIGN KEY (Creator_ID) REFERENCES Magician(Magician_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_material = // 재료
			"CREATE TABLE IF NOT EXISTS Material("
			+ "Material_ID varchar(20) NOT NULL primary key, "
			+ "Name varchar(20), "
			+ "Country_Of_Origin varchar(20), "
			+ "material_Type varchar(20), "
			+ "Price int);";
	
	String create_table_magic_store = // 마법상회
			"Create TABLE IF NOT EXISTS MagicStore("
			+ "MagicStore_ID varchar(20) NOT NULL primary key, "
			+ "MagicStore_Password varchar(20), "
			+ "Company_Name varchar(20), "
			+ "Address varchar(100), "
			+ "Representative varchar(20), "
			+ "License_Class int, "
			+ "Money int)";
	
	String create_table_customer = // 소비자
			"CREATE TABLE IF NOT EXISTS Customer("
			+ "Customer_ID varchar(20) NOT NULL primary key, "
			+ "Customer_Password varchar(20), "
			+ "Name varchar(20), "
			+ "Age int, "
			+ "Address varchar(20), "
			+ "Attribute varchar(20), "
			+ "Money int);";
	
	String create_table_material_use = // 마법에 사용할 재료
			"CREATE TABLE IF NOT EXISTS Material_Use("
			+ "Magic_ID varchar(20) NOT NULL, "
			+ "Material_ID varchar(20) NOT NULL, "
			+ "Amount_Used int, "
			+ "PRIMARY KEY (Material_ID, Magic_ID), "
			+ "FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Magic_ID) REFERENCES Magic(Magic_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_customer_account = // 고객 거래처
			"CREATE TABLE IF NOT EXISTS Customer_Account("
			+ "Customer_ID varchar(20) NOT NULL, "
			+ "MagicStore_ID varchar(20) NOT NULL, "
			+ "PRIMARY KEY (Customer_ID, MagicStore_ID), "
			+ "FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (MagicStore_ID) REFERENCES MagicStore(MagicStore_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_magician_belong = // 마법사 소속
			"CREATE TABLE IF NOT EXISTS Magician_Belong("
			+ "Magician_ID varchar(20) NOT NULL, "
			+ "MagicStore_ID varchar(20) NOT NULL, "
			+ "PRIMARY KEY (Magician_ID, MagicStore_ID), "
			+ "FOREIGN KEY (Magician_ID) REFERENCES Magician(Magician_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (MagicStore_ID) REFERENCES MagicStore(MagicStore_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_material_sell = // 재료 판매
			"CREATE TABLE IF NOT EXISTS Material_Sell("
			+ "MagicStore_ID varchar(20) NOT NULL, "
			+ "Material_ID varchar(20) NOT NULL, "
			+ "Amount int, "
			+ "PRIMARY KEY (MagicStore_ID, Material_ID), "
			+ "FOREIGN KEY (MagicStore_ID) REFERENCES MagicStore(MagicStore_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_magic_trade =
			"CREATE TABLE IF NOT EXISTS Magic_Trade("
			+ "Trade_Number int NOT NULL AUTO_INCREMENT, "
			+ "MagicStore_ID varchar(20) NOT NULL, "
			+ "Customer_ID varchar(20) NOT NULL, "
			+ "Magic_ID varchar(20) NOT NULL, "
			+ "PRIMARY KEY (Trade_Number), "
			+ "FOREIGN KEY (MagicStore_ID) REFERENCES MagicStore(MagicStore_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Magic_ID) REFERENCES Magic(Magic_ID) ON UPDATE CASCADE ON DELETE CASCADE);";
	
	String create_table_material_trade =
			"CREATE TABLE IF NOT EXISTS Material_Trade("
			+ "Trade_Number int NOT NULL AUTO_INCREMENT, "
			+ "MagicStore_ID varchar(20) NOT NULL, "
			+ "Customer_ID varchar(20) NOT NULL, "
			+ "Material_ID varchar(20) NOT NULL, "
			+ "Trade_Amount int, "
			+ "PRIMARY KEY (Trade_Number), "
			+ "FOREIGN KEY (MagicStore_ID) REFERENCES MagicStore(MagicStore_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE, "
			+ "FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID) ON UPDATE CASCADE ON DELETE CASCADE);";	
	
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
		
		stmt.executeQuery(create_table_magician);
		stmt.executeQuery(create_table_magic);
		stmt.executeQuery(create_table_material);
		stmt.executeQuery(create_table_magic_store);
		stmt.executeQuery(create_table_customer);
		
		stmt.executeQuery(create_table_material_use);
		stmt.executeQuery(create_table_customer_account);
		stmt.executeQuery(create_table_magician_belong);
		stmt.executeQuery(create_table_material_sell);
		stmt.executeQuery(create_table_magic_trade);
		stmt.executeQuery(create_table_material_trade);
		
		String check = "select * from Magic;";
		result = stmt.executeQuery(check);
		if(!result.next()){
			
			InsertTableData(stmt, "insert_magician");
			InsertTableData(stmt, "insert_magic");
			InsertTableData(stmt, "insert_magicstore");
			InsertTableData(stmt, "insert_material");
			InsertTableData(stmt, "insert_customer");
			
			InsertTableData(stmt, "insert_customer_account");
			InsertTableData(stmt, "insert_magician_belong");
			InsertTableData(stmt, "insert_material_sell");
			InsertTableData(stmt, "insert_material_use");
			
			System.out.println("DB 데이터 삽입 완료");
		}
		
		System.out.println("DB 저장 완료");
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		
	}

%>
	<div id="div_top">
		<h1>LoDoS</h1>
	</div>
	<div>
		<form action="login_check.jsp" method="post">
			<div>
				<input type="radio" name="kind" value="Magician" checked>Magician
				<input type="radio" name="kind" value="MagicStore">MagicStore
				<input type="radio" name="kind" value="Customer">Customer
			</div>
			<div>
			아이디 : <input name="id" type="text" required="">
			</div>
			<div>
			비밀번호 : <input name="password" type="password" required="" />
			</div>
			<%
			if(session.getAttribute("kind") == null){
				%>
				<BR>
				<%
			} else if ((int)session.getAttribute("kind") == 1){
				%>
				<p> 등록된 아이디가 없습니다.
				<%
				session.removeAttribute("kind");
			} else if ((int)session.getAttribute("kind") == 2){
				%>
				<p> 잘못된 비밀 번호 입니다.
				<%
				session.removeAttribute("kind");
			}
			
			%>
			<div>
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='register.jsp'">
			</div>
		</form>
	</div>

<%
	if(session.getAttribute("id") != null){
		session.removeAttribute("id");
	}

%>
</body>
</html>