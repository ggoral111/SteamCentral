package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserLastMatch;

public interface UserLastMatchDAO {

	public void saveOrUpdate(UserLastMatch user);
	
	public void delete(String steamId);
	
	public UserLastMatch get(String steamId);
	
	public List<UserLastMatch> getAll();

	public List<UserLastMatch> getTopPlayers(int maxPlayers, int days);
}
