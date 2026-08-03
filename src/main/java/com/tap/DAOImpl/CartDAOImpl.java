package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DAO.CartDAO;
import com.tap.model.Cart;
import com.tap.utility.DBConnection;

public class CartDAOImpl implements CartDAO {

    // NOTE: adjust table/column names below (menu, restaurants, restaurantID,
    // restaurantName, images) if they differ from your actual schema —
    // these match the getters used in your menu.jsp / restaurant.jsp so far.

    private static final String FIND_EXISTING =
        "SELECT cartItemID, quantity FROM cart_items WHERE userID=? AND menuID=?";

    private static final String INSERT_ITEM =
        "INSERT INTO cart_items (userID, menuID, quantity) VALUES (?, ?, ?)";

    private static final String INCREMENT_ITEM =
        "UPDATE cart_items SET quantity = quantity + ? WHERE cartItemID=?";

    private static final String SET_QUANTITY =
        "UPDATE cart_items SET quantity=? WHERE cartItemID=?";

    private static final String DELETE_ITEM =
        "DELETE FROM cart_items WHERE cartItemID=?";

    private static final String DELETE_ALL_FOR_USER =
        "DELETE FROM cart_items WHERE userID=?";

    private static final String GET_CART_RESTAURANT =
        "SELECT DISTINCT m.restaurantId FROM cart_items ci " +
        "JOIN menu m ON ci.menuID = m.menuId WHERE ci.userID = ?";

    private static final String SELECT_CART_FOR_USER =
        "SELECT ci.cartItemID, ci.userID, ci.menuID, ci.quantity, " +
        "       m.itemName, m.price, m.images, r.restaurantname " +
        "FROM cart_items ci " +
        "JOIN menu m ON ci.menuID = m.menuId " +
        "JOIN restaurant r ON m.restaurantID = r.restaurantID " +
        "WHERE ci.userID = ?";
    
    private static final String GET_CART_ITEM_COUNT = 
    		"SELECT COALESCE(SUM(quantity), 0) AS totalCount FROM cart_items WHERE userID = ?";
    
    private static final String GET_CART_QUANTITIES_BY_RESTAURANT = 
    	    "SELECT ci.menuID, ci.quantity FROM cart_items ci " +
    	    	    "JOIN menu m ON ci.menuID = m.menuId " +
    	    	    "WHERE ci.userID = ? AND m.restaurantId = ?";
    
    private static final String DECREMENT_ITEM =
    	    "UPDATE cart_items SET quantity = quantity - 1 WHERE userID=? AND menuID=? AND quantity > 0";

    	private static final String GET_QUANTITY =
    	    "SELECT cartItemID, quantity FROM cart_items WHERE userID=? AND menuID=?";

    @Override
    public void addToCart(int userID, int menuID, int quantity) {
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement find = con.prepareStatement(FIND_EXISTING);
            find.setInt(1, userID);
            find.setInt(2, menuID);
            ResultSet rs = find.executeQuery();

            if (rs.next()) {
                int cartItemID = rs.getInt("cartItemID");
                PreparedStatement inc = con.prepareStatement(INCREMENT_ITEM);
                inc.setInt(1, quantity);
                inc.setInt(2, cartItemID);
                inc.executeUpdate();
            } else {
                PreparedStatement insert = con.prepareStatement(INSERT_ITEM);
                insert.setInt(1, userID);
                insert.setInt(2, menuID);
                insert.setInt(3, quantity);
                insert.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Cart> getCartItemsByUser(int userID) {
        List<Cart> items = new ArrayList<Cart>();
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement pmst = con.prepareStatement(SELECT_CART_FOR_USER);
            pmst.setInt(1, userID);
            ResultSet rs = pmst.executeQuery();

            while (rs.next()) {
                Cart item = new Cart(
                    rs.getInt("cartItemID"),
                    rs.getInt("userID"),
                    rs.getInt("menuID"),
                    rs.getInt("quantity"),
                    rs.getString("itemName"),
                    rs.getDouble("price"),
                    rs.getString("images"),
                    rs.getString("restaurantName")
                );
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public void updateQuantity(int cartItemID, int quantity) {
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement pmst = con.prepareStatement(SET_QUANTITY);
            pmst.setInt(1, quantity);
            pmst.setInt(2, cartItemID);
            pmst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void removeCartItem(int cartItemID) {
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement pmst = con.prepareStatement(DELETE_ITEM);
            pmst.setInt(1, cartItemID);
            pmst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Integer getCartRestaurantId(int userID) {
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement pmst = con.prepareStatement(GET_CART_RESTAURANT);
            pmst.setInt(1, userID);
            ResultSet rs = pmst.executeQuery();
            if (rs.next()) {
                return rs.getInt("restaurantId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // empty cart — no restaurant lock yet
    }

    @Override
    public void clearCart(int userID) {
        Connection con = DBConnection.getConnection();
        try {
            PreparedStatement pmst = con.prepareStatement(DELETE_ALL_FOR_USER);
            pmst.setInt(1, userID);
            pmst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

	@Override
	public int getCartItemCount(int userID) {
		// TODO Auto-generated method stub
		int count = 0;
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(GET_CART_ITEM_COUNT);
			pmst.setInt(1, userID);
			ResultSet rs = pmst.executeQuery();
			if (rs.next()) {
                count = rs.getInt("totalCount");
            }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}

	@Override
	public Map<Integer, Integer> getCartQuantitiesByRestaurant(int userID, int restaurantId) {
		// TODO Auto-generated method stub
		Map<Integer, Integer> quantities = new HashMap<>();
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(GET_CART_QUANTITIES_BY_RESTAURANT);
			pmst.setInt(1, userID);
			pmst.setInt(2, restaurantId);
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				quantities.put(rs.getInt("menuID"), rs.getInt("quantity"));
            }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return quantities;
	}
	
	@Override
	public void decreaseQuantity(int userID, int menuID) {
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement find = con.prepareStatement(GET_QUANTITY);
	        find.setInt(1, userID);
	        find.setInt(2, menuID);
	        ResultSet rs = find.executeQuery();

	        if (rs.next()) {
	            int cartItemID = rs.getInt("cartItemID");
	            int currentQty = rs.getInt("quantity");

	            if (currentQty <= 1) {
	                PreparedStatement del = con.prepareStatement(DELETE_ITEM);
	                del.setInt(1, cartItemID);
	                del.executeUpdate();
	            } else {
	                PreparedStatement dec = con.prepareStatement(DECREMENT_ITEM);
	                dec.setInt(1, userID);
	                dec.setInt(2, menuID);
	                dec.executeUpdate();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
    
}