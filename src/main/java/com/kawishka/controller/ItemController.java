package com.kawishka.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kawishka.model.Item;
import com.kawishka.service.ItemService;

@WebServlet("/item")
public class ItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ItemService itemService;
     
    public void init() throws ServletException {
        itemService = ItemService.getInstance();
    }
    
    private void deleteItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        itemService.deleteItem(itemId);
        response.sendRedirect("item?action=list");
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Item itemToEdit = itemService.getItemById(id);
            request.setAttribute("item", itemToEdit);
            request.getRequestDispatcher("WEB-INF/view/editItem.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String category = request.getParameter("category");

        Item item = new Item();
        item.setItemId(id);
        item.setName(name);
        item.setPrice(price);
        item.setDescription(description);
        item.setStockQuantity(stockQuantity);
        item.setCategory(category);

        itemService.updateItem(item);
        response.sendRedirect("item?action=list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            listItems(request, response);
        } else if (action.equals("add")) {
            showAddForm(request, response);
        } else if (action.equals("delete")) {
            try {
                deleteItem(request, response);
            } catch (SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
            }
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
         String action = request.getParameter("action");
            if (action.equals("add")) {
                addItem(request, response);
            } else if (action.equals("update")) {
                try {
                    updateItem(request, response);
                } catch (SQLException e) {
                    request.setAttribute("errorMessage", e.getMessage());
                    request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
                }
            }
    }
    
     private void listItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            
         List<Item> itemList = new ArrayList<Item>();
            try {
                itemList = itemService.getAllItems();
                request.setAttribute("items", itemList);
            } catch ( SQLException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("WEB-INF/view/error.jsp").forward(request, response);
                return;
            }
            
            request.getRequestDispatcher("WEB-INF/view/listItems.jsp").forward(request, response);
        }

        private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getRequestDispatcher("WEB-INF/view/addItem.jsp").forward(request, response);
        }

        private void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            String category = request.getParameter("category");
            
            Item item = new Item();
            item.setName(name);
            item.setPrice(price);
            item.setDescription(description);
            item.setStockQuantity(stockQuantity);
            item.setCategory(category);
            
            itemService.addItem(item);
            response.sendRedirect("item?action=list");
        }
}