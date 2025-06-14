import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/QuizApp";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "mahaswin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("org.postgresql.Driver");

            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM admin WHERE admin_name = ? AND pass = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int adminId = resultSet.getInt("admin_id");
                HttpSession session = request.getSession(true);  // Create a new session or use the existing one
                session.setAttribute("admin_id", adminId);      // Store admin_id in the session

                // Redirect to the admin main page
                response.sendRedirect("Admin_Mainpage.jsp");
            } else {
                // Invalid credentials, show an error message
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid Username or Password. Please try again.');");
                out.println("location='Login.jsp';");
                out.println("</script>");
            }
        } catch (ClassNotFoundException e) {
            out.println("<h3>Error: PostgreSQL JDBC Driver not found!</h3>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h3>Database error: Unable to verify login credentials.</h3>");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
