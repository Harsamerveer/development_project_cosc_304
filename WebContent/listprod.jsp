<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Search</title>
</head>
<body>

    <h1>Search for the products you want to buy:</h1>


	<form method="get" action="listprod.jsp">
		<input type="text" name="productName" size="50">
		<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
	</form>
	
	<% 
	// Get product name to search for
	String name = request.getParameter("productName");
	
	// Load SQL Server driver
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " + e);
	}
	
	// Connection parameters
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=bookstore;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";
	
	try (Connection con = DriverManager.getConnection(url, uid, pw)) {
		String SQL = "SELECT * FROM product WHERE productName LIKE ?";
		PreparedStatement pstmt = con.prepareStatement(SQL);
		
		// If no search term is provided, fetch all products
		if (name == null || name.trim().isEmpty()) {
			pstmt.setString(1, "%");
		} else {
			pstmt.setString(1, "%" + name + "%");
		}
		
		ResultSet rst = pstmt.executeQuery();
	%>
	
	<table border="2">
		<tr><th>Product Name</th><th>Price</th><th>Actions</th></tr>
		<%
		// Display the filtered results in the table
		while (rst.next()) {
			String productId = rst.getString("productId");
			String productName = rst.getString("productName");
			double productPrice = rst.getDouble("productPrice");
			
			String productPage = "product.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;
			String addToCartLink = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;
		%>
		<tr>
			<td><a href="<%= productPage %>"><%= productName %></a></td>
			<td>$<%= productPrice %></td>
			<td><a href="<%= addToCartLink %>">Add to cart</a></td>
		</tr>
		<%
		}
		%>
	</table>
	
	<%
		con.close();
	} catch (SQLException ex) {
		out.println("SQLException: " + ex);
	}
	%>
	
	</body>
	</html>
 
