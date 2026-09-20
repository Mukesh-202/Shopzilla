package com.shopzilla.service;

import com.shopzilla.dao.CartDAO;
import com.shopzilla.model.Cart;

import java.util.Collections;
import java.util.List;

public class CartService {

    private final CartDAO cartDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
    }

    // Get all cart items for a user
    public List<Cart> getCartItems(int userId) {

        if (userId <= 0) {
            return Collections.emptyList();
        }

        return cartDAO.findByUser(userId);
    }

    // Compatibility method for existing CartServlet
    public List<Cart> getCart(int userId) {

        return getCartItems(userId);
    }

    // Get one cart item using user ID and product ID
    public Cart getCartItem(int userId, int productId) {

        if (userId <= 0 || productId <= 0) {
            return null;
        }

        return cartDAO.findByUserAndProduct(userId, productId);
    }

    // Add product to cart
    public boolean addToCart(
            int userId,
            int productId,
            int quantity) {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        Cart existing =
                cartDAO.findByUserAndProduct(
                        userId,
                        productId
                );

        // Product already exists in cart
        if (existing != null) {

            int newQuantity =
                    existing.getQuantity() + quantity;

            return cartDAO.updateQuantity(
                    existing.getId(),
                    newQuantity
            );
        }

        // New cart item
        Cart cart = new Cart();

        cart.setUserId(userId);
        cart.setProductId(productId);
        cart.setQuantity(quantity);

        return cartDAO.create(cart);
    }

    // Update cart item using cart ID
    public boolean updateQuantity(
            int cartId,
            int quantity) {

        if (cartId <= 0 || quantity <= 0) {
            return false;
        }

        return cartDAO.updateQuantity(
                cartId,
                quantity
        );
    }

    // Compatibility method for existing CartServlet
    // Uses user ID + product ID
    public boolean updateQuantity(
            int userId,
            int productId,
            int quantity) {

        if (userId <= 0 ||
                productId <= 0 ||
                quantity <= 0) {

            return false;
        }

        Cart cart =
                cartDAO.findByUserAndProduct(
                        userId,
                        productId
                );

        if (cart == null) {
            return false;
        }

        return updateQuantity(
                cart.getId(),
                quantity
        );
    }

    // Remove cart item using cart ID
    public boolean removeFromCart(int cartId) {

        if (cartId <= 0) {
            return false;
        }

        return cartDAO.delete(cartId);
    }

    // Compatibility method for existing CartServlet
    // Uses user ID + product ID
    public boolean removeFromCart(
            int userId,
            int productId) {

        if (userId <= 0 || productId <= 0) {
            return false;
        }

        Cart cart =
                cartDAO.findByUserAndProduct(
                        userId,
                        productId
                );

        if (cart == null) {
            return false;
        }

        return removeFromCart(
                cart.getId()
        );
    }

    // Clear entire cart
    public boolean clearCart(int userId) {

        if (userId <= 0) {
            return false;
        }

        return cartDAO.deleteByUser(userId);
    }

    // Get total number of products in cart
    public int getCartCount(int userId) {

        if (userId <= 0) {
            return 0;
        }

        return cartDAO.getCartCount(userId);
    }

    // Get total cart price
    public double getCartTotal(int userId) {

        if (userId <= 0) {
            return 0.0;
        }

        return cartDAO.getCartTotal(userId);
    }
}