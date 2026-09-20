package com.shopzilla.service;

import com.shopzilla.dao.CartDAO;
import com.shopzilla.dao.ProductDAO;
import com.shopzilla.model.Cart;
import com.shopzilla.model.Product;

import java.sql.SQLException;
import java.util.List;

public class CartService {

    private final CartDAO cartDAO;
    private final ProductDAO productDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
        this.productDAO = new ProductDAO();
    }

    public List<Cart> getCart(int userId) throws SQLException {

        if (userId <= 0) {
            return List.of();
        }

        return cartDAO.findByUserId(userId);
    }

    public Cart getCartItem(
            int userId,
            int productId) throws SQLException {

        if (userId <= 0 || productId <= 0) {
            return null;
        }

        return cartDAO.findItem(userId, productId);
    }

    public boolean addToCart(
            int userId,
            int productId,
            int quantity) throws SQLException {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        Product product = productDAO.findById(productId);

        if (product == null) {
            return false;
        }

        if (!"APPROVED".equalsIgnoreCase(product.getStatus())) {
            return false;
        }

        if (product.getStock() < quantity) {
            return false;
        }

        Cart existing = cartDAO.findItem(userId, productId);

        if (existing != null) {

            int newQuantity =
                    existing.getQuantity() + quantity;

            if (newQuantity > product.getStock()) {
                return false;
            }
        }

        return cartDAO.addItem(
                userId,
                productId,
                quantity
        );
    }

    public boolean updateQuantity(
            int userId,
            int productId,
            int quantity) throws SQLException {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        Product product = productDAO.findById(productId);

        if (product == null) {
            return false;
        }

        if (quantity > product.getStock()) {
            return false;
        }

        return cartDAO.updateQuantity(
                userId,
                productId,
                quantity
        );
    }

    public boolean removeFromCart(
            int userId,
            int productId) throws SQLException {

        if (userId <= 0 || productId <= 0) {
            return false;
        }

        return cartDAO.removeItem(
                userId,
                productId
        );
    }

    public boolean removeCartItem(
            int cartId,
            int userId) throws SQLException {

        if (cartId <= 0 || userId <= 0) {
            return false;
        }

        return cartDAO.removeById(
                cartId,
                userId
        );
    }

    public void clearCart(int userId) throws SQLException {

        if (userId <= 0) {
            return;
        }

        cartDAO.clearCart(userId);
    }

    public int getCartCount(int userId) throws SQLException {

        if (userId <= 0) {
            return 0;
        }

        return cartDAO.getCartCount(userId);
    }

    public double getCartTotal(int userId) throws SQLException {

        if (userId <= 0) {
            return 0.0;
        }

        return cartDAO.getCartTotal(userId);
    }
}