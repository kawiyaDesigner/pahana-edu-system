package com.kawishka.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kawishka.model.Item;

public class ItemDAO {
    
    public void addItem(Item item) {
        String query = "INSERT INTO Items (name, price, description, stock_quantity, category) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, item.getName());
            statement.setDouble(2, item.getPrice());
            statement.setString(3, item.getDescription());
            statement.setInt(4, item.getStockQuantity());
            statement.setString(5, item.getCategory());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Item> getAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM Items";

        try (Connection connection = DBConnectionFactory.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("item_id");
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");
                String desc = resultSet.getString("description");
                int stockQuantity = resultSet.getInt("stock_quantity");
                String category = resultSet.getString("category");
                items.add(new Item(id, name, desc, price, stockQuantity, category));
            }
        }
        return items;
    }

    public void deleteItem(int itemId) throws SQLException {
        String query = "DELETE FROM Items WHERE item_id = ?";
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, itemId);
            statement.executeUpdate();
        }
    }
    
    public void updateItem(Item item) throws SQLException {
        String query = "UPDATE Items SET name = ?, price = ?, description = ?, stock_quantity = ?, category = ? WHERE item_id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, item.getName());
            statement.setDouble(2, item.getPrice());
            statement.setString(3, item.getDescription());
            statement.setInt(4, item.getStockQuantity());
            statement.setString(5, item.getCategory());
            statement.setInt(6, item.getItemId());

            statement.executeUpdate();
        }
    }
    
    public Item getItemById(int itemId) throws SQLException {
        String query = "SELECT * FROM Items WHERE item_id = ?";
        Item item = null;
        
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, itemId);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int id = resultSet.getInt("item_id");
                String name = resultSet.getString("name");
                double price = resultSet.getDouble("price");
                String desc = resultSet.getString("description");
                int stockQuantity = resultSet.getInt("stock_quantity");
                String category = resultSet.getString("category");
                item = new Item(id, name, desc, price, stockQuantity, category);
            }
        }
        return item;
    }
}