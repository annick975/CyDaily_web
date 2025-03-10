package com.example.cydaily_new.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Database connection is not initialized.");
        }
    }

    public boolean save(User user) {
        String query = "INSERT INTO users (name, role, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getRole());
            stmt.setString(3, user.getPassword());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error inserting user into database.");
            e.printStackTrace();
            return false;
        }
    }

    public User getUser(String name, String password) {
        String query = "SELECT * FROM users WHERE name = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, password);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return new User(
                        resultSet.getString("name"),
                        resultSet.getString("role"),
                        resultSet.getString("password")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user from database.");
            e.printStackTrace();
        }
        return null;
    }
}