package com.tap.model;

import java.sql.Timestamp;

public class User {
	private int userID;
	private String username;
	private String email;
	private String address;
	private String password;
	private String role;
	private Timestamp createDate;
	private Timestamp lastLoginDate;
	private boolean isLocked;
	private String image;
	
	public boolean isLocked() {
		return isLocked;
	}

	public void setLocked(boolean isLocked) {
		this.isLocked = isLocked;
	}

	public User() {
		
	}
	
	public User(int userID, String username, String email, String address, String password, String role,
			Timestamp createDate, Timestamp lastLoginDate, boolean isLocked, String image) {
		super();
		this.userID = userID;
		this.username = username;
		this.email = email;
		this.address = address;
		this.password = password;
		this.role = role;
		this.createDate = createDate;
		this.lastLoginDate = lastLoginDate;
		this.isLocked = isLocked;
		this.image = image;
	}
	
	public User(String username, String email, String address, String password, String role) {
		super();
		this.username = username;
		this.email = email;
		this.address = address;
		this.password = password;
		this.role = role;
	}
	
	public User(String username, String email, String address, String password, String role, Timestamp createDate,
			Timestamp lastLoginDate, String image) {
		super();
		this.username = username;
		this.email = email;
		this.address = address;
		this.password = password;
		this.role = role;
		this.createDate = createDate;
		this.lastLoginDate = lastLoginDate;
		this.image = image;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", username=" + username + ", email=" + email + ", address=" + address
				+ ", password=" + password + ", role=" + role + ", createDate=" + createDate + ", lastLoginDate="
				+ lastLoginDate + ", isLocked=" + isLocked + ", image=" + image + "]";
	}
	
	
	
}
