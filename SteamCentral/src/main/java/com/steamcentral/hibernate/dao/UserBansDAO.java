package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.UserBans;

public interface UserBansDAO {

	/*public UserBans save(UserBans userBans);*/
	
	public void saveOrUpdate(UserBans user);
	
	public void delete(String steamId);
	
	public UserBans get(String steamId);
}
