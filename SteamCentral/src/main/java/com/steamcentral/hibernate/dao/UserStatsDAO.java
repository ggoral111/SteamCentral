package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserStats;

public interface UserStatsDAO {
	
	public void save(UserStats userStats);
	
	public void deleteAllUserStats(String steamId);
	
	public List<UserStats> getAll(String steamId);
}
