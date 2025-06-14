<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String quizID = java.util.UUID.randomUUID().toString().substring(0, 7).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Quiz</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        h2 {
            color: #007bff;
            text-align: center;
            font-size: 1.25rem;
            margin-bottom: 30px;
        }

        label {
            font-size: 1rem;
            color: #555;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        textarea {
            resize: vertical;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .question-container {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .question-container h3 {
            font-size: 1.25rem;
            color: #333;
            margin-bottom: 15px;
        }

        .option-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .option-row input[type="text"] {
            flex: 1;
            margin-right: 10px;
            padding: 8px;
            font-size: 1rem;
        }

        .delete-button {
            color: red;
            cursor: pointer;
            font-size: 0.9rem;
            margin-left: 10px;
            transition: color 0.3s ease;
        }

        .delete-button:hover {
            color: darkred;
        }

        #questions {
            margin-top: 20px;
        }

        #questions button {
            background-color: #28a745;
        }

        #questions button:hover {
            background-color: #218838;
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
        }

        .form-actions button {
            width: 100%;
            font-size: 1.25rem;
            padding: 15px;
        }

        .form-actions button[type="submit"] {
            background-color: #28a745;
        }

        .form-actions button[type="submit"]:hover {
            background-color: #218838;
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>Create Quiz</h1>
        <h2>Quiz Code: <span style="color: #007bff;"><%= quizID %></span></h2>

        <!-- Form to enter quiz name and timer -->
        <form id="quiz-form" action="CreateQuizServlet" method="post">
            <input type="hidden" name="quizID" value="<%= quizID %>">

            <label for="quiz-name">Enter Quiz Name:</label>
            <input type="text" id="quiz-name" name="quizName" required>

            <div id="questions">
                <!-- Default first question -->
                <div class="question-container" id="question-1">
                    <h3>Question 1</h3>
                    <label for="question-1-text">Enter Question:</label>
                    <textarea id="question-1-text" name="question[]" rows="2" required></textarea>

                    <label for="marks-1">Marks:</label>
                    <input type="number" id="marks-1" name="marks[]" min="1" required>

                    <div id="options-1" class="options">
                        <div class="option-row" id="option-1-1">
                            <input type="text" name="options-1[]" placeholder="Enter option" required>
                            <input type="checkbox" name="correct-1[]" value="1">
                            <label>Correct Option</label>
                            <span class="delete-button" onclick="deleteOption(1, 1)">Delete Option</span>
                        </div>
                    </div>
                    <button type="button" onclick="addOption(1)">Add Option</button>
                    <span class="delete-button" onclick="deleteQuestion(1)">Delete Question</span>
                </div>
            </div>
            <button type="button" onclick="addQuestion()">Add Question</button>
            <div class="form-actions">
                <button type="submit">Submit Quiz</button>
            </div>
        </form>
    </div>

    <script>
        let questionCount = 1;
        let optionCount = { 1: 1 }; // Initialize with the first question

        // Automatically update the hidden quiz name field when the user types in the quiz name
        document.getElementById('quiz-name').addEventListener('input', function() {
            document.querySelector('input[name="quizName"]').value = this.value;
        });

        function addQuestion() {
            questionCount++;
            optionCount[questionCount] = 1;

            let questionContainer = document.createElement('div');
            questionContainer.className = 'question-container';
            questionContainer.id = 'question-' + questionCount;
            questionContainer.innerHTML = `
                <h3>Question ${questionCount}</h3>
                <label for="question-${questionCount}-text">Enter Question:</label>
                <textarea id="question-${questionCount}-text" name="question[]" rows="2" required></textarea>

                <label for="marks-${questionCount}">Marks:</label>
                <input type="number" id="marks-${questionCount}" name="marks[]" min="1" required>

                <div id="options-${questionCount}" class="options">
                    <div class="option-row" id="option-${questionCount}-1">
                        <input type="text" name="options-${questionCount}[]" placeholder="Enter option" required>
                        <input type="checkbox" name="correct-${questionCount}[]" value="1">
                        <label>Correct Option</label>
                        <span class="delete-button" onclick="deleteOption(${questionCount}, 1)">Delete Option</span>
                    </div>
                </div>
                <button type="button" onclick="addOption(${questionCount})">Add Option</button>
                <span class="delete-button" onclick="deleteQuestion(${questionCount})">Delete Question</span>
            `;

            document.getElementById('questions').appendChild(questionContainer);
        }

        function addOption(questionNum) {
            optionCount[questionNum]++;
            let optionId = optionCount[questionNum];
            let optionsDiv = document.getElementById('options-' + questionNum);

            let optionRow = document.createElement('div');
            optionRow.className = 'option-row';
            optionRow.id = 'option-' + questionNum + '-' + optionId;
            optionRow.innerHTML = `
                <input type="text" name="options-${questionNum}[]" placeholder="Enter option" required>
                <input type="checkbox" name="correct-${questionNum}[]" value="${optionId}">
                <label>Correct Option</label>
                <span class="delete-button" onclick="deleteOption(${questionNum}, ${optionId})">Delete Option</span>
            `;
            optionsDiv.appendChild(optionRow);
        }

        function deleteOption(questionNum, optionId) {
            let optionRow = document.getElementById('option-' + questionNum + '-' + optionId);
            optionRow.parentNode.removeChild(optionRow);

            // Renumber options after deleting one
            let optionsDiv = document.getElementById('options-' + questionNum);
            let options = optionsDiv.querySelectorAll('.option-row');
            options.forEach((option, index) => {
                option.id = 'option-' + questionNum + '-' + (index + 1); // Reassign option IDs
            });
        }

        function deleteQuestion(questionNum) {
            let questionContainer = document.getElementById('question-' + questionNum);
            questionContainer.parentNode.removeChild(questionContainer);

            // Renumber remaining questions
            let allQuestions = document.querySelectorAll('.question-container');
            allQuestions.forEach((question, index) => {
                let newQuestionNum = index + 1;
                question.querySelector('h3').textContent = 'Question ' + newQuestionNum;
                question.id = 'question-' + newQuestionNum;

                // Renumber options inside this question
                let optionsDiv = question.querySelector('.options');
                let options = optionsDiv.querySelectorAll('.option-row');
                options.forEach((option, optionIndex) => {
                    option.id = 'option-' + newQuestionNum + '-' + (optionIndex + 1);
                });
            });

            // Update questionCount accordingly
            questionCount--;
        }
    </script>
</body>
</html>
