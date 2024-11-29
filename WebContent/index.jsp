<!DOCTYPE html>
<html>
<head>    
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="index.css">
	<scipt>

	</scipt>
        <title>Group 14 Grocery Store Main Page</title>
</head>
<body>
<h1 align="center">Welcome to Group 14 Grocery Store </h1>

<div>

<h2 align="center"><a href="login.jsp">Login</a></h2>

</div>
<div>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

</div>
<div>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

</div>
<div>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

</div>
<div>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

</div>
<div>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

</div>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>
</head>


