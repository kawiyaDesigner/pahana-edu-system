package com.kawishka.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import com.kawishka.model.Bill;
import com.kawishka.model.BillItem;
import com.kawishka.model.Customer;
import com.kawishka.model.Item;

public class BillDAO {
    
    public int createBill(Bill bill) {
        String query = "INSERT INTO Bills (customer_id, bill_date, due_date, total_amount, status) VALUES (?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            statement.setInt(1, bill.getCustomerId());
            statement.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
            statement.setDate(3, new java.sql.Date(bill.getDueDate().getTime()));
            statement.setDouble(4, bill.getTotalAmount());
            statement.setString(5, bill.getStatus());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }
    
    public void addBillItem(BillItem billItem) {
        String query = "INSERT INTO Bill_Items (bill_id, item_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, billItem.getBillId());
            statement.setInt(2, billItem.getItemId());
            statement.setInt(3, billItem.getQuantity());
            statement.setDouble(4, billItem.getUnitPrice());
            statement.setDouble(5, billItem.getSubtotal());
            
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Bill> getBillsByCustomer(int customerId) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String query = "SELECT b.*, c.name as customer_name, c.account_number " +
                       "FROM Bills b " +
                       "JOIN Customers c ON b.customer_id = c.customer_id " +
                       "WHERE b.customer_id = ? ORDER BY b.bill_date DESC";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                int billId = resultSet.getInt("bill_id");
                Date billDate = resultSet.getDate("bill_date");
                Date dueDate = resultSet.getDate("due_date");
                double totalAmount = resultSet.getDouble("total_amount");
                String status = resultSet.getString("status");
                
                Bill bill = new Bill(billId, customerId, billDate, dueDate, totalAmount, status);
                
                // Create a minimal customer object for display
                Customer customer = new Customer();
                customer.setName(resultSet.getString("customer_name"));
                customer.setAccountNumber(resultSet.getString("account_number"));
                bill.setCustomer(customer);
                
                bills.add(bill);
            }
        }
        return bills;
    }
    
    public Bill getBillById(int billId) throws SQLException {
        String query = "SELECT b.*, c.name as customer_name, c.account_number, c.address, c.telephone " +
                       "FROM Bills b " +
                       "JOIN Customers c ON b.customer_id = c.customer_id " +
                       "WHERE b.bill_id = ?";
        Bill bill = null;
        
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, billId);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int customerId = resultSet.getInt("customer_id");
                Date billDate = resultSet.getDate("bill_date");
                Date dueDate = resultSet.getDate("due_date");
                double totalAmount = resultSet.getDouble("total_amount");
                String status = resultSet.getString("status");
                
                bill = new Bill(billId, customerId, billDate, dueDate, totalAmount, status);
                
                // Create a customer object for display
                Customer customer = new Customer();
                customer.setCustomerId(customerId);
                customer.setName(resultSet.getString("customer_name"));
                customer.setAccountNumber(resultSet.getString("account_number"));
                customer.setAddress(resultSet.getString("address"));
                customer.setTelephone(resultSet.getString("telephone"));
                bill.setCustomer(customer);
                
                // Get bill items
                bill.setItems(getBillItems(billId));
            }
        }
        return bill;
    }
    
    public List<BillItem> getBillItems(int billId) throws SQLException {
        List<BillItem> items = new ArrayList<>();
        String query = "SELECT bi.*, i.name as item_name, i.description " +
                       "FROM Bill_Items bi " +
                       "JOIN Items i ON bi.item_id = i.item_id " +
                       "WHERE bi.bill_id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setInt(1, billId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                int billItemId = resultSet.getInt("bill_item_id");
                int itemId = resultSet.getInt("item_id");
                int quantity = resultSet.getInt("quantity");
                double unitPrice = resultSet.getDouble("unit_price");
                double subtotal = resultSet.getDouble("subtotal");
                
                BillItem billItem = new BillItem(billItemId, billId, itemId, quantity, unitPrice, subtotal);
                
                // Create an item object for display
                Item item = new Item();
                item.setName(resultSet.getString("item_name"));
                item.setDescription(resultSet.getString("description"));
                billItem.setItem(item);
                
                items.add(billItem);
            }
        }
        return items;
    }
    
    public void updateBillStatus(int billId, String status) throws SQLException {
        String query = "UPDATE Bills SET status = ? WHERE bill_id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, status);
            statement.setInt(2, billId);
            statement.executeUpdate();
        }
    }
    
    public List<Bill> getAllBills() throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String query = "SELECT b.*, c.name as customer_name, c.account_number " +
                       "FROM Bills b " +
                       "JOIN Customers c ON b.customer_id = c.customer_id " +
                       "ORDER BY b.bill_date DESC";

        try (Connection connection = DBConnectionFactory.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int billId = resultSet.getInt("bill_id");
                int customerId = resultSet.getInt("customer_id");
                Date billDate = resultSet.getDate("bill_date");
                Date dueDate = resultSet.getDate("due_date");
                double totalAmount = resultSet.getDouble("total_amount");
                String status = resultSet.getString("status");
                
                Bill bill = new Bill(billId, customerId, billDate, dueDate, totalAmount, status);
                
                // Create a minimal customer object for display
                Customer customer = new Customer();
                customer.setName(resultSet.getString("customer_name"));
                customer.setAccountNumber(resultSet.getString("account_number"));
                bill.setCustomer(customer);
                
                bills.add(bill);
            }
        }
        return bills;
    }
}