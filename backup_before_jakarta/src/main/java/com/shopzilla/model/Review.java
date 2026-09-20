
package com.shopzilla.model;

public class Review {

    private int id;
    private int userId;
    private int productId;

    private int rating;
    private String title;
    private String comment;
    private String createdAt;

    private String userName;
    private String productName;

    public Review() {
    }

    public Review(
            int id,
            int userId,
            int productId,
            int rating,
            String title,
            String comment,
            String createdAt) {

        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.title = title;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public Review(
            int userId,
            int productId,
            int rating,
            String title,
            String comment) {

        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.title = title;
        this.comment = comment;
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

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", rating=" + rating +
                ", title='" + title + '\'' +
                ", comment='" + comment + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
