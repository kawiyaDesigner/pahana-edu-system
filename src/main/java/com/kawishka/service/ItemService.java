package com.kawishka.service;

import java.sql.SQLException;
import java.util.List;

import com.kawishka.dao.ItemDAO;
import com.kawishka.model.Item;

public class ItemService {

    private static ItemService instance;
    private ItemDAO itemDAO;

    private ItemService() {
        this.itemDAO = new ItemDAO();
    }

    public static ItemService getInstance() {
        if (instance == null) {
            synchronized (ItemService.class) {
                if (instance == null) {
                    instance = new ItemService();
                }
            }
        }
        return instance;
    }

    public void addItem(Item item) {
        itemDAO.addItem(item);
    }

    public List<Item> getAllItems() throws SQLException {
        return itemDAO.getAllItems();
    }
    
    public void deleteItem(int itemId) throws SQLException {
        itemDAO.deleteItem(itemId);
    }
    
    public void updateItem(Item item) throws SQLException {
        itemDAO.updateItem(item);
    }
    
    public Item getItemById(int itemId) throws SQLException {
        return itemDAO.getItemById(itemId);
    }
}