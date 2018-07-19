package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.User;

public interface UserDAO {
	
	void saveOrUpdate(User user);
	
	void delete(String steamId);
	
	User get(String steamId);
}
