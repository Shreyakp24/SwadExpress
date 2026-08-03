package com.food.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.tap.DAO.CartDAO;
import com.tap.DAOImpl.CartDAOImpl;
import com.tap.model.Cart;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@MultipartConfig
@WebServlet("/cart")
public class CartServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// TODO Auto-generated method stub
    	HttpSession session = req.getSession(false);
    	User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
    	
    	List<Cart> cartItems = cartDAO.getCartItemsByUser(loggedInUser.getUserID());
    	Integer cartRestaurantId = cartDAO.getCartRestaurantId(loggedInUser.getUserID());
    	req.setAttribute("cartRestaurantId", cartRestaurantId);
    	req.setAttribute("cartItems", cartItems);
    	req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    	
    }
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		HttpSession session = req.getSession(false);
    	User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        int userID = loggedInUser.getUserID();
        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        if (action.equals("add")) {
            int menuID = Integer.parseInt(req.getParameter("menuID"));
            int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
            boolean force = "true".equals(req.getParameter("force"));

            Integer cartRestaurantId = cartDAO.getCartRestaurantId(userID);
            boolean conflict = cartRestaurantId != null && cartRestaurantId != restaurantId;

            if (conflict && !force) {
                out.print("conflict");
                return;
            }
            if (conflict) {
                cartDAO.clearCart(userID);
            }
            cartDAO.addToCart(userID, menuID, 1);

            int cartCount = cartDAO.getCartItemCount(userID); // needs to exist in your DAO
            out.print("success\n" + cartCount);
            return;
			
		}else if(action.equals("update")) {
            int cartItemID = Integer.parseInt(req.getParameter("cartItemID"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            if (quantity < 1) {
                cartDAO.removeCartItem(cartItemID);
            } else {
                cartDAO.updateQuantity(cartItemID, quantity);
            }
		}else if(action.equals("remove")) {
			int cartItemID = Integer.parseInt(req.getParameter("cartItemID"));
			cartDAO.removeCartItem(cartItemID);
		}else if (action.equals("decrease")) {
	    int menuID = Integer.parseInt(req.getParameter("menuID"));
	    cartDAO.decreaseQuantity(userID, menuID);

	    int cartCount = cartDAO.getCartItemCount(userID);
	    out.print("success\n" + cartCount);
	    return;
	}
		resp.sendRedirect(req.getContextPath() + "/cart");
	}
}
