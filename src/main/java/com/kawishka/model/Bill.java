package com.kawishka.model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private Date billDate;
    private Date dueDate;
    private double totalAmount;
    private String status;
    private List<BillItem> items;
    private Customer customer; // For display purposes
    
    public Bill() {
    }

    public Bill(int billId, int customerId, Date billDate, Date dueDate, 
                double totalAmount, String status) {
        this.billId = billId;
        this.customerId = customerId;
        this.billDate = billDate;
        this.dueDate = dueDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
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

    public List<BillItem> getItems() {
        return items;
    }

    public void setItems(List<BillItem> items) {
        this.items = items;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}