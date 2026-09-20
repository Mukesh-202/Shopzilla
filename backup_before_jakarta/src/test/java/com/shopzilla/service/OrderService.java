package com.shopzilla.service;

import com.shopzilla.dao.CartDAO;
import com.shopzilla.dao.OrderDAO;
import com.shopzilla.dao.ProductDAO;
import com.shopzilla.model.Cart;
import com.shopzilla.model.Order;
import com.shopzilla.model.Product;

import java.sql.SQLException;
import java.util.List;

public class OrderService {

    private final OrderDAO orderDAO;
    private final CartDAO cartDAO;
    private final ProductDAO productDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.cartDAO = new CartDAO();
        this.productDAO = new ProductDAO();
    }

    public Order getOrderById(int orderId) throws SQLException {

        if (orderId <= 0) {
            return null;
        }

        return orderDAO.findById(orderId);
    }

    public List<Order> getOrdersByUser(int userId)
            throws SQLException {

        if (userId <= 0) {
            return List.of();
        }

        return orderDAO.findByUserId(userId);
    }

    public List<Order> getAllOrders() throws SQLException {
        return orderDAO.findAll();
    }

    public List<Order> getSellerOrders(int sellerId)
            throws SQLException {

        if (sellerId <= 0) {
            return List.of();
        }

        return orderDAO.findBySeller(sellerId);
    }

    public int checkout(
            int userId,
            String paymentMethod,
            String shippingAddress) throws SQLException {

        if (userId <= 0) {
            return -1;
        }

        if (paymentMethod == null ||
                paymentMethod.trim().isEmpty()) {
            return -1;
        }

        if (shippingAddress == null ||
                shippingAddress.trim().isEmpty()) {
            return -1;
        }

        List<Cart> cartItems =
                cartDAO.findByUserId(userId);

        if (cartItems.isEmpty()) {
            return -1;
        }

        double totalAmount = 0.0;

        for (Cart cart : cartItems) {

            Product product =
                    productDAO.findById(cart.getProductId());

            if (product == null) {
                return -1;
            }

            if (!"APPROVED".equalsIgnoreCase(
                    product.getStatus())) {
                return -1;
            }

            if (cart.getQuantity() <= 0 ||
                    cart.getQuantity() > product.getStock()) {
                return -1;
            }

            totalAmount +=
                    product.getPrice() * cart.getQuantity();
        }

        int orderId = orderDAO.createOrder(
                userId,
                totalAmount,
                "PROCESSING",
                paymentMethod.trim(),
                shippingAddress.trim()
        );

        if (orderId <= 0) {
            return -1;
        }

        for (Cart cart : cartItems) {

            Product product =
                    productDAO.findById(cart.getProductId());

            orderDAO.addOrderItem(
                    orderId,
                    cart.getProductId(),
                    cart.getQuantity(),
                    product.getPrice()
            );

            int remainingStock =
                    product.getStock() - cart.getQuantity();

            product.setStock(remainingStock);

            productDAO.update(product);
        }

        cartDAO.clearCart(userId);

        return orderId;
    }

    public boolean updateOrderStatus(
            int orderId,
            String status) throws SQLException {

        if (orderId <= 0 ||
                status == null ||
                status.trim().isEmpty()) {
            return false;
        }

        String normalizedStatus =
                status.trim().toUpperCase();

        if (!normalizedStatus.equals("PROCESSING") &&
                !normalizedStatus.equals("SHIPPED") &&
                !normalizedStatus.equals("DELIVERED") &&
                !normalizedStatus.equals("CANCELLED")) {
            return false;
        }

        return orderDAO.updateStatus(
                orderId,
                normalizedStatus
        );
    }
}