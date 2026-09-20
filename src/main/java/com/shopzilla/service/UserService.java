package com.shopzilla.service;

import com.shopzilla.dao.UserDAO;
import com.shopzilla.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public User login(String email, String password) {

        if (email == null || password == null) {
            return null;
        }

        email = email.trim().toLowerCase();

        User user = userDAO.findByEmail(email);

        if (user == null) {
            return null;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            return null;
        }

        return user;
    }

    public boolean register(User user) {

        if (user == null) {
            return false;
        }

        if (user.getName() == null
                || user.getEmail() == null
                || user.getPassword() == null) {
            return false;
        }

        String email = user.getEmail().trim().toLowerCase();

        if (email.isEmpty()
                || user.getPassword().length() < 6) {
            return false;
        }

        if (userDAO.findByEmail(email) != null) {
            return false;
        }

        user.setEmail(email);

        String hashedPassword =
                BCrypt.hashpw(
                        user.getPassword(),
                        BCrypt.gensalt(12)
                );

        user.setPassword(hashedPassword);

        if (user.getRole() == null
                || user.getRole().trim().isEmpty()) {
            user.setRole("BUYER");
        }

        return userDAO.createUser(user);
    }

    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    public User getUserByEmail(String email) {

        if (email == null) {
            return null;
        }

        return userDAO.findByEmail(
                email.trim().toLowerCase()
        );
    }

    public java.util.List<User> getAllUsers() {
        return userDAO.findAll();
    }

    public boolean updateUserStatus(int userId, String status) {

        if (status == null || status.trim().isEmpty()) {
            return false;
        }

        return userDAO.updateStatus(
                userId,
                status.trim().toUpperCase()
        );
    }

    public boolean updateUser(User user) {

        if (user == null) {
            return false;
        }

        return userDAO.updateUser(user);
    }

    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}