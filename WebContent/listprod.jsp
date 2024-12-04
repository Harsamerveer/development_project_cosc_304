<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bookstore - Product List</title>
</head>
<body>

    <h1>Search for Products:</h1>
    <form method="get" action="listprod.jsp">
        <input type="text" name="productName" size="50">
        <input type="submit" value="Search">
        <input type="reset" value="Reset">
        <span>(Leave blank to view all products)</span>
    </form>

    <%
    String name = request.getParameter("productName");
    try {
        // Load SQL Server driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (ClassNotFoundException e) {
        out.println("Database Driver Error: " + e.getMessage());
        return; // Stop execution if the driver is missing
    }

    String url = String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=bookstore;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    try (Connection con = DriverManager.getConnection(url, uid, pw)) {
        String sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        
        if (name == null || name.trim().isEmpty()) {
            pstmt.setString(1, "%"); // Search for all products
        } else {
            pstmt.setString(1, "%" + name + "%"); // Search for matching products
        }
        
        ResultSet rs = pstmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>Product Name</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        <%
        while (rs.next()) {
            String productId = rs.getString("productId");
            String productName = rs.getString("productName");
            double productPrice = rs.getDouble("productPrice");
            
            String productPage = "product.jsp?id=" + productId;
            String addToCartLink = "addcart.jsp?id=" + productId;
        %>
        <tr>
            <td><a href="<%= productPage %>"><%= productName %></a></td>
            <td>$<%= String.format("%.2f", productPrice) %></td>
            <td><a href="<%= addToCartLink %>">Add to Cart</a></td>
        </tr>
        <%
        }
        %>
    </table>
    <%
    } catch (SQLException ex) {
        out.println("Database Error: " + ex.getMessage());
    }
    %>
</body>
</html>
