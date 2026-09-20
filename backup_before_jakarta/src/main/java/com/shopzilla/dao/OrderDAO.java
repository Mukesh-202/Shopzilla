package com.shopzilla.dao;

import com.shopzilla.config.DatabaseConfig;
import com.shopzilla.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class OrderDAO {

    public Order findById(int orderId) {

        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapOrder(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Order> findByUser(int userId) {

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> findBySeller(int sellerId) {

        String sql =
                "SELECT DISTINCT o.* " +
                "FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE p.seller_id = ? " +
                "ORDER BY o.id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, sellerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> findAll() {

        String sql = "SELECT * FROM orders ORDER BY id DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public boolean updateStatus(int orderId, String status) {

        String sql =
                "UPDATE orders SET status = ? " +
                "WHERE id = ?";

        try (Connection connection = DatabaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createOrderFromCart(int userId) {

        String cartSql =
                "SELECT c.product_id, c.quantity, p.price " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_id = ?";

        String orderSql =
                "INSERT INTO orders " +
                "(user_id, total_amount, status, payment_method, shipping_address) " +
                "VALUES (?, ?, ?, ?, ?)";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

        String clearCartSql =
                "DELETE FROM cart WHERE user_id = ?";

        try (Connection connection = DatabaseConfig.getConnection()) {

            connection.setAutoCommit(false);

            try {
                double totalAmount = 0.0;

                List<CartItem> cartItems = new ArrayList<>();

                try (PreparedStatement statement =
                             connection.prepareStatement(cartSql)) {

                    statement.setInt(1, userId);

                    try (ResultSet rs = statement.executeQuery()) {

                        while (rs.next()) {

                            int productId = rs.getInt("product_id");
                            int quantity = rs.getInt("quantity");
                            double price = rs.getDouble("price");

                            totalAmount += price * quantity;

                            cartItems.add(
                                    new CartItem(
                                            productId,
                                            quantity,
                                            price
                                    )
                            );
                        }
                    }
                }

                if (cartItems.isEmpty()) {
                    connection.rollback();
                    return false;
                }

                int orderId;

                try (PreparedStatement statement =
                             connection.prepareStatement(
                                     orderSql,
                                     Statement.RETURN_GENERATED_KEYS)) {

                    statement.setInt(1, userId);
                    statement.setDouble(2, totalAmount);
                    statement.setString(3, "PROCESSING");
                    statement.setString(4, "COD");
                    statement.setString(5, "Not Provided");

                    statement.executeUpdate();

                    try (ResultSet keys = statement.getGeneratedKeys()) {

                        if (!keys.next()) {
                            connection.rollback();
                            return false;
                        }

                        orderId = keys.getInt(1);
                    }
                }

                try (PreparedStatement statement =
                             connection.prepareStatement(itemSql)) {

                    for (CartItem item : cartItems) {

                        statement.setInt(1, orderId);
                        statement.setInt(2, item.productId);
                        statement.setInt(3, item.quantity);
                        statement.setDouble(4, item.price);

                        statement.addBatch();
                    }

                    statement.executeBatch();
                }

                try (PreparedStatement statement =
                             connection.prepareStatement(clearCartSql)) {

                    statement.setInt(1, userId);
                    statement.executeUpdate();
                }

                connection.commit();
                return true;

            } catch (SQLException e) {

                connection.rollback();
                e.printStackTrace();
                return false;

            } finally {
                connection.setAutoCommit(true);
            }

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
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

    private static class CartItem {

        private final int productId;
        private final int quantity;
        private final double price;

        CartItem(int productId, int quantity, double price) {
            this.productId = productId;
            this.quantity = quantity;
            this.price = price;
        }
    }
}