package com.steamcentral.hibernate.dao;

import com.steamcentral.hibernate.pojo.User;

public interface UserDAO {
	
	public void saveOrUpdate(User user);
	
	public void delete(String steamId);
	
	public User get(String steamId);
}
