package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Cart;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<Cart> findByUserId(int userId) throws SQLException {

        String sql =
                "SELECT c.id, c.user_id, c.product_id, c.quantity, " +
                "p.name AS product_name, p.price, p.mrp, p.image_url " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ? " +
                "ORDER BY c.id DESC";

        List<Cart> cartItems = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    cartItems.add(mapCart(rs));
                }
            }
        }

        return cartItems;
    }

    public Cart findItem(int userId, int productId)
            throws SQLException {

        String sql =
                "SELECT c.id, c.user_id, c.product_id, c.quantity, " +
                "p.name AS product_name, p.price, p.mrp, p.image_url " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ? AND c.product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return mapCart(rs);
                }
            }
        }

        return null;
    }

    public boolean addItem(int userId, int productId, int quantity)
            throws SQLException {

        String sql =
                "INSERT INTO cart (user_id, product_id, quantity) " +
                "VALUES (?, ?, ?) " +
                "ON CONFLICT(user_id, product_id) " +
                "DO UPDATE SET quantity = quantity + excluded.quantity";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);
            statement.setInt(3, quantity);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean updateQuantity(
            int userId,
            int productId,
            int quantity) throws SQLException {

        String sql =
                "UPDATE cart SET quantity = ? " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, userId);
            statement.setInt(3, productId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean removeItem(
            int userId,
            int productId) throws SQLException {

        String sql =
                "DELETE FROM cart " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean removeById(int cartId, int userId)
            throws SQLException {

        String sql =
                "DELETE FROM cart " +
                "WHERE id = ? AND user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, userId);

            return statement.executeUpdate() > 0;
        }
    }

    public void clearCart(int userId) throws SQLException {

        String sql = "DELETE FROM cart WHERE user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            statement.executeUpdate();
        }
    }

    public int getCartCount(int userId) throws SQLException {

        String sql =
                "SELECT COALESCE(SUM(quantity), 0) " +
                "FROM cart WHERE user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    public double getCartTotal(int userId) throws SQLException {

        String sql =
                "SELECT COALESCE(SUM(c.quantity * p.price), 0) " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }

        return 0.0;
    }

    private Cart mapCart(ResultSet rs) throws SQLException {

        Cart cart = new Cart();

        cart.setId(rs.getInt("id"));
        cart.setUserId(rs.getInt("user_id"));
        cart.setProductId(rs.getInt("product_id"));
        cart.setQuantity(rs.getInt("quantity"));
        cart.setProductName(rs.getString("product_name"));
        cart.setPrice(rs.getDouble("price"));
        cart.setMrp(rs.getDouble("mrp"));
        cart.setImageUrl(rs.getString("image_url"));

        return cart;
    }
}