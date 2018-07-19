package com.steamcentral.hibernate.dao;

import java.util.List;

import com.steamcentral.hibernate.pojo.UserStats;

public interface UserStatsDAO {
	
	void save(UserStats userStats);
	
	void deleteAllUserStats(String steamId);
	
	List<UserStats> getAll(String steamId);
}
