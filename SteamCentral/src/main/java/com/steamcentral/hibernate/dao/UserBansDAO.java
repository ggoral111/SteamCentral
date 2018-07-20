package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.UserBans;

/**
 * Data Access Object interface implementation that provides access to an underlying database table (UserBans).
 * 
 * @author Jakub Podgórski
 *
 */
public interface UserBansDAO {
	
	/**
	 * Saves or updates an entry in UserBans table.
	 * 
	 * @param userBans the instance of {@link com.steamcentral.hibernate.pojo.UserBans} class which stores information about Steam user bans.
	 */
	void saveOrUpdate(UserBans userBans);
	
	/**
	 * Deletes an entry from UserBans table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 */
	void delete(String steamId);
	
	/**
	 * Gets an entry from UserBans table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 * @return the {@link com.steamcentral.hibernate.pojo.UserBans} object which contains information about Steam user bans.
	 */
	UserBans get(String steamId);
}
