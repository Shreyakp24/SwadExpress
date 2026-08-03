package com.tap.DAOImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

	String query1 = "insert into menu(restaurantID,itemName,description,price,isAvailable,category,createdAt,updatedAt,deletedAt,images) values(?,?,?,?,?,?,?,?,?,?)";
	String query2 = "select * from menu where menuID=?";
	String query3 = "update menu set restaurantID=?,itemName=?,description=?,price=?,isAvailable=?,category=?,createdAt=?,updatedAt=?,deletedAt=?,images=? where menuID=?";
	String query4 = "delete from menu where menuID=?";
	String query5 = "select * from menu";
	String query6 = "SELECT * FROM menu WHERE restaurantID = ?";

	Connection con = DBConnection.getConnection();

	@Override
	public void addMenu(Menu menu) {

		try {

			PreparedStatement pmst = con.prepareStatement(query1);

			pmst.setInt(1, menu.getRestaurantId());
			pmst.setString(2, menu.getItemName());
			pmst.setString(3, menu.getDescription());
			pmst.setDouble(4, menu.getPrice());
			pmst.setBoolean(5, menu.isAvailable());
			pmst.setString(6, menu.getCategory());
			pmst.setTimestamp(7, menu.getCreatedAt());
			pmst.setTimestamp(8, menu.getUpdatedAt());
			pmst.setTimestamp(9, menu.getDeletedAt());
			pmst.setString(10, menu.getImages());

			int i = pmst.executeUpdate();

			System.out.println(i);

		}
		catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public Menu getMenu(int menuID) {

		Menu menu = null;

		try {

			PreparedStatement pmst = con.prepareStatement(query2);

			pmst.setInt(1, menuID);

			ResultSet res = pmst.executeQuery();

			while(res.next()) {

				menu = extractResultSet(res);

			}

		}
		catch (SQLException e) {

			e.printStackTrace();
		}

		return menu;
	}

	@Override
	public void updateMenu(Menu menu) {

		try {

			PreparedStatement pmst = con.prepareStatement(query3);

			pmst.setInt(1, menu.getRestaurantId());
			pmst.setString(2, menu.getItemName());
			pmst.setString(3, menu.getDescription());
			pmst.setDouble(4, menu.getPrice());
			pmst.setBoolean(5, menu.isAvailable());
			pmst.setString(6, menu.getCategory());
			pmst.setTimestamp(7, menu.getCreatedAt());
			pmst.setTimestamp(8, menu.getUpdatedAt());
			pmst.setTimestamp(9, menu.getDeletedAt());
			pmst.setString(10, menu.getImages());
			pmst.setInt(11, menu.getMenuId());

			int i = pmst.executeUpdate();

			System.out.println(i);

		}
		catch(SQLException e) {

			e.printStackTrace();
		}

	}

	@Override
	public void deleteMenu(int menuID) {

		try {

			PreparedStatement pmst = con.prepareStatement(query4);

			pmst.setInt(1, menuID);

			int i = pmst.executeUpdate();

			System.out.println(i);

		}
		catch(SQLException e) {

			e.printStackTrace();
		}

	}

	@Override
	public List<Menu> getAllMenu() {

		ArrayList<Menu> list = new ArrayList<>();

		try {

			Statement stmt = con.createStatement();

			ResultSet res = stmt.executeQuery(query5);

			while(res.next()) {

				list.add(extractResultSet(res));

			}

		}
		catch(SQLException e) {

			e.printStackTrace();
		}

		return list;
	}

	private Menu extractResultSet(ResultSet res) throws SQLException {

		int menuId = res.getInt("menuID");
		int restaurantId = res.getInt("restaurantID");
		String itemName = res.getString("itemName");
		String description = res.getString("description");
		double price = res.getDouble("price");
		boolean isAvailable = res.getBoolean("isAvailable");
		String category = res.getString("category");
		Timestamp createdAt = res.getTimestamp("createdAt");
		Timestamp updatedAt = res.getTimestamp("updatedAt");
		Timestamp deletedAt = res.getTimestamp("deletedAt");
		String images = res.getString("images");

		return new Menu(menuId, restaurantId, itemName,
				description, price, isAvailable,
				category, createdAt,
				updatedAt, deletedAt,images);

	}

	@Override
	public List<Menu> getMenuByRestaurantId(int restaurantId) {
		// TODO Auto-generated method stub
	    List<Menu> list = new ArrayList<>();
	    try {
	        PreparedStatement pmst = con.prepareStatement(query6);
	        pmst.setInt(1, restaurantId);

	        ResultSet res = pmst.executeQuery();

	        while (res.next()) {
	            list.add(extractResultSet(res));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}