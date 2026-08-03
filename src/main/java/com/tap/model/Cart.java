package com.tap.model;

public class Cart {

    private int cartItemID;
    private int userID;
    private int menuID;
    private int quantity;

    // populated via JOIN with the menu (and restaurant) table for display —
    // not stored on cart_items itself
    private String itemName;
    private double price;
    private String image;
    private String restaurantName;

    public Cart() {
    }

    public Cart(int cartItemID, int userID, int menuID, int quantity,
                     String itemName, double price, String image, String restaurantName) {
        this.cartItemID = cartItemID;
        this.userID = userID;
        this.menuID = menuID;
        this.quantity = quantity;
        this.itemName = itemName;
        this.price = price;
        this.image = image;
        this.restaurantName = restaurantName;
    }

    public int getCartItemID() { return cartItemID; }
    public void setCartItemID(int cartItemID) { this.cartItemID = cartItemID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public int getMenuID() { return menuID; }
    public void setMenuID(int menuID) { this.menuID = menuID; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getRestaurantName() { return restaurantName; }
    public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }

    // convenience for the JSP — avoids scriptlet math in the markup
    public double getLineTotal() { return price * quantity; }
}