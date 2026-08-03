package com.food.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("name");
        System.out.println("LOGIN ATTEMPT: username=[" + username + "]");
        String password = req.getParameter("password");

        UserDAOImpl dao = new UserDAOImpl();
        User user = dao.getUserByName(username);

        HttpSession session = req.getSession();
        //System.out.println("Login Session ID: " + session.getId());

        Integer attempts = (Integer) session.getAttribute("attempts");

        if (attempts == null) {
            attempts = 0;
        }

        // User not found
        if (user == null) {
            resp.sendRedirect("login.jsp?error=User+does+not+exist");
            return;
        }

        // Account already locked
        if (user.isLocked()) {
            resp.sendRedirect("login.jsp?error=Your+account+is+locked.+Please+reset+your+password.");
            return;
        }

        try {
            if (BCrypt.checkpw(password, user.getPassword())) {
                // Successful login
                session.removeAttribute("attempts");
                session.setAttribute("loggedInUser", user);
                //System.out.println("User stored: " + session.getAttribute("loggedInUser"));
                String role = user.getRole();
                if ("restaurantAdmin".equals(role)) {
                    resp.sendRedirect("restaurantAdminDashboard");
                } else if ("Admin".equals(role)) {
                    resp.sendRedirect("adminDashboard");
                } else {
                    resp.sendRedirect("restaurant");
                }
            } else {
                attempts++;
                session.setAttribute("attempts", attempts);
                if (attempts >= 3) {
                    // Lock the account in DB
                    dao.lockUser(user.getUserID());
                    session.removeAttribute("attempts");
                    resp.sendRedirect("login.jsp?error=Your+account+has+been+locked.+Click+Forgot+Password.");
                } else {
                    resp.sendRedirect("login.jsp?error=Incorrect+Password&left=" + (3 - attempts));
                }
            }

        } catch (IllegalArgumentException e) {
            // Handles invalid BCrypt hashes in DB
            resp.sendRedirect("login.jsp?error=Invalid+password+stored+in+database");

        }
    }
}