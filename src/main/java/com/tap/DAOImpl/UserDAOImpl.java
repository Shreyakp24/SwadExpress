package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOImpl implements UserDAO{

	String query1 = "INSERT into users(username,email,address,password,role,createDate,lastLoginDate,image) values (?,?,?,?,?,?,?,?)";
	String query2 = "Select * from users where userID = ?";
	String query3 = "UPDATE users SET username=?,email=?,address=?,password=?,role=?,lastLoginDate=?,isLocked=?,image=? WHERE userID=?";
	String query4 = "Select * from users";
	String query5 = "Delete from users where userID=?";
	String query6 = "Select * from users where username=?";
	String query7 = "UPDATE users SET isLocked=? WHERE userID=?";
	String query8 = "SELECT * from users where email=?";

	@Override
	public void addUser(User user) {
		// TODO Auto-generated method stub
//		System.out.println("Inside addUser()");
		Connection con = DBConnection.getConnection();
//		System.out.println(con);

		try {
			PreparedStatement pmst = con.prepareStatement(query1);
			pmst.setString(1, user.getUsername());
			pmst.setString(2, user.getEmail());
			pmst.setString(3, user.getAddress());
			pmst.setString(4, user.getPassword());
			pmst.setString(5, user.getRole());
			pmst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pmst.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			pmst.setString(8, user.getImage());
//			System.out.println(user.getUsername());
//			System.out.println(user.getEmail());
//			System.out.println(user.getAddress());
//			System.out.println(user.getPassword());
//			System.out.println(user.getRole());
			int i = pmst.executeUpdate();
			System.out.println(i);


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}



	@Override
	public User getUser(int userID) {
		// TODO Auto-generated method stub
		User user = null;
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(query2);
			pmst.setInt(1,userID);
			ResultSet res = pmst.executeQuery();

			while(res.next()) {
				user = extractResultSet(res);
			}



		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		Connection con = DBConnection.getConnection();
		try {
			//String query3 = "UPDATE users SET username=?,email=?,address=?,password=?,role=?,lastLoginDate=?,isLocked=?,image=? WHERE userID=?"
			PreparedStatement pmst = con.prepareStatement(query3);
			pmst.setString(1, user.getUsername());
			pmst.setString(2, user.getEmail());
			pmst.setString(3, user.getAddress());
			pmst.setString(4, user.getPassword());
			pmst.setString(5, user.getRole());
			pmst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pmst.setBoolean(7, user.isLocked());
			pmst.setString(8, user.getImage());
			pmst.setInt(9, user.getUserID());
			int i = pmst.executeUpdate();
			System.out.println(i);
			


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void deleteUser(int userID) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(query5);
			pmst.setInt(1,userID);
			int i = pmst.executeUpdate();
			System.out.println(i);



		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// TODO Auto-generated method stub

	}

	@Override
	public List<User> getAllUser() {
		ArrayList<User> list = new ArrayList<User>();
		// TODO Auto-generated method stub
		Connection con = DBConnection.getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query4);
			while(res.next()) {
				User user = extractResultSet(res);
				list.add(user);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public void lockUser(int userID) {
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pmst = con.prepareStatement(query7);
	        pmst.setBoolean(1, true);
	        pmst.setInt(2, userID);
	        pmst.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	public void unlockUser(int userID) {
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pmst = con.prepareStatement(query7);
	        pmst.setBoolean(1, false);
	        pmst.setInt(2, userID);
	        pmst.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	

	User extractResultSet(ResultSet res) throws SQLException {
		int id = res.getInt("userId");
		String name = res.getString("username");
		String email = res.getString("email");
		String address = res.getString("address");
		String password = res.getString("password");
		String role = res.getString("role");
		Timestamp createDate = res.getTimestamp("createDate");
		Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");
		boolean isLocked = res.getBoolean("isLocked");
		String image = res.getString("image");

		User user = new User(id,name,email,address,password,role,
		        createDate,lastLoginDate,isLocked,image);
		return user;
	}

	@Override
	public User getUserByName(String username) {
		// TODO Auto-generated method stub
		User user = null;
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(query6);
			pmst.setString(1, username);
			
			ResultSet res = pmst.executeQuery();
			while(res.next()) {
				user = extractResultSet(res);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return user;
	}
	
	public boolean userExists(String email) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(query8);
	        pmst.setString(1, email);
	        ResultSet rs = pmst.executeQuery();
	        return rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}

}
