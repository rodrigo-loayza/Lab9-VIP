package pe.edu.pucp.vip.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class BaseDao {

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        final String user = "root";
        final String pass = "root";
        final String url = "jdbc:mysql://localhost:3306/lab9";

        return DriverManager.getConnection(url, user, pass);
    }
}