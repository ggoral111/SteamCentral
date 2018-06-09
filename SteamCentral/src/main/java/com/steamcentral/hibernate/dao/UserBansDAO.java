package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.UserBans;

public interface UserBansDAO {
	
	public void saveOrUpdate(UserBans userBans);
	
	public void delete(String steamId);
	
	public UserBans get(String steamId);
}
