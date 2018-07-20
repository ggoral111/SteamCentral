package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.User;

/**
 * Data Access Object interface implementation that provides access to an underlying database table (User).
 * 
 * @author Jakub Podgórski
 *
 */
public interface UserDAO {
	
	/**
	 * Saves or updates an entry in User table.
	 * 
	 * @param user the instance of {@link com.steamcentral.hibernate.pojo.User} class which stores detailed information about Steam user.
	 */
	void saveOrUpdate(User user);
	
	/**
	 * Deletes an entry from User table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 */
	void delete(String steamId);
	
	/**
	 * Gets an entry from User table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 * @return the {@link com.steamcentral.hibernate.pojo.User} object which contains detailed information about Steam user.
	 */
	User get(String steamId);
}
