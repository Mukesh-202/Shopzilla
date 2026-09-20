package com.shopzilla.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfig {

    private static final String HOST = System.getenv("DB_HOST");
    private static final String PORT = System.getenv("DB_PORT");
    private static final String DATABASE = System.getenv("DB_NAME");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    private DatabaseConfig() {
    }

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE
                + "?sslMode=REQUIRED"
                + "&serverTimezone=UTC";

        return DriverManager.getConnection(url, USER, PASSWORD);
    }
}