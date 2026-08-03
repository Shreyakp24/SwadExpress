package com.food.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.tap.DAO.UserDAO;
import com.tap.DAOImpl.AddressDAOImpl;
import com.tap.DAOImpl.OrderItemDAOImpl;
import com.tap.DAOImpl.OrderTableDAOImpl;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.Address;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet({"/UpdateProfileServlet", "/profile"})
@MultipartConfig(
	    maxFileSize = 2 * 1024 * 1024,       // 2 MB per file
	    maxRequestSize = 3 * 1024 * 1024
	)
public class ProfileServlet extends HttpServlet{
	   private static final long serialVersionUID = 1L;
	   
	    // relative to the webapp root, e.g. webapp/images/users/
	    private static final String UPLOAD_DIR = "images" + File.separator + "users";
	 
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	 
	        HttpSession session = request.getSession(false);
	        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	 
	        if (loggedInUser == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }
	 
	        // ---- username ----
	        String newUsername = request.getParameter("username");
	        if (newUsername != null && !newUsername.trim().isEmpty()) {
	            loggedInUser.setUsername(newUsername.trim());
	        }
	 
	        
	        // ---- profile photo (optional) ----
	        Part filePart = request.getPart("profileImage");
	        if (filePart != null && filePart.getSize() > 0) {
	            String savedRelativePath = saveProfileImage(filePart);
	            if (savedRelativePath != null) {
	                loggedInUser.setImage(savedRelativePath);
	            }
	        }
	        UserDAO userDAO = new UserDAOImpl();
	        userDAO.updateUser(loggedInUser);
	        session.setAttribute("loggedInUser", loggedInUser);
	        response.sendRedirect(request.getContextPath() + "/profile");
	    }
	 
	    private String saveProfileImage(Part filePart) throws IOException {
	        String originalFileName = getFileName(filePart);
	        String extension = "";
	        int dotIndex = originalFileName.lastIndexOf('.');
	        if (dotIndex >= 0) {
	            extension = originalFileName.substring(dotIndex);
	        }
	 
	        // random name avoids collisions and avoids trusting the client's filename
	        String newFileName = "user_" + UUID.randomUUID() + extension;
	 
	        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR;
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	 
	        try (InputStream input = filePart.getInputStream()) {
	            File targetFile = new File(uploadDir, newFileName);
	            Files.copy(input, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
	        }
	 
	        // this is what gets stored in the DB "image" column and used as <img src="...">
	        return UPLOAD_DIR.replace(File.separator, "/") + "/" + newFileName;
	    }
	 
	    private String getFileName(Part part) {
	        String contentDisp = part.getHeader("content-disposition");
	        for (String item : contentDisp.split(";")) {
	            if (item.trim().startsWith("filename")) {
	                return item.substring(item.indexOf('=') + 2, item.length() - 1);
	            }
	        }
	        return "";
	    }
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);
	        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

	        if (loggedInUser == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }

	        AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
	        List<Address> userAddresses = addressDAOImpl.getAddressesByUser(loggedInUser.getUserID());

	        if (userAddresses.size() == 1 && !userAddresses.get(0).isDefault()) {
	            addressDAOImpl.setDefaultAddress(loggedInUser.getUserID(), userAddresses.get(0).getAddressID());
	            userAddresses = addressDAOImpl.getAddressesByUser(loggedInUser.getUserID());
	        }
	        request.setAttribute("userAddresses", userAddresses);
	        OrderTableDAOImpl orderTableDAOImpl = new OrderTableDAOImpl();
	        List<OrderTable> userOrders = orderTableDAOImpl.getOrdersByUser(loggedInUser.getUserID());

	        OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();
	        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();

	        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
	        Map<Integer, Restaurant> orderRestaurantMap = new HashMap<>();

	        for (OrderTable order : userOrders) {
	            orderItemsMap.put(order.getOrderId(), orderItemDAOImpl.getOrderItemsWithMenuDetails(order.getOrderId()));
	            if (!orderRestaurantMap.containsKey(order.getRestaurantId())) {
	                orderRestaurantMap.put(order.getRestaurantId(), restaurantDAOImpl.getRestaurant(order.getRestaurantId()));
	            }
	        }
	        request.setAttribute("userOrders", userOrders);
	        request.setAttribute("orderItemsMap", orderItemsMap);
	        request.setAttribute("orderRestaurantMap", orderRestaurantMap);

	        RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
	        rd.forward(request, response);
	    }
}
