import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBTest {

    // Change "testdb" to your actual database name
    private static final String URL = "jdbc:mysql://localhost:3306/student";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static void main(String[] args) {
        System.out.println("Attempting to connect to the database...");

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            if (conn != null) {
                System.out.println("✅ Database connection successful!");
            } else {
                System.out.println("❌ Failed to connect to the database.");
            }
        } catch (SQLException e) {
            System.out.println("❌ Connection error: " + e.getMessage());
        }
    }
}
