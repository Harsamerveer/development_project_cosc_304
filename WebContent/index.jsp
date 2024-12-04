<!DOCTYPE html>
<html>
<head>   
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="index.css">
   <title>Mondo Books</title>
   <script>
       // JavaScript function to toggle the dropdown
       function myFunction() {
           document.getElementById("myDropdown").classList.toggle("show");
       }

       // Close the dropdown if the user clicks anywhere outside of it
       window.onclick = function(event) {
           if (!event.target.matches('.dropbtn')) {
               var dropdowns = document.getElementsByClassName("dropdown-content");
               for (var i = 0; i < dropdowns.length; i++) {
                   var openDropdown = dropdowns[i];
                   if (openDropdown.classList.contains('show')) {
                       openDropdown.classList.remove('show');
                   }
               }
           }
       }
   </script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

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

    <div style="display: flex; justify-content: center; align-items: center; height: 100px; text-align: center;">
        <%
        // Display current user login information
        String userName = (String) session.getAttribute("authenticatedUser");
        if (userName != null) {
            out.println("<p style='color: white; font-family: \"Poppins\", sans-serif; font-weight: 100; font-size: 30px;'>Welcome, " + userName + "</p>");
        }
        %>
    </div>

    <nav>
        <img src="img/logotypemon.png" alt="Mondo Books" class="logo">
        <li>
            <div class="searchform">
                <form method="get" action="listprod.jsp">
                    <input type="text" placeholder="Search" name="productName" size="50">
                </form>
            </div>
        </li>
        <!-- Dropdown for Language Selection -->
        <div class="dropdown">
            <button onclick="myFunction()" class="dropbtn">Select Language</button>
            <div id="myDropdown" class="dropdown-content">
                <a href="#">Arabic</a>
				<a href="#">Bengali</a>
				<a href="#">Chinese</a>
				<a href="#">Dutch</a>
				<a href="#">German</a>
				<a href="#">Hindi</a>
                <a href="#">Korean</a>
                <a href="#">Japanese</a>
				<a href="#">Panjabi</a>
				<a href="#">Sanskrit</a>
				<a href="#">Tibetan</a>
				<a href="#">Tibetan (Amdo)</a>
            </div>
        </div>
    </nav>

    <div class="content">
        <h1>Books in our heritage language</h1>
        <p><br> Mondo means "World" in Esperanto. <br><br> When you pick a book from Mondo, you join us in preserving languages in this world.</p>
    </div>
</div>
</body>
</html>
