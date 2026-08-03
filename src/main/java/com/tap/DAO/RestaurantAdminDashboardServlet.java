package com.tap.DAO;

import java.io.IOException;

import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/restaurantAdminDashboard")
public class RestaurantAdminDashboardServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
		
		if(loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}
		if(!"restaurantAdmin".equals(loggedInUser.getRole())) {
			resp.sendRedirect(req.getContextPath() + "/restaurant");
			return;
		}
		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
		Restaurant restaurant = restaurantDAOImpl.getRestaurantByOwnerUserID(loggedInUser.getUserID());
		
		if(restaurant == null) {
			RequestDispatcher rd = req.getRequestDispatcher("createRestaurant.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("myRestaurant", restaurant);
			RequestDispatcher rd = req.getRequestDispatcher("restaurantAdminDashboard.jsp");
			rd.forward(req, resp);
		}
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

	    if ("createRestaurant".equals(action)) {

	        String restaurantName = req.getParameter("restaurantName");
	        String cuisineType = req.getParameter("cuisineType");
	        String eta = req.getParameter("ETA");
	        String tagline = req.getParameter("tagline");
	        String address = req.getParameter("address");
	        String discount = req.getParameter("discount");
	        String image = req.getParameter("image");

	        Restaurant restaurant = new Restaurant(
	            restaurantName,
	            0,              // ratings — starts at 0, no reviews yet
	            eta,
	            cuisineType,
	            discount,
	            image,
	            address,
	            true,           // isActive
	            loggedInUser.getUserID(),   // ownerUserID — this is the key link
	            tagline
	        );

	        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
	        restaurantDAOImpl.addRestaurant(restaurant);

	        resp.sendRedirect(req.getContextPath() + "/restaurantAdminDashboard");
	        return;
	    }

	    resp.sendRedirect(req.getContextPath() + "/restaurantAdminDashboard");
	}
}
