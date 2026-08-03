package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.tap.DAO.OrderTableDAO;
import com.tap.model.OrderTable;
import com.tap.utility.DBConnection;

public class OrderTableDAOImpl implements OrderTableDAO {

	String query1 = "insert into ordertable(userID,restaurantID,orderDate,totalAmount,status,paymentMethod) values(?,?,?,?,?,?)";
	String query2 = "select * from ordertable where orderID=?";
	String query3 = "update ordertable set userID=?,restaurantID=?,orderDate=?,totalAmount=?,status=?,paymentMethod=? where orderID=?";
	String query4 = "delete from ordertable where orderID=?";
	String query5 = "select * from ordertable";
	String query6 = "insert into ordertable (userID, restaurantID, orderDate, totalAmount, status, paymentMethod) " +
		    "VALUES (?, ?, ?, ?, ?, ?)";
	String query7 ="SELECT * FROM ordertable WHERE userID = ? ORDER BY orderDate DESC";
	Connection con = DBConnection.getConnection();

	@Override
	public void addOrder(OrderTable order) {

		try {
			PreparedStatement pmst = con.prepareStatement(query1);
			pmst.setInt(1, order.getUserId());
			pmst.setInt(2, order.getRestaurantId());
			pmst.setTimestamp(3, order.getOrderDate());
			pmst.setDouble(4, order.getTotalAmount());
			pmst.setString(5, order.getStatus());
			pmst.setString(6, order.getPaymentMethod());
			int i = pmst.executeUpdate();
			System.out.println(i);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderTable getOrder(int orderID) {
		OrderTable order = null;
		try {
			PreparedStatement pmst = con.prepareStatement(query2);
			pmst.setInt(1, orderID);
			ResultSet res = pmst.executeQuery();
			while (res.next()) {
				order = extractResultSet(res);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return order;
	}

	@Override
	public void updateOrder(OrderTable order) {
		try {
			PreparedStatement pmst = con.prepareStatement(query3);
			pmst.setInt(1, order.getUserId());
			pmst.setInt(2, order.getRestaurantId());
			pmst.setTimestamp(3, order.getOrderDate());
			pmst.setDouble(4, order.getTotalAmount());
			pmst.setString(5, order.getStatus());
			pmst.setString(6, order.getPaymentMethod());
			pmst.setInt(7, order.getOrderId());
			int i = pmst.executeUpdate();
			System.out.println(i);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrder(int orderID) {
		try {
			PreparedStatement pmst = con.prepareStatement(query4);
			pmst.setInt(1, orderID);
			int i = pmst.executeUpdate();
			System.out.println(i);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderTable> getAllOrders() {
		ArrayList<OrderTable> list = new ArrayList<>();
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query5);
			while (res.next()) {
				list.add(extractResultSet(res));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int addOrderReturningId(OrderTable order) {
	    int generatedId = -1;
	    try {
	        PreparedStatement pmst = con.prepareStatement(query6, Statement.RETURN_GENERATED_KEYS);
	        pmst.setInt(1, order.getUserId());
	        pmst.setInt(2, order.getRestaurantId());
	        pmst.setTimestamp(3, order.getOrderDate());
	        pmst.setDouble(4, order.getTotalAmount());
	        pmst.setString(5, order.getStatus());
	        pmst.setString(6, order.getPaymentMethod());
	        pmst.executeUpdate();

	        ResultSet keys = pmst.getGeneratedKeys();
	        if (keys.next()) {
	            generatedId = keys.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new RuntimeException("Failed to insert order: " + e.getMessage(), e);
	    }
	    return generatedId;
	}

	@Override
	public List<OrderTable> getOrdersByUser(int userID) {
	    List<OrderTable> orders = new ArrayList<>();
	    try {
	        PreparedStatement pmst = con.prepareStatement(query7);
	        pmst.setInt(1, userID);
	        ResultSet res = pmst.executeQuery();
	        while (res.next()) {
	            orders.add(extractResultSet(res));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return orders;
	}
	
	private OrderTable extractResultSet(ResultSet res) throws SQLException {

		int orderId = res.getInt("orderID");
		int userId = res.getInt("userID");
		int restaurantId = res.getInt("restaurantID");
		Timestamp orderDate = res.getTimestamp("orderDate");
		double totalAmount = res.getDouble("totalAmount");
		String status = res.getString("status");
		String paymentMethod = res.getString("paymentMethod");
		return new OrderTable(
				orderId,
				userId,
				restaurantId,
				orderDate,
				totalAmount,
				status,
				paymentMethod);
	}
}