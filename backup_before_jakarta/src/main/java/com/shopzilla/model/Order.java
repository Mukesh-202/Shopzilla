
package com.shopzilla.model;

public class Order {

    private int id;
    private int userId;

    private double totalAmount;

    private String status;
    private String paymentMethod;
    private String shippingAddress;

    private String createdAt;

    public Order() {
    }

    public Order(
            int id,
            int userId,
            double totalAmount,
            String status,
            String paymentMethod,
            String shippingAddress,
            String createdAt) {

        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.createdAt = createdAt;
    }

    public Order(
            int userId,
            double totalAmount,
            String status,
            String paymentMethod,
            String shippingAddress) {

        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {

        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", shippingAddress='" + shippingAddress + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}

