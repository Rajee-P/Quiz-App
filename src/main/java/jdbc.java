import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbc {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:postgresql://localhost:5432/QuizApp";
        String user = "postgres";
        String password = "mahaswin";

        Connection connection = null;
            Class.forName("org.postgresql.Driver");

            connection = DriverManager.getConnection(url, user, password);

            if (connection != null)
                System.out.println("Connected to the PostgreSQL server successfully!");
            else
                System.out.println("Failed to connect to the PostgreSQL server.");


            String query = "SELECT * FROM admin";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("admin_id");
                String name = resultSet.getString("admin_name");
                String email = resultSet.getString("email");
                String passwd = resultSet.getString("pass");

                System.out.println("Admin Details:");
                System.out.println("ID: " + id);
                System.out.println("Name: " + name);
                System.out.println("Email: " + email);
                System.out.println("Password: "+passwd);
            }


            if (connection != null) {
                connection.close();
                System.out.println("Connection closed.");
            }
        }
    }


