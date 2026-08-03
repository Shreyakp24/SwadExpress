package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImpl.AddressDAOImpl;
import com.tap.DAOImpl.CartDAOImpl;
import com.tap.DAOImpl.OrderItemDAOImpl;
import com.tap.DAOImpl.OrderTableDAOImpl;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.model.Address;
import com.tap.model.Cart;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/checkout","/payment", "/orderconfirmed"})
public class CheckoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	    HttpSession session = req.getSession(false);
	    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

	    if (loggedInUser == null) {
	        resp.sendRedirect(req.getContextPath() + "/login.jsp");
	        return;
	    }

	    int userID = loggedInUser.getUserID();

	    CartDAOImpl cartDAOImpl = new CartDAOImpl();
	    List<Cart> cartItems = cartDAOImpl.getCartItemsByUser(userID);

	    Integer cartRestaurantId = cartDAOImpl.getCartRestaurantId(userID);
	    Restaurant restaurant = null;
	    if (cartRestaurantId != null) {
	        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
	        restaurant = restaurantDAOImpl.getRestaurant(cartRestaurantId);
	    }

	    AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
	    List<Address> userAddresses = addressDAOImpl.getAddressesByUser(userID);

	    req.setAttribute("cartItems", cartItems);
	    req.setAttribute("restaurant", restaurant);
	    req.setAttribute("userAddresses", userAddresses);

	    // figure out the default address too, since payment.jsp needs it
	    Address selectedAddress = null;
	    String addressIDParam = req.getParameter("addressID");

	    if (addressIDParam != null && !addressIDParam.isEmpty()) {
	        int addressID = Integer.parseInt(addressIDParam);
//	        System.out.println("addressIDParam = " + addressIDParam);
//	        System.out.println("userAddresses size = " + userAddresses.size());
	        for (Address a : userAddresses) {
	            if (a.getAddressID() == addressID) {
//	            	System.out.println("  -> addressID=" + a.getAddressID() + ", label=" + a.getLabel() + ", isDefault=" + a.isDefault());
	                selectedAddress = a;
	                break;
	            }
	        }
//	        System.out.println("selectedAddress = " + (selectedAddress != null ? selectedAddress.getLabel() : "null"));
	    }

	    // fall back to the default address if no valid selection was passed
	    // (e.g. someone hits /payment directly without going through checkout first)
	    if (selectedAddress == null) {
	        for (Address a : userAddresses) {
	            if (a.isDefault()) {
	                selectedAddress = a;
	                break;
	            }
	        }
	    }

	    req.setAttribute("defaultAddress", selectedAddress);

	    // decide which page to forward to, based on which URL was actually requested
	    String path = req.getServletPath();
	    RequestDispatcher rd;
	    if ("/payment".equals(path)) {
	        rd = req.getRequestDispatcher("payment.jsp");
	    } else {
	        rd = req.getRequestDispatcher("checkout.jsp");
	    }
	    rd.forward(req, resp);
	}
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        int userID = loggedInUser.getUserID();

        if ("addAddress".equals(action)) {
            
            String label = req.getParameter("label");
            String fullAddress = req.getParameter("fullAddress");
            boolean isDefault = "true".equals(req.getParameter("isDefault"));

            AddressDAOImpl addressDAOImpl = new AddressDAOImpl();

            int existingCount = addressDAOImpl.getAddressesByUser(userID).size();
            if (existingCount < 4) {
                addressDAOImpl.addAddress(userID, label, fullAddress, isDefault);
            }
            resp.sendRedirect(req.getContextPath() + "/checkout");
            return;
        }

        // after handling the action, send back to the checkout page (GET), which re-fetches everything fresh
        
        
        else if ("placeOrder".equals(action)) {

            CartDAOImpl cartDAOImpl = new CartDAOImpl();
            List<Cart> cartItems = cartDAOImpl.getCartItemsByUser(userID);

            Integer cartRestaurantId = cartDAOImpl.getCartRestaurantId(userID);
            Restaurant restaurant = null;
            if (cartRestaurantId != null) {
                RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
                restaurant = restaurantDAOImpl.getRestaurant(cartRestaurantId);
            }

            AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
            List<Address> userAddresses = addressDAOImpl.getAddressesByUser(userID);

            Address selectedAddress = null;
            String addressIDParam = req.getParameter("addressID");
            if (addressIDParam != null && !addressIDParam.isEmpty()) {
                int addressID = Integer.parseInt(addressIDParam);
                for (Address a : userAddresses) {
                    if (a.getAddressID() == addressID) {
                        selectedAddress = a;
                        break;
                    }
                }
            }
            if (selectedAddress == null) {
                for (Address a : userAddresses) {
                    if (a.isDefault()) {
                        selectedAddress = a;
                        break;
                    }
                }
            }

            double subtotal = 0;
            for (Cart c : cartItems) {
                subtotal += c.getLineTotal();
            }
            double deliveryFee = cartItems.isEmpty() ? 0 : 4.99;
            double tax = subtotal * 0.08;
            double total = subtotal + deliveryFee + tax;

            String paymentMethod = req.getParameter("method");
            if (paymentMethod == null) paymentMethod = "COD";

            // ---- persist the order ----
            OrderTable order = new OrderTable(
                userID,
                cartRestaurantId != null ? cartRestaurantId : 0,
                new java.sql.Timestamp(System.currentTimeMillis()),
                total,
                "Confirmed",
                paymentMethod
            );
            OrderTableDAOImpl orderTableDAOImpl = new OrderTableDAOImpl();
            int orderID = orderTableDAOImpl.addOrderReturningId(order);

            if (orderID <= 0) {
                req.setAttribute("errorMessage", "Could not place order. Please try again.");
                RequestDispatcher errRd = req.getRequestDispatcher("checkout.jsp");
                errRd.forward(req, resp);
                return;
            }
            
            OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();
            for (Cart c : cartItems) {
                OrderItem item = new OrderItem(orderID, c.getMenuID(), c.getQuantity(), c.getLineTotal());
                orderItemDAOImpl.addOrderItem(item);
            }
            cartDAOImpl.clearCart(userID);
            
            req.setAttribute("orderID", orderID);
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("restaurant", restaurant);
            req.setAttribute("defaultAddress", selectedAddress);
            req.setAttribute("orderTotal", total);
            
            RequestDispatcher rd = req.getRequestDispatcher("orderConfirmation.jsp");
            rd.forward(req, resp);

            
            return;
        }
        else {
        	resp.sendRedirect(req.getContextPath() + "/checkout");
        }
    }
}