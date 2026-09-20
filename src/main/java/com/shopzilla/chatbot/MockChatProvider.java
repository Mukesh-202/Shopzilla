package com.shopzilla.chatbot;
public class MockChatProvider implements ChatProvider {
@Override
public String getResponse(String message) {

    if (message == null || message.trim().isEmpty()) {
        return "Hi! How can I help you with Shopzilla?";
    }

    String input = message.trim().toLowerCase();

    if (input.contains("hello")
            || input.contains("hi")
            || input.contains("hey")) {

        return "Hello! Welcome to Shopzilla. How can I help you today?";
    }

    if (input.contains("product")
            || input.contains("products")) {

        return "You can browse our latest products from the Shopzilla product section.";
    }

    if (input.contains("men")) {

        return "You can explore men's fashion including shirts, T-shirts, jeans, trousers and more.";
    }

    if (input.contains("women")) {

        return "You can explore women's fashion including dresses, tops, jeans, footwear and more.";
    }

    if (input.contains("kids")
            || input.contains("kid")) {

        return "You can explore our kids' collection for clothing, footwear and accessories.";
    }

    if (input.contains("cart")) {

        return "You can add products to your cart and update quantity or remove items before checkout.";
    }

    if (input.contains("order")
            || input.contains("orders")) {

        return "You can view your orders from the My Orders section after logging in.";
    }

    if (input.contains("delivery")
            || input.contains("shipping")) {

        return "Shopzilla delivery information will be shown during the checkout process.";
    }

    if (input.contains("return")
            || input.contains("refund")) {

        return "For return or refund assistance, please check the order details or contact Shopzilla support.";
    }

    if (input.contains("payment")
            || input.contains("pay")) {

        return "Shopzilla supports the available checkout payment options shown on the checkout page.";
    }

    if (input.contains("seller")) {

        return "Sellers can add, edit and manage their products through the seller dashboard.";
    }

    if (input.contains("admin")) {

        return "Administrators can manage users, products and orders from the admin dashboard.";
    }

    if (input.contains("help")
            || input.contains("support")) {

        return "I can help you with products, cart, orders, delivery, payments and Shopzilla navigation.";
    }

    return "I'm Shopzilla Assistant. I can help you with products, cart, orders, delivery, payments and account-related questions.";
}
}