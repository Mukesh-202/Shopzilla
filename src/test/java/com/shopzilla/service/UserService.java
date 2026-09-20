package com.shopzilla.service;

import com.shopzilla.dao.UserDAO;
import com.shopzilla.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;
import java.util.List;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public User login(String email, String password)
            throws SQLException {

        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        if (password == null || password.isEmpty()) {
            return null;
        }

        User user = userDAO.findByEmail(email.trim());

        if (user == null) {
            return null;
        }

        String storedPassword = user.getPassword();

        if (storedPassword == null || storedPassword.isEmpty()) {
            return null;
        }

        if (BCrypt.checkpw(password, storedPassword)) {
            return user;
        }

        return null;
    }

    public boolean register(
            String name,
            String email,
            String phone,
            String password,
            String role) throws SQLException {

        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        if (password == null || password.length() < 6) {
            return false;
        }

        email = email.trim().toLowerCase();

        if (userDAO.emailExists(email)) {
            return false;
        }

        if (role == null ||
                (!role.equalsIgnoreCase("BUYER")
                        && !role.equalsIgnoreCase("SELLER"))) {

            role = "BUYER";
        } else {
            role = role.toUpperCase();
        }

        String hashedPassword = BCrypt.hashpw(
                password,
                BCrypt.gensalt(10)
        );

        User user = new User(
                name.trim(),
                email,
                phone,
                hashedPassword,
                role
        );

        return userDAO.create(user) > 0;
    }

    public User getUserById(int id) throws SQLException {
        return userDAO.findById(id);
    }

    public User getUserByEmail(String email) throws SQLException {

        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        return userDAO.findByEmail(email.trim().toLowerCase());
    }

    public List<User> getAllUsers() throws SQLException {
        return userDAO.findAll();
    }

    public List<User> getUsersByRole(String role)
            throws SQLException {

        return userDAO.findByRole(role);
    }

    public boolean updateUser(User user) throws SQLException {

        if (user == null || user.getId() <= 0) {
            return false;
        }

        return userDAO.update(user);
    }

    public boolean deleteUser(int id) throws SQLException {

        if (id <= 0) {
            return false;
        }

        return userDAO.delete(id);
    }

    public boolean emailExists(String email) throws SQLException {

        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        return userDAO.emailExists(email.trim().toLowerCase());
    }
}