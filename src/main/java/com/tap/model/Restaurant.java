package com.tap.model;


public class Restaurant {
	private int restaurantID;
	private String restaurantName;
	private int ratings;
	private String ETA;
	private String cuisineType;
	private String discount;
	private String image;
	private String address;
	private boolean isActive;
	private int ownerUserID;
	private String tagline;
	
	public Restaurant() {
		
	}
	
	public Restaurant(int restaurantID, String restaurantName, int ratings, String eTA, String cuisineType,
			String discount, String image, String address, boolean isActive, int ownerUserID, String tagline) {
		super();
		this.restaurantID = restaurantID;
		this.restaurantName = restaurantName;
		this.ratings = ratings;
		ETA = eTA;
		this.cuisineType = cuisineType;
		this.discount = discount;
		this.image = image;
		this.address = address;
		this.isActive = isActive;
		this.ownerUserID = ownerUserID;
		this.tagline = tagline;
	}

	
	public Restaurant(String restaurantName, int ratings, String eTA, String cuisineType, String discount,
			String image, String address, boolean isActive, int ownerUserID, String tagline) {
		super();
		this.restaurantName = restaurantName;
		this.ratings = ratings;
		ETA = eTA;
		this.cuisineType = cuisineType;
		this.discount = discount;
		this.image = image;
		this.address = address;
		this.isActive = isActive;
		this.ownerUserID = ownerUserID;
		this.tagline = tagline;
	}

	public String getTagline() {
		return tagline;
	}

	public void setTagline(String tagline) {
		this.tagline = tagline;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public int getRatings() {
		return ratings;
	}

	public void setRatings(int ratings) {
		this.ratings = ratings;
	}

	public String getETA() {
		return ETA;
	}

	public void setETA(String eTA) {
		ETA = eTA;
	}

	public String getCuisineType() {
		return cuisineType;
	}

	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public int getOwnerUserID() {
		return ownerUserID;
	}

	public void setOwnerUserID(int ownerUserID) {
		this.ownerUserID = ownerUserID;
	}

	@Override
	public String toString() {
		return "Restaurant [restaurantID=" + restaurantID + ", restaurantName=" + restaurantName + ", ratings="
				+ ratings + ", ETA=" + ETA + ", cuisineType=" + cuisineType + ", discount=" + discount + ", image="
				+ image + ", address=" + address + ", isActive=" + isActive + ", ownerUserID=" + ownerUserID
				+ ", tagline=" + tagline + "]";
	}
	
	
}


