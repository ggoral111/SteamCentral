package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserLastMatch;

public interface UserLastMatchDAO {

	public void saveOrUpdate(UserLastMatch userLastMatch);
	
	public void delete(String steamId);
	
	public UserLastMatch get(String steamId);

	public List<UserLastMatch> getTopPlayers(int maxPlayers, int days);

	public List<UserLastMatch> getTopPlayersDependingOnMatchType(int days, int maxPlayers, int minRoundsRange, int maxRoundsRange, int minRoundsToEndMatch, int maxPlayersInMatch);
}
