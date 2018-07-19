package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserLastMatch;

public interface UserLastMatchDAO {

	void saveOrUpdate(UserLastMatch userLastMatch);
	
	void delete(String steamId);
	
	UserLastMatch get(String steamId);

	List<UserLastMatch> getTopPlayers(int maxPlayers, int days);

	List<UserLastMatch> getTopPlayersDependingOnMatchType(int days, int maxPlayers, int minRoundsRange, int maxRoundsRange, int minRoundsToEndMatch, int maxPlayersInMatch);
}
