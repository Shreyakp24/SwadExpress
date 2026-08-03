package com.food.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");
		String role = req.getParameter("role");
		
		UserDAOImpl u = new UserDAOImpl();
	    // Email already registered
	    if (u.userExists(email)) {
	        resp.sendRedirect("signup.jsp?error=Email already registered");
	        return;
	    }
	    
	    // Passwords do not match
	    if (!password.equals(confirmPassword)) {
	        resp.sendRedirect("signup.jsp?error=Passwords do not match");
	        return;
	    }
	    
	    if (password.length() < 8) {
	        resp.sendRedirect("signup.jsp?error=Password must contain at least 8 characters");
	        return;
	    }
	    
	    // Password validation
	    String regex = "^[A-Z](?=.*\\d)(?=.*[@#$%^&+=!]).{7,}$";
	    if (!password.matches(regex)) {
	        resp.sendRedirect("signup.jsp?error=Password must contain uppercase, lowercase, number and special character");
	        return;
	    }
		
		String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(12));
		User user = new User(name,email,address,hashpw,role);
		u.addUser(user);
		resp.sendRedirect("login.jsp");
		
	}
	
}
