package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

	String query1 = "insert into orderitem(orderID,menuID,quantity,itemTotal) values(?,?,?,?)";
	String query2 = "select * from orderitem where orderItemID=?";
	String query3 = "update orderitem set orderID=?,menuID=?,quantity=?,itemTotal=? where orderItemID=?";
	String query4 = "delete from orderitem where orderItemID=?";
	String query5 = "select * from orderitem";
	String query6 =
		    "SELECT oi.orderItemID, oi.orderID, oi.menuID, oi.quantity, oi.itemTotal, " +
		    "       m.itemName, m.images " +
		    "FROM orderitem oi " +
		    "JOIN menu m ON oi.menuID = m.menuId " +
		    "WHERE oi.orderID = ?";
	Connection con = DBConnection.getConnection();

	@Override
	public void addOrderItem(OrderItem orderItem) {
		try {
			PreparedStatement pmst = con.prepareStatement(query1);
			pmst.setInt(1, orderItem.getOrderId());
			pmst.setInt(2, orderItem.getMenuId());
			pmst.setInt(3, orderItem.getQuantity());
			pmst.setDouble(4, orderItem.getItemTotal());
			int i = pmst.executeUpdate();
			System.out.println(i);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderItem getOrderItem(int orderItemID) {
		OrderItem orderItem = null;
		try {
			PreparedStatement pmst = con.prepareStatement(query2);
			pmst.setInt(1, orderItemID);
			ResultSet res = pmst.executeQuery();
			while(res.next()) {
				orderItem = extractResultSet(res);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return orderItem;
	}
	
	@Override
	public void updateOrderItem(OrderItem orderItem) {
		try {
			PreparedStatement pmst = con.prepareStatement(query3);
			pmst.setInt(1, orderItem.getOrderId());
			pmst.setInt(2, orderItem.getMenuId());
			pmst.setInt(3, orderItem.getQuantity());
			pmst.setDouble(4, orderItem.getItemTotal());
			pmst.setInt(5, orderItem.getOrderItemId());
			int i = pmst.executeUpdate();
			System.out.println(i);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemID) {
		try {
			PreparedStatement pmst = con.prepareStatement(query4);
			pmst.setInt(1, orderItemID);
			int i = pmst.executeUpdate();
			System.out.println(i);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderItem> getAllOrderItems() {
		ArrayList<OrderItem> list = new ArrayList<>();
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
	
	@Override
	public List<OrderItem> getOrderItemsWithMenuDetails(int orderID) {
	    List<OrderItem> items = new ArrayList<>();
	    try {
	        PreparedStatement pmst = con.prepareStatement(query6);
	        pmst.setInt(1, orderID);
	        ResultSet res = pmst.executeQuery();
	        while (res.next()) {
	            OrderItem item = new OrderItem(
	                res.getInt("orderItemID"),
	                res.getInt("orderID"),
	                res.getInt("menuID"),
	                res.getInt("quantity"),
	                res.getDouble("itemTotal"),
	                res.getString("itemName"),
	                res.getString("images")
	            );
	            items.add(item);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return items;
	}

	private OrderItem extractResultSet(ResultSet res) throws SQLException {
		int orderItemId = res.getInt("orderItemID");
		int orderId = res.getInt("orderID");
		int menuId = res.getInt("menuID");
		int quantity = res.getInt("quantity");
		double itemTotal = res.getDouble("itemTotal");
		OrderItem orderItem = new OrderItem(
				orderItemId,
				orderId,
				menuId,
				quantity,
				itemTotal
		);
		return orderItem;
	}
}