package com.kawishka.service;

import java.sql.SQLException;
import java.util.List;

import com.kawishka.dao.BillDAO;
import com.kawishka.model.Bill;
import com.kawishka.model.BillItem;

public class BillService {

    private static BillService instance;
    private BillDAO billDAO;

    private BillService() {
        this.billDAO = new BillDAO();
    }

    public static BillService getInstance() {
        if (instance == null) {
            synchronized (BillService.class) {
                if (instance == null) {
                    instance = new BillService();
                }
            }
        }
        return instance;
    }

    public int createBill(Bill bill, List<BillItem> items) throws SQLException {
        int billId = billDAO.createBill(bill);
        
        if (billId != -1) {
            for (BillItem item : items) {
                item.setBillId(billId);
                billDAO.addBillItem(item);
            }
        }
        
        return billId;
    }

    public List<Bill> getBillsByCustomer(int customerId) throws SQLException {
        return billDAO.getBillsByCustomer(customerId);
    }
    
    public Bill getBillById(int billId) throws SQLException {
        return billDAO.getBillById(billId);
    }
    
    public void updateBillStatus(int billId, String status) throws SQLException {
        billDAO.updateBillStatus(billId, status);
    }
    
    public List<Bill> getAllBills() throws SQLException {
        return billDAO.getAllBills();
    }
}