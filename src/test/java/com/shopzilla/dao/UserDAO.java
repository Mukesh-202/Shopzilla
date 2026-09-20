
package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT id, name, email, phone, password, role " +
                     "FROM users WHERE email = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    public User findById(int id) throws SQLException {
        String sql = "SELECT id, name, email, phone, password, role " +
                     "FROM users WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    public int create(User user) throws SQLException {
        String sql = "INSERT INTO users " +
                     "(name, email, phone, password, role) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getPassword());
            statement.setString(5, user.getRole());

            statement.executeUpdate();

            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    user.setId(id);
                    return id;
                }
            }
        }

        return -1;
    }

    public boolean update(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, phone = ?, " +
                     "password = ?, role = ? WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getPassword());
            statement.setString(5, user.getRole());
            statement.setInt(6, user.getId());

            return statement.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;
        }
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT id, name, email, phone, password, role " +
                     "FROM users ORDER BY id DESC";

        List<User> users = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                users.add(mapUser(rs));
            }
        }

        return users;
    }

    public List<User> findByRole(String role) throws SQLException {
        String sql = "SELECT id, name, email, phone, password, role " +
                     "FROM users WHERE role = ? ORDER BY id DESC";

        List<User> users = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, role);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    users.add(mapUser(rs));
                }
            }
        }

        return users;
    }

    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();

        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));

        return user;
    }
}
