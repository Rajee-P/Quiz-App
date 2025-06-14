import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CreateQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dbURL = "jdbc:postgresql://localhost:5432/QuizApp";
        String dbUser = "postgres";
        String dbPassword = "mahaswin";

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin_id") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        int adminId = (int) session.getAttribute("admin_id");
        String quizCode = request.getParameter("quizID");
        String quizName = request.getParameter("quizName");

        if (quizCode == null || quizCode.isEmpty() || quizName == null || quizName.isEmpty() ) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required.");
            return;
        }


        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            conn.setAutoCommit(false);

            String insertQuizSQL = "INSERT INTO quiz (admin_id, quiz_id, quiz_name) VALUES (?, ?, ?)";
            try (PreparedStatement quizStmt = conn.prepareStatement(insertQuizSQL)) {
                quizStmt.setInt(1, adminId);
                quizStmt.setString(2, quizCode);
                quizStmt.setString(3, quizName);
                quizStmt.executeUpdate();
            }

            // Retrieve questions and marks
            String[] questions = request.getParameterValues("question[]");
            String[] marksArray = request.getParameterValues("marks[]");

            if (questions == null || marksArray == null || questions.length != marksArray.length) {
                throw new IllegalArgumentException("Questions and marks are not properly provided.");
            }


            int questionId = 0;
            for (int i = 0; i < questions.length; i++) {
                questionId++;
                String questionText = questions[i];
                int marks;

                try {
                    marks = Integer.parseInt(marksArray[i]);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Marks must be a valid number for each question.");
                }

                String insertQuestionSQL = "INSERT INTO questions (quiz_id, question_id, question_text, marks) VALUES (?, ?, ?, ?)";
                try (PreparedStatement questionStmt = conn.prepareStatement(insertQuestionSQL)) {
                    questionStmt.setString(1, quizCode);
                    questionStmt.setInt(2, questionId);
                    questionStmt.setString(3, questionText);
                    questionStmt.setInt(4, marks);
                    questionStmt.executeUpdate();
                }

                String[] options = request.getParameterValues("options-" + (i + 1) + "[]");
                String[] correctFlags = request.getParameterValues("correct-" + (i + 1) + "[]");

                if (options == null || options.length > 4) {
                    throw new IllegalArgumentException("Each question must have between 1 to 4 options.");
                }

                // Insert options
                for (int j = 0; j < options.length; j++) {
                    boolean isCorrect = false;
                    if (correctFlags != null) {
                        for (String correctFlag : correctFlags) {
                            if (correctFlag.equals(String.valueOf(j + 1))) {
                                isCorrect = true;
                                break;
                            }
                        }
                    }

                    String insertOptionSQL = "INSERT INTO options (quiz_id, question_id, option_id, option_text, is_correct) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement optionStmt = conn.prepareStatement(insertOptionSQL)) {
                        optionStmt.setString(1, quizCode);
                        optionStmt.setInt(2, questionId);
                        optionStmt.setInt(3, j + 1);
                        optionStmt.setString(4, options[j]);
                        optionStmt.setBoolean(5, isCorrect);
                        optionStmt.executeUpdate();
                    }
                }
            }

            conn.commit();
            response.getWriter().println("Quiz created successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        }
    }
}