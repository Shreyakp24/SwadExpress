package com.food.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DAOImpl.CartDAOImpl;
import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int rID = Integer.parseInt(req.getParameter("restaurantId"));

        MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
        List<Menu> menuByRestaurantId = menuDAOImpl.getMenuByRestaurantId(rID);

        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
        Restaurant restaurant = restaurantDAOImpl.getRestaurant(rID);

        // --- fetch existing cart quantities for this user + restaurant ---
        Map<Integer, Integer> cartQuantities = new HashMap<>();
        HttpSession session = req.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser != null) {
            CartDAOImpl cartDAOImpl = new CartDAOImpl();
			cartQuantities = cartDAOImpl.getCartQuantitiesByRestaurant(loggedInUser.getUserID(), rID);
        }

        req.setAttribute("restaurant", restaurant);
        req.setAttribute("menuByRestaurantId", menuByRestaurantId);
        req.setAttribute("cartQuantities", cartQuantities);

        RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, resp);
    }
}