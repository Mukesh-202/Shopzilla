package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(
            int userId,
            double totalAmount,
            String status,
            String paymentMethod,
            String shippingAddress) throws SQLException {

        String sql =
                "INSERT INTO orders " +
                "(user_id, total_amount, status, payment_method, shipping_address) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, userId);
            statement.setDouble(2, totalAmount);
            statement.setString(3, status);
            statement.setString(4, paymentMethod);
            statement.setString(5, shippingAddress);

            statement.executeUpdate();

            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return -1;
    }

    public boolean addOrderItem(
            int orderId,
            int productId,
            int quantity,
            double price) throws SQLException {

        String sql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);
            statement.setInt(2, productId);
            statement.setInt(3, quantity);
            statement.setDouble(4, price);

            return statement.executeUpdate() > 0;
        }
    }

    public Order findById(int id) throws SQLException {

        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapOrder(rs);
                }
            }
        }

        return null;
    }

    public List<Order> findByUserId(int userId) throws SQLException {

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }

        return orders;
    }

    public List<Order> findAll() throws SQLException {

        String sql =
                "SELECT * FROM orders ORDER BY id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        }

        return orders;
    }

    public boolean updateStatus(
            int orderId,
            String status) throws SQLException {

        String sql =
                "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            return statement.executeUpdate() > 0;
        }
    }

    public List<Order> findBySeller(int sellerId) throws SQLException {

        String sql =
                "SELECT DISTINCT o.* " +
                "FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE p.seller_id = ? " +
                "ORDER BY o.id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, sellerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }

        return orders;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {

        Order order = new Order();

        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setCreatedAt(rs.getString("created_at"));

        return order;
    }
}