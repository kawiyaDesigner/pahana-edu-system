package com.kawishka.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kawishka.model.Customer;

public class CustomerDAO {
    
    public void addCustomer(Customer customer) {
        String query = "INSERT INTO Customers (account_number, name, address, telephone, email, registration_date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, customer.getAccountNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getTelephone());
            statement.setString(5, customer.getEmail());
            statement.setDate(6, new java.sql.Date(customer.getRegistrationDate().getTime()));
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customers ORDER BY customer_id DESC";

        try (Connection connection = DBConnectionFactory.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("customer_id");
                String accountNumber = resultSet.getString("account_number");
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telephone = resultSet.getString("telephone");
                String email = resultSet.getString("email");
                java.util.Date registrationDate = resultSet.getDate("registration_date");
                
                customers.add(new Customer(id, accountNumber, name, address, telephone, email, registrationDate));
            }
        }
        return customers;
    }

    public void deleteCustomer(int customerId) throws SQLException {
        String query = "DELETE FROM Customers WHERE customer_id = ?";
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, customerId);
            statement.executeUpdate();
        }
    }
    
    public void updateCustomer(Customer customer) throws SQLException {
        String query = "UPDATE Customers SET account_number = ?, name = ?, address = ?, telephone = ?, email = ? WHERE customer_id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, customer.getAccountNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getTelephone());
            statement.setString(5, customer.getEmail());
            statement.setInt(6, customer.getCustomerId());

            statement.executeUpdate();
        }
    }
    
    public Customer getCustomerById(int customerId) throws SQLException {
        String query = "SELECT * FROM Customers WHERE customer_id = ?";
        Customer customer = null;
        
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int id = resultSet.getInt("customer_id");
                String accountNumber = resultSet.getString("account_number");
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telephone = resultSet.getString("telephone");
                String email = resultSet.getString("email");
                java.util.Date registrationDate = resultSet.getDate("registration_date");
                
                customer = new Customer(id, accountNumber, name, address, telephone, email, registrationDate);
            }
        }
        return customer;
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException {
        String query = "SELECT * FROM Customers WHERE account_number = ?";
        Customer customer = null;
        
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, accountNumber);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int id = resultSet.getInt("customer_id");
                String accNumber = resultSet.getString("account_number");
                String name = resultSet.getString("name");
                String address = resultSet.getString("address");
                String telephone = resultSet.getString("telephone");
                String email = resultSet.getString("email");
                java.util.Date registrationDate = resultSet.getDate("registration_date");
                
                customer = new Customer(id, accNumber, name, address, telephone, email, registrationDate);
            }
        }
        return customer;
    }
    
    public boolean accountNumberExists(String accountNumber) throws SQLException {
        String query = "SELECT COUNT(*) FROM Customers WHERE account_number = ?";
        
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, accountNumber);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        }
        return false;
    }
}