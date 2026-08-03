package com.tap.DAO;

import java.util.List;

import com.tap.model.User;

public interface UserDAO {
	void addUser(User user);
	User getUser(int userID);
	void updateUser(User user);
	void deleteUser(int userID);
	User getUserByName(String username);
	public void lockUser(int userID);
	public void unlockUser(int userID);
	public boolean userExists(String email);
	
	List<User> getAllUser();
}
