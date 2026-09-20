package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Cart;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<Cart> findByUser(int userId) {

        String sql =
                "SELECT c.id, c.user_id, c.product_id, c.quantity, " +
                "p.name AS product_name, p.price, p.mrp, p.image_url " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ? " +
                "ORDER BY c.id DESC";

        List<Cart> cartItems = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    cartItems.add(mapCart(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    public Cart findByUserAndProduct(int userId, int productId) {

        String sql =
                "SELECT c.id, c.user_id, c.product_id, c.quantity, " +
                "p.name AS product_name, p.price, p.mrp, p.image_url " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ? AND c.product_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapCart(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean create(Cart cart) {

        String sql =
                "INSERT INTO cart (user_id, product_id, quantity) " +
                "VALUES (?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, cart.getUserId());
            statement.setInt(2, cart.getProductId());
            statement.setInt(3, cart.getQuantity());

            int rows = statement.executeUpdate();

            if (rows == 0) {
                return false;
            }

            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    cart.setId(keys.getInt(1));
                }
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateQuantity(int cartId, int quantity) {

        String sql =
                "UPDATE cart SET quantity = ? " +
                "WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, cartId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int cartId) {

        String sql =
                "DELETE FROM cart WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteByUser(int userId) {

        String sql =
                "DELETE FROM cart WHERE user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getCartCount(int userId) {

        String sql =
                "SELECT COALESCE(SUM(quantity), 0) " +
                "FROM cart WHERE user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public double getCartTotal(int userId) {

        String sql =
                "SELECT COALESCE(SUM(c.quantity * p.price), 0) " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
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