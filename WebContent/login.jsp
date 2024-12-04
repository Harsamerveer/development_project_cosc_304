<!DOCTYPE html>
<html>
<head>
    <title>Login Screen</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="login.css"> <!-- Link to the new login-specific CSS -->
</head>
<body>
    <div class="login-container">
	
		<button class="btn"><a href="index.jsp"><img src="img/back.png"> </a></button>
		<img src="img/logotypemon.png" alt="Mondo Books" class="logo">
		
        <h3>Sign in to your account</h3>
        <% 
        // Display any login messages
        if (session.getAttribute("loginMessage") != null)
            out.println("<p class='error-message'>" + session.getAttribute("loginMessage").toString() + "</p>");
        %>
		<form name="MyForm" method="post" action="validateLogin.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" maxlength="10" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" maxlength="10" required>
			<a href="forgot-password.jsp" class="forgot-password">Forgot your password?</a>
            <input type="submit" name="Submit2" value="Log In">
        </form>
        <h4>New to Mondo?  <a href="create-account.jsp">Create account</a></h6
    </div>
</body>
</html>
