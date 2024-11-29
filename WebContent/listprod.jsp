<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Harsamerveer singh Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Connection parameters
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);Statement stmt = con.createStatement();) {
     
	String SQL = "SELECT * FROM product WHERE productName LIKE ?";
	PreparedStatement pstmt = con.prepareStatement(SQL);
	
	// Append `%` to the name variable for partial matching
	pstmt.setString(1, "%" + name + "%");
	
	ResultSet rst = pstmt.executeQuery();

  
// For each product in the ResultSet
    while (rst.next()) {
        
		String productName = rst.getString("productName");
		double productPrice = rst.getDouble("productPrice");	
		String productId = rst.getString("productId");	

		String addToCartLink = "addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;
		
		String productpage = "product.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;
		%>
		<div>
			<a href="<%= productpage %>"><%= productName %></a>
			<p>Price: $<%= productPrice %></p>
			<a href="<%= addToCartLink %>">Add to cart</a>
		</div>
	<%
    }

	ResultSet rst1 = stmt.executeQuery("select * from product;");
	%>
	<table border="2">
	<tr><th>Product Name</th><th> Price</th></tr>

	<%
    while (rst1.next()) {
		String productId = rst1.getString("productId");
        String productName = rst1.getString("productName");
		String productPrice = rst1.getString("productPrice");
		String productpage = "product.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;
		String addToCartLink = "addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;

		%>
		
			<tr>
				<td>
					<a href="<%= productpage %>"><%= productName %></a>
				</td>
			
				<td>
					 $<%= productPrice %>
				</td>
			
				<td>
					<a href="<%= addToCartLink %>">Add to cart</a>
				</td>
			</tr>
			
		
		<%
	}
	%>
	</table>
	<%
	con.close();
}
catch (SQLException ex) {
    out.println("SQLException: " + ex);
	
}
%>

</body>
</html>