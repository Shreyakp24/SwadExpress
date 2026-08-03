package com.tap.model;

public class OrderItem {

	private int orderItemId;
	private int orderId;
	private int menuId;
	private int quantity;
	private double itemTotal;

	// populated via JOIN with the menu table for display —
	// not stored on orderitem itself (same pattern as Cart.java)
	private String itemName;
	private String image;

	public OrderItem() {
	}

	public OrderItem(int orderId, int menuId, int quantity, double itemTotal) {
		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
	}

	public OrderItem(int orderItemId, int orderId, int menuId, int quantity, double itemTotal) {
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
	}

	// used when reading back joined with menu (for Order History display)
	public OrderItem(int orderItemId, int orderId, int menuId, int quantity, double itemTotal,
			String itemName, String image) {
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuId = menuId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
		this.itemName = itemName;
		this.image = image;
	}

	public int getOrderItemId() { return orderItemId; }
	public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

	public int getOrderId() { return orderId; }
	public void setOrderId(int orderId) { this.orderId = orderId; }

	public int getMenuId() { return menuId; }
	public void setMenuId(int menuId) { this.menuId = menuId; }

	public int getQuantity() { return quantity; }
	public void setQuantity(int quantity) { this.quantity = quantity; }

	public double getItemTotal() { return itemTotal; }
	public void setItemTotal(double itemTotal) { this.itemTotal = itemTotal; }

	public String getItemName() { return itemName; }
	public void setItemName(String itemName) { this.itemName = itemName; }

	public String getImage() { return image; }
	public void setImage(String image) { this.image = image; }

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId +
				", orderId=" + orderId +
				", menuId=" + menuId +
				", quantity=" + quantity +
				", itemTotal=" + itemTotal + "]";
	}
}