
package com.shopzilla.model;

public class Cart {

    private int id;
    private int userId;
    private int productId;
    private int quantity;

    private String productName;
    private double price;
    private double mrp;
    private String imageUrl;

    public Cart() {
    }

    public Cart(
            int id,
            int userId,
            int productId,
            int quantity) {

        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public Cart(
            int userId,
            int productId,
            int quantity) {

        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public Cart(
            int id,
            int userId,
            int productId,
            int quantity,
            String productName,
            double price,
            double mrp,
            String imageUrl) {

        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.productName = productName;
        this.price = price;
        this.mrp = mrp;
        this.imageUrl = imageUrl;
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

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getMrp() {
        return mrp;
    }

    public void setMrp(double mrp) {
        this.mrp = mrp;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getTotalPrice() {
        return price * quantity;
    }

    @Override
    public String toString() {

        return "Cart{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                '}';
    }
}