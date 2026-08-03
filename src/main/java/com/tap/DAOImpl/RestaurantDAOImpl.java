package com.tap.DAOImpl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO{
	
	String query1 = "insert into restaurant(restaurantname,ratings,ETA,cuisineType,discount,image,address,isActive,ownerUserID,tagline) values(?,?,?,?,?,?,?,?,?,?)";
	String query2 = "select * from restaurant where restaurantID = ?";
	String query3 = "update restaurant set restaurantname=?,ratings=?,ETA=?,cuisineType=?,discount=?,image=?,address=?,isActive=?,ownerUserID=?,tagline=? where restaurantID=?";
	String query4 = "delete from restaurant where restaurantID=?";
	String query5 = "select * from restaurant";
	String query6 = "select * from restaurant where ownerUserID = ?";
	Connection con = DBConnection.getConnection();

	@Override
	public void addRestaurant(Restaurant restaurant) {
		 try {
			PreparedStatement pmst = con.prepareStatement(query1);
			pmst.setString(1, restaurant.getRestaurantName());
			pmst.setInt(2, restaurant.getRatings());
			pmst.setString(3, restaurant.getETA());
			pmst.setString(4, restaurant.getCuisineType());
			pmst.setString(5, restaurant.getDiscount());
			pmst.setString(6, restaurant.getImage());
			pmst.setString(7, restaurant.getAddress());
			pmst.setBoolean(8, restaurant.isActive());
			pmst.setInt(9, restaurant.getOwnerUserID());
			pmst.setString(10, restaurant.getTagline());
			int i = pmst.executeUpdate();
			System.out.println(i);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public Restaurant getRestaurant(int restaurantID) {
		Restaurant restaurant = null;
		try {
			PreparedStatement pmst = con.prepareStatement(query2);
			pmst.setInt(1, restaurantID);
			ResultSet res = pmst.executeQuery();
			while(res.next()) {
				restaurant = extractResultSet(res);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return restaurant;
	}


	@Override
	public void updateRestaurant(Restaurant restaurant) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement pmst = con.prepareStatement(query3);
			pmst.setString(1, restaurant.getRestaurantName());
			pmst.setInt(2, restaurant.getRatings());
			pmst.setString(3, restaurant.getETA());
			pmst.setString(4, restaurant.getCuisineType());
			pmst.setString(5, restaurant.getDiscount());
			pmst.setString(6, restaurant.getImage());
			pmst.setString(7, restaurant.getAddress());
			pmst.setBoolean(8, restaurant.isActive());
			pmst.setInt(9, restaurant.getOwnerUserID());
			pmst.setString(10, restaurant.getTagline());
			pmst.setInt(11, restaurant.getRestaurantID());
			System.out.println("ID = " + restaurant.getRestaurantID());
			System.out.println("Name = " + restaurant.getRestaurantName());
			int i = pmst.executeUpdate();
			System.out.println(i);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteRestaurant(int restaurantID) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement pmst = con.prepareStatement(query4);
			pmst.setInt(1, restaurantID);
			int i = pmst.executeUpdate();
			System.out.println(i);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public Restaurant getRestaurantByOwnerUserID(int ownerUserID) {
	    Restaurant restaurant = null;
	    try {
	        PreparedStatement pmst = con.prepareStatement(query6);
	        pmst.setInt(1, ownerUserID);
	        ResultSet res = pmst.executeQuery();
	        if (res.next()) {
	            restaurant = extractResultSet(res);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return restaurant;
	}

	@Override
	public List<Restaurant> getAllRestaurants() {
		// TODO Auto-generated method stub
		Restaurant restaurant = null;
		ArrayList<Restaurant> list = new ArrayList<Restaurant>();
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query5);
			while(res.next()) {
				restaurant = extractResultSet(res);
				list.add(restaurant);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	Restaurant extractResultSet(ResultSet res) throws SQLException {
		// TODO Auto-generated method stub
		int restaurantID = res.getInt("restaurantID");
		String restaurantName = res.getString("restaurantname");
		int ratings = res.getInt("ratings");
		String ETA = res.getString("ETA");
		String cuisineType = res.getString("cuisineType");
		String discount = res.getString("discount");
		String image = res.getString("image");
		String address = res.getString("address");
		Boolean isActive = res.getBoolean("isActive");
		int ownerUserID = res.getInt("ownerUserID");
		String tagline = res.getString("tagline");
		
		Restaurant restaurant = new Restaurant(restaurantID,restaurantName,ratings,ETA,cuisineType,discount,image,address,isActive,ownerUserID,tagline);
		
		return restaurant;
	}

	
}
