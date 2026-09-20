package com.shopzilla.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfig {

    private static final String DATABASE_URL =
            "jdbc:mysql://localhost:3306/shopzilla"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=Asia/Kolkata";

    private static final String DATABASE_USER = "root";

    /*
     * IMPORTANT:
     * Replace YOUR_MYSQL_PASSWORD with the password
     * you use when running:
     *
     * mysql -u root -p
     */
    private static final String DATABASE_PASSWORD =
            "Mukesh@123";

    private DatabaseConfig() {
        // Prevent object creation
    }

    public static Connection getConnection()
            throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC Driver not found.",
                    e
            );
        }

        return DriverManager.getConnection(
                DATABASE_URL,
                DATABASE_USER,
                DATABASE_PASSWORD
        );
    }
}