package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.UserBans;

public interface UserBansDAO {
	
	void saveOrUpdate(UserBans userBans);
	
	void delete(String steamId);
	
	UserBans get(String steamId);
}
