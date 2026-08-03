package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.AddressDAO;
import com.tap.model.Address;
import com.tap.utility.DBConnection;

public class AddressDAOImpl implements AddressDAO{
	private static final String  GET_ADDRESS_BY_USER= "SELECT addressID, userID, label, fullAddress, isDefault, createdAt " +
		    "FROM addresses WHERE userID = ? ORDER BY isDefault DESC, addressID ASC";
	
	private static final String  ADD_ADDRESS= "INSERT INTO addresses (userID, label, fullAddress, isDefault) VALUES (?, ?, ?, ?)";

	private static final String SET_DEFAULT_ADDRESS = "UPDATE addresses SET isDefault = 1 WHERE addressID = ? AND userID = ?";

	private static final String DELETE_ADDRESS = "DELETE FROM addresses WHERE addressID = ?";
	        
	private static final String CLEAR_DEFAULT_FOR_USER ="UPDATE addresses SET isDefault = 0 WHERE userID = ?";
	
	private static final String GET_DEFAULT_ADDRESS =
		    "SELECT addressID, userID, label, fullAddress, isDefault " +
		    "FROM addresses WHERE userID = ? AND isDefault = 1 LIMIT 1";
	
	
	@Override
	public List<Address> getAddressesByUser(int userID) {
		// TODO Auto-generated method stub
		List<Address> addresses = new ArrayList<>();
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(GET_ADDRESS_BY_USER);
			pmst.setInt(1, userID);
			ResultSet rs = pmst.executeQuery();
			while (rs.next()) {
				Address addr = new Address(
					    rs.getInt("userID"),      // matches constructor's 1st param: userID
					    rs.getInt("addressID"),   // matches constructor's 2nd param: addressID
					    rs.getString("label"),
					    rs.getString("fullAddress"),
					    rs.getBoolean("isDefault"),
					    rs.getTimestamp("createdAt")
					);
                addresses.add(addr);
            }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return addresses;
	}

	@Override
	public void addAddress(int userID, String label, String fullAddress, boolean isDefault) {
		// TODO Auto-generated method stub
		Connection con = DBConnection.getConnection();
		try {
			if(isDefault) {
				PreparedStatement clear = con.prepareStatement(CLEAR_DEFAULT_FOR_USER);
				clear.setInt(1, userID);
				clear.executeUpdate();	
			}
			PreparedStatement pmst = con.prepareStatement(ADD_ADDRESS);
			pmst.setInt(1, userID);
            pmst.setString(2, label);
            pmst.setString(3, fullAddress);
            pmst.setBoolean(4, isDefault);
            pmst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void setDefaultAddress(int userID, int addressID) {
		// TODO Auto-generated method stub
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement clear = con.prepareStatement(CLEAR_DEFAULT_FOR_USER);
            clear.setInt(1, userID);
            clear.executeUpdate();

            PreparedStatement pmst = con.prepareStatement(SET_DEFAULT_ADDRESS);
            pmst.setInt(1, addressID);
            pmst.setInt(2, userID);
            pmst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void deleteAddress(int addressID) {
		// TODO Auto-generated method stub
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pmst = con.prepareStatement(DELETE_ADDRESS);
			pmst.setInt(1, addressID);
            pmst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Address getDefaultAddress(int userID) {
		// TODO Auto-generated method stub
	    Address addr = null;
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pmst = con.prepareStatement(GET_DEFAULT_ADDRESS);
	        pmst.setInt(1, userID);
	        ResultSet rs = pmst.executeQuery();
	        if (rs.next()) {
	            addr = new Address(
	            	rs.getInt("userID"),
	                rs.getInt("addressID"),
	                rs.getString("label"),
	                rs.getString("fullAddress"),
	                rs.getBoolean("isDefault")
	            );
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return addr;
	}

}
