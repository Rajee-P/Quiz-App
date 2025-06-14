<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Admin</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header */
        header {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
        }

        /* Left Sidebar (Dashboard) */
        .dashboard-container {
            position: fixed;
            top: 50px;
            left: 0;
            width: 250px;
            height: calc(100% - 50px);
            background-color: #ffffff;
            box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        .dashboard-container h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            width: 40px;
        }

        .dashboard-buttons {
            display: flex;
            flex-direction: column;
        }

        .dashboard-buttons button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 10px 0;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: left;
        }

        .dashboard-buttons button:hover {
            background-color: #218838;
        }

        /* Main Content */
        .container {
            margin-left: 270px; /* Space for the dashboard container */
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .create-quiz-btn {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 20px 50px;
            font-size: 24px;
            border-radius: 5px;
            cursor: pointer;
            margin: 30px 0;
        }

        h3{
            display: flex;
            font-style: Calibri;
        }

        .create-quiz-btn:hover {
            background-color: #0056b3;
        }

        /* Footer */
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>
    <header>
        Quiz Master - Admin
    </header>

    <div class="dashboard-container">
        <h3>Dashboard</h3>
        <div class="dashboard-buttons">
            <button onclick="location.href='QuizHistory.jsp'">Previous Quizzes</button>
            <button onclick="location.href='MarkHistory.jsp'">Student Marks</button>
            <button onclick="location.href='logout.jsp'">Logout</button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Create Quiz Button -->
        <h3>As Albert Einstein famously said, "The important thing is not to stop questioning. Curiosity has its own reason for existing." Whether for education, entertainment, or self-assessment, quizzes challenge our minds and inspire growth in a creative and dynamic way.</h3>
        <button class="create-quiz-btn" onclick="location.href='Quiz.jsp'">Create New Quiz</button>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2024 QuizMaster. All rights reserved.
    </footer>
</body>
</html>
