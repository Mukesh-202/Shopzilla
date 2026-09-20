
package com.shopzilla.model;

public class Product {

    private int id;
    private int sellerId;

    private String name;
    private String category;
    private String subcategory;
    private String description;

    private double price;
    private double mrp;

    private int stock;

    private String sku;
    private String imageUrl;
    private String status;

    public Product() {
    }

    public Product(
            int id,
            int sellerId,
            String name,
            String category,
            String subcategory,
            String description,
            double price,
            double mrp,
            int stock,
            String sku,
            String imageUrl,
            String status) {

        this.id = id;
        this.sellerId = sellerId;
        this.name = name;
        this.category = category;
        this.subcategory = subcategory;
        this.description = description;
        this.price = price;
        this.mrp = mrp;
        this.stock = stock;
        this.sku = sku;
        this.imageUrl = imageUrl;
        this.status = status;
    }

    public Product(
            int sellerId,
            String name,
            String category,
            String subcategory,
            String description,
            double price,
            double mrp,
            int stock,
            String sku,
            String imageUrl,
            String status) {

        this.sellerId = sellerId;
        this.name = name;
        this.category = category;
        this.subcategory = subcategory;
        this.description = description;
        this.price = price;
        this.mrp = mrp;
        this.stock = stock;
        this.sku = sku;
        this.imageUrl = imageUrl;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(String subcategory) {
        this.subcategory = subcategory;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {

        return "Product{" +
                "id=" + id +
                ", sellerId=" + sellerId +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                ", subcategory='" + subcategory + '\'' +
                ", price=" + price +
                ", mrp=" + mrp +
                ", stock=" + stock +
                ", sku='" + sku + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
