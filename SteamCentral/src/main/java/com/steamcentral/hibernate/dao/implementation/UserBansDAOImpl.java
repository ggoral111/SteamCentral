package com.steamcentral.hibernate.dao.implementation;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.steamcentral.hibernate.dao.UserBansDAO;
import com.steamcentral.hibernate.pojo.UserBans;

@Repository
public class UserBansDAOImpl implements UserBansDAO {

	@Autowired
    private SessionFactory sessionFactory;
	
	public UserBansDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
    @Transactional
	public void saveOrUpdate(UserBans userBans) {
		sessionFactory.getCurrentSession().saveOrUpdate(userBans);		
	}

	@Override
	@Transactional
	public void delete(String steamId) {
		sessionFactory.getCurrentSession().delete(new UserBans().setSteamId(steamId));	
	}
	
	@Override
	@Transactional
	public UserBans get(String steamId) {
		return (UserBans) sessionFactory.getCurrentSession().get(UserBans.class, steamId);
	}

}
