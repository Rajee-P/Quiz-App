<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Enter Quiz Code</title>
</head>
<body>
    <h1>Attempt Quiz</h1>
    <form action="AttemptQuizServlet" method="post">
        <label for="quiz_id">Enter Quiz Code:</label>
        <input type="text" id="quiz_id" name="quiz_id" required maxlength="7">
        <button type="submit">Submit</button>
    </form>
</body>
</html>