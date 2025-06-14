import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/QuizApp";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "mahaswin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username1 = request.getParameter("username");
        String email1 = request.getParameter("email");
        String password1 = request.getParameter("password");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("org.postgresql.Driver");

            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO admin (admin_name, email, pass) VALUES (?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username1);
            preparedStatement.setString(2, email1);
            preparedStatement.setString(3, password1);

            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<h3>Signup successful!</h3>");
                out.println("<a href='Login.jsp'>Go to Login Page</a>");
            } else {
                out.println("<h3>Signup failed! Please try again.</h3>");
            }
        } catch (ClassNotFoundException e) {
            out.println("<h3>Error: PostgreSQL JDBC Driver not found!</h3>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h3>Database error: Unable to insert data.</h3>");
            out.println("Error: "+e);
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
