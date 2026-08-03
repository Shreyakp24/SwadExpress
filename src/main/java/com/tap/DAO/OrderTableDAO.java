package com.tap.DAO;

import java.util.List;

import com.tap.model.OrderTable;

public interface OrderTableDAO {
	void addOrder(OrderTable order);
	OrderTable getOrder(int orderID);
	void updateOrder(OrderTable order);
	void deleteOrder(int orderID);
	List<OrderTable> getAllOrders();
	int addOrderReturningId(OrderTable order);
	List<OrderTable> getOrdersByUser(int userID);
	
}
