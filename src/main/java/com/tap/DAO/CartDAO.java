package com.tap.DAO;

import java.util.List;
import java.util.Map;

import com.tap.model.Cart;

public interface CartDAO {
    void addToCart(int userID, int menuID, int quantity);
    List<Cart> getCartItemsByUser(int userID);
    void updateQuantity(int cartItemID, int quantity);
    void removeCartItem(int cartItemID);
    void clearCart(int userID);
    Integer getCartRestaurantId(int userID);
	int getCartItemCount(int userID);
	Map<Integer, Integer> getCartQuantitiesByRestaurant(int userID, int restaurantId);
	void decreaseQuantity(int userID, int menuID);
}
