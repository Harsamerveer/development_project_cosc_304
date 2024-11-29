<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Group 14 - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productName = request.getParameter("name");
String productId = request.getParameter("id");
String productPrice = request.getParameter("price");

try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
} catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
}

// Connection parameters
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);
     Statement stmt = con.createStatement()) {


String sql = "select * from product where productId = ?";

PreparedStatement pstmt = con.prepareStatement(sql);  

pstmt.setString(1,productId);  

ResultSet rs = pstmt.executeQuery();

while (rs.next()) {
    String addToCartLink = "addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;


    %>
		<div>
            <p>Product Id: <%= productId %></p>
			<p>Product Name: <%= productName %></p>
			<p>Price: $<%= productPrice %></p>
            <%
            // Retrieve the productImageURL from the ResultSet
            String productImageURL = rs.getString("productImageURL"); 
            if (productImageURL != null && !productImageURL.isEmpty()) {
            %>
            <img src="<%= productImageURL %>" alt="Product Image" />
            
            <img src="displayImage.jsp?id=<%= productId %>" alt="Product Image" />
         
            <% 
            }            
            %> 
            <br>
            <br>
            <a href="<%= addToCartLink %>">Add to cart</a>
            <h5><a href="listprod.jsp">Continue Shopping</a></h5>
		</div>
	<%
}

rs.close();
con.close();
} catch (SQLException ex) {
ex.printStackTrace();
out.println("SQLException: " + ex.getMessage());
} 



%>

</body>
</html>

