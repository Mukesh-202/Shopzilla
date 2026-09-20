package com.shopzilla.service;

import com.shopzilla.dao.OrderDAO;
import com.shopzilla.model.Order;

import java.util.List;

public class OrderService {

    private final OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<Order> getOrdersByUser(int userId) {
        if (userId <= 0) {
            return java.util.Collections.emptyList();
        }

        return orderDAO.findByUser(userId);
    }

    public Order getOrderById(int orderId) {
        if (orderId <= 0) {
            return null;
        }

        return orderDAO.findById(orderId);
    }

    public List<Order> getSellerOrders(int sellerId) {
        if (sellerId <= 0) {
            return java.util.Collections.emptyList();
        }

        return orderDAO.findBySeller(sellerId);
    }

    public List<Order> getAllOrders() {
        return orderDAO.findAll();
    }

    public boolean updateOrderStatus(
            int orderId,
            String status) {

        if (orderId <= 0
                || status == null
                || status.trim().isEmpty()) {
            return false;
        }

        return orderDAO.updateStatus(
                orderId,
                status.trim().toUpperCase()
        );
    }

    public boolean checkout(int userId) {

        if (userId <= 0) {
            return false;
        }

        return orderDAO.createOrderFromCart(userId);
    }
}