<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>
    <form action="ForgetPasswordServlet" method="POST">
        <label for="email">Enter your email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>