package com.kawishka.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kawishka.model.Bill;
import com.kawishka.model.BillItem;
import com.kawishka.model.Customer;
import com.kawishka.model.Item;
import com.kawishka.service.BillService;
import com.kawishka.service.CustomerService;
import com.kawishka.service.ItemService;

@WebServlet("/bill")
public class BillController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BillService billService;
    private CustomerService customerService;
    private ItemService itemService;
     
    public void init() throws ServletException {
        billService = BillService.getInstance();
        customerService = CustomerService.getInstance();
        itemService = ItemService.getInstance();
    }
    
    private void viewBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        try {
            Bill bill = billService.getBillById(billId);
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("WEB-INF/view/viewBill.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Customer> customers = customerService.getAllCustomers();
            List<Item> items = itemService.getAllItems();
            
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            request.getRequestDispatcher("WEB-INF/view/createBill.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }
    
    private void getCustomerBills(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        try {
            List<Bill> bills = billService.getBillsByCustomer(customerId);
            Customer customer = customerService.getCustomerById(customerId);
            
            request.setAttribute("bills", bills);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("WEB-INF/view/customerBills.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }
    
    private void updateBillStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int billId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        
        billService.updateBillStatus(billId, status);
        response.sendRedirect("bill?action=view&id=" + billId);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            listBills(request, response);
        } else if (action.equals("create")) {
            showCreateForm(request, response);
        } else if (action.equals("view")) {
            viewBill(request, response);
        } else if (action.equals("customer")) {
            getCustomerBills(request, response);
        } else if (action.equals("updateStatus")) {
            try {
                updateBillStatus(request, response);
            } catch (SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action.equals("create")) {
            createBill(request, response);
        }
    }
    
    private void listBills(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Bill> bills = billService.getAllBills();
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("WEB-INF/view/listBills.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }
    
    private void createBill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String billDateStr = request.getParameter("billDate");
            String dueDateStr = request.getParameter("dueDate");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date billDate = dateFormat.parse(billDateStr);
            Date dueDate = dateFormat.parse(dueDateStr);
            
            // Get item data from form
            String[] itemIds = request.getParameterValues("itemId");
            String[] quantities = request.getParameterValues("quantity");
            
            List<BillItem> billItems = new ArrayList<>();
            double totalAmount = 0;
            
            // Process each item
            for (int i = 0; i < itemIds.length; i++) {
                int itemId = Integer.parseInt(itemIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                
                if (quantity > 0) {
                    Item item = itemService.getItemById(itemId);
                    double unitPrice = item.getPrice();
                    double subtotal = unitPrice * quantity;
                    
                    BillItem billItem = new BillItem();
                    billItem.setItemId(itemId);
                    billItem.setQuantity(quantity);
                    billItem.setUnitPrice(unitPrice);
                    billItem.setSubtotal(subtotal);
                    
                    billItems.add(billItem);
                    totalAmount += subtotal;
                }
            }
            
            // Create the bill
            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setBillDate(billDate);
            bill.setDueDate(dueDate);
            bill.setTotalAmount(totalAmount);
            bill.setStatus("PENDING");
            
            int billId = billService.createBill(bill, billItems);
            
            if (billId != -1) {
                response.sendRedirect("bill?action=view&id=" + billId);
            } else {
                request.setAttribute("errorMessage", "Failed to create bill");
                showCreateForm(request, response);
            }
            
        } catch (SQLException | ParseException e) {
            request.setAttribute("errorMessage", e.getMessage());
            showCreateForm(request, response);
        }
    }
}