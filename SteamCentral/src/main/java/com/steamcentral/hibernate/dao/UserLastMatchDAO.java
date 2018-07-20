package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserLastMatch;

/**
 * Data Access Object interface implementation that provides access to an underlying database table (UserLastMatch).
 * 
 * @author Jakub Podgórski
 *
 */
public interface UserLastMatchDAO {

	/**
	 * Saves or updates an entry in UserLastMatch table.
	 * 
	 * @param userLastMatch the instance of {@link com.steamcentral.hibernate.pojo.UserLastMatch} class which stores detailed information about user's last played match in Counter-Strike: Global Offensive game.
	 */
	void saveOrUpdate(UserLastMatch userLastMatch);
	
	/**
	 * Deletes an entry from UserLastMatch table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 */
	void delete(String steamId);
	
	/**
	 * Gets an entry from UserLastMatch table using the given Steam user ID.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 * @return the {@link com.steamcentral.hibernate.pojo.UserLastMatch} object which contains detailed information about user's last played match in Counter-Strike: Global Offensive game.
	 */
	UserLastMatch get(String steamId);

	/**
	 * Gets a list of top players limited by a number of players and the number of days that have passed since now.
	 * 
	 * @param maxPlayers the number of top players who should be included in the returned list.
	 * @param days the number of days which passed since now and should be included in the returned result.
	 * @return the list of {@link com.steamcentral.hibernate.pojo.UserLastMatch} objects which includes top players limited by a number of players and the number of days that have passed since now.
	 */
	List<UserLastMatch> getTopPlayers(int maxPlayers, int days);

	/**
	 * Gets a list of top players limited by a number of players, the number of days that have passed since now and specific game match type.
	 * 
	 * Individual types of matches and variables values are described below:
	 * <pre>
	 * - Deathmatch: minRoundsRange = 1 , maxRoundsRange = 1 , minRoundsToEndMatch = 1 , maxPlayersInMatch = 20
	 * - Matchmaking: minRoundsRange = 16 , maxRoundsRange = 30, minRoundsToEndMatch = 15, maxPlayersInMatch = 10
	 * - Wingman: minRoundsRange = 9 , maxRoundsRange = 16, minRoundsToEndMatch = 8, maxPlayersInMatch = 4
	 * - Casual: minRoundsRange = 8 , maxRoundsRange = 15, minRoundsToEndMatch = 8, maxPlayersInMatch = 20
	 * </pre>
	 * 
	 * @param days the number of days that have passed since now.
	 * @param maxPlayers the number of top players who should be included in the returned list.
	 * @param minRoundsRange the minimum number of rounds which was played in player last match.
	 * @param maxRoundsRange the maximum number of rounds which was played in player last match.
	 * @param minRoundsToEndMatch the minimum number of rounds which are obligatory to end match before all rounds are played.
	 * @param maxPlayersInMatch the maximum number of player who was able to play in player last match.
	 * @return the list of {@link com.steamcentral.hibernate.pojo.UserLastMatch} objects which includes top players limited by a number of players, the number of days that have passed since now and specific game match type.
	 */
	List<UserLastMatch> getTopPlayersDependingOnMatchType(int days, int maxPlayers, int minRoundsRange, int maxRoundsRange, int minRoundsToEndMatch, int maxPlayersInMatch);
}
