package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserStats;

/**
 * Data Access Object interface implementation that provides access to an underlying database table (UserStats).
 * 
 * @author Jakub Podgórski
 *
 */
public interface UserStatsDAO {
	
	/**
	 * Saves an entry in UserStats table.
	 * 
	 * @param userStats the instance of {@link com.steamcentral.hibernate.pojo.UserStats} class which stores detailed information about Steam user statistics.
	 */
	void save(UserStats userStats);
	
	/**
	 * Deletes entries from UserStats table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 */
	void deleteAllUserStats(String steamId);
	
	/**
	 * Gets list of entries from UserStats table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 * @return the list of {@link com.steamcentral.hibernate.pojo.UserStats} objects which contains all statistics entries connected with a specified Steam user.
	 */
	List<UserStats> getAll(String steamId);
}
