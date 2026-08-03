package com.food.servlets;

import java.io.IOException;

import com.tap.DAOImpl.AddressDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/setDefaultAddress")
public class SetDefaultAddressServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userID = loggedInUser.getUserID();
        int addressID = Integer.parseInt(req.getParameter("addressID"));
        System.out.println("SetDefaultAddressServlet hit: userID=" + userID + ", addressID=" + addressID);

        AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
        addressDAOImpl.setDefaultAddress(userID, addressID);
        System.out.println("setDefaultAddress call completed");

        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}