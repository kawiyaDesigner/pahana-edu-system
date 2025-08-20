package com.kawishka.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kawishka.model.Customer;
import com.kawishka.service.CustomerService;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CustomerService customerService;
     
    public void init() throws ServletException {
        customerService = CustomerService.getInstance();
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        customerService.deleteCustomer(customerId);
        response.sendRedirect("customer?action=list");
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Customer customerToEdit = customerService.getCustomerById(id);
            request.setAttribute("customer", customerToEdit);
            request.getRequestDispatcher("WEB-INF/view/editCustomer.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setCustomerId(id);
        customer.setAccountNumber(accountNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setTelephone(telephone);
        customer.setEmail(email);
        customer.setRegistrationDate(new Date()); // Keep the original registration date

        customerService.updateCustomer(customer);
        response.sendRedirect("customer?action=list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            listCustomers(request, response);
        } else if (action.equals("add")) {
            showAddForm(request, response);
        } else if (action.equals("delete")) {
            try {
                deleteCustomer(request, response);
            } catch (SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
            }
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        } else if (action.equals("view")) {
            viewCustomer(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
         String action = request.getParameter("action");
            if (action.equals("add")) {
                addCustomer(request, response);
            } else if (action.equals("update")) {
                try {
                    updateCustomer(request, response);
                } catch (SQLException e) {
                    request.setAttribute("errorMessage", e.getMessage());
                    request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
                }
            }
    }
    
     private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            
         List<Customer> customerList = new ArrayList<Customer>();
            try {
                customerList = customerService.getAllCustomers();
                request.setAttribute("customers", customerList);
            } catch ( SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
                return;
            }
            
            request.getRequestDispatcher("WEB-INF/view/listCustomers.jsp").forward(request, response);
        }
     
     private void viewCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         int id = Integer.parseInt(request.getParameter("id"));
         try {
             Customer customer = customerService.getCustomerById(id);
             request.setAttribute("customer", customer);
             request.getRequestDispatcher("WEB-INF/view/viewCustomer.jsp").forward(request, response);
         } catch (SQLException e) {
             request.setAttribute("errorMessage", e.getMessage());
             request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
         }
     }

        private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getRequestDispatcher("WEB-INF/view/addCustomer.jsp").forward(request, response);
        }

        private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            
            // Check if account number already exists
            try {
                if (customerService.accountNumberExists(accountNumber)) {
                    request.setAttribute("errorMessage", "Account number already exists. Please use a different account number.");
                    request.getRequestDispatcher("WEB-INF/view/addCustomer.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e1) {
                request.setAttribute("errorMessage", "Error checking account number: " + e1.getMessage());
                request.getRequestDispatcher("WEB-INF/view/addCustomer.jsp").forward(request, response);
                return;
            }
            
            Customer customer = new Customer();
            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setTelephone(telephone);
            customer.setEmail(email);
            customer.setRegistrationDate(new Date());
            
            try {
                customerService.addCustomer(customer);
                response.sendRedirect("customer?action=list");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Error adding customer: " + e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/addCustomer.jsp").forward(request, response);
            }
        }
}