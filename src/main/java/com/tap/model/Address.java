package com.tap.model;

import java.sql.Timestamp;

public class Address {
	public Address(int userID, int addressID, String label, String fullAddress, boolean isDefault) {
		super();
		this.userID = userID;
		this.addressID = addressID;
		this.label = label;
		this.fullAddress = fullAddress;
		this.isDefault = isDefault;
	}

	private int userID;
	private int addressID;
	private String label;
	private String fullAddress;
	private boolean isDefault;
	private Timestamp createtAt;
	
	public Address() {
		
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getFullAddress() {
		return fullAddress;
	}

	public void setFullAddress(String fullAddress) {
		this.fullAddress = fullAddress;
	}

	public boolean isDefault() {
		return isDefault;
	}

	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

	public Timestamp getCreatetAt() {
		return createtAt;
	}

	public void setCreatetAt(Timestamp createtAt) {
		this.createtAt = createtAt;
	}

	public Address(int userID, int addressID, String label, String fullAddress, boolean isDefault, Timestamp createtAt) {
		super();
		this.addressID = addressID;
		this.userID = userID;
		this.label = label;
		this.fullAddress = fullAddress;
		this.isDefault = isDefault;
		this.createtAt = createtAt;
	}

	@Override
	public String toString() {
		return "Addresses [userID=" + userID + ", addressID=" + addressID + ", label=" + label + ", fullAddress="
				+ fullAddress + ", isDefault=" + isDefault + ", createtAt=" + createtAt + "]";
	}

	public int getAddressID() {
		return addressID;
	}

	public void setAddressID(int addressID) {
		this.addressID = addressID;
	}
	
}
