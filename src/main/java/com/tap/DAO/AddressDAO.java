package com.tap.DAO;

import java.util.List;

import com.tap.model.Address;

public interface AddressDAO {
    List<Address> getAddressesByUser(int userID);
    void addAddress(int userID, String label, String fullAddress, boolean isDefault);
    void setDefaultAddress(int userID, int addressID);
    void deleteAddress(int addressID);
    Address getDefaultAddress(int userID);
}
