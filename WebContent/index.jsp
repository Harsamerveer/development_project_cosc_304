<!DOCTYPE html>
<html>
<head>   
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="index.css">
   <title>Mondo Books</title>
</head>
<body>
	
<div class="container">

	<nav>
		<ul>
			<li><a href="listprod.jsp">Begin Shopping</a></li>
			<li><a href="listorder.jsp">List All Orders</a></li>
			<li><a href="customer.jsp">My Profile</a></li>
			<li><a href="admin.jsp">Administrators</a></li>
			<li><a href="logout.jsp">Log out</a></li>
		</ul>
		<button class="btn"> <a href="login.jsp">Login </a></button>
	</nav>

	<nav>
		<img src="img/logotypemon.png" alt="Mondo Books" class="logo">
		<li><div class = "searchform">
			<form method="get" action="listprod.jsp">
			<input type="text" placeholder="Search  " name="productName" size="50">
			<!-- <input type="submit" value="Go"> -->
		</form>
	</div>
	</li>
	</nav>



	<div class ="content">
	
		
		<h1>Books in our heritage language</h1>
		<p><br> Mondo means "World" in Esperanto. <br><br>  When you pick a book from Mondo, you join us in perserving languages in this world.</p>
		
	</div>
</div>
</body>
</html>