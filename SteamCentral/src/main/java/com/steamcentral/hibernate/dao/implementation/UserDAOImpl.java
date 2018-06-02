package com.steamcentral.hibernate.dao.implementation;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.steamcentral.hibernate.dao.UserDAO;
import com.steamcentral.hibernate.pojo.User;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
    private SessionFactory sessionFactory;
	
	public UserDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

	@Override
    @Transactional
	public void saveOrUpdate(User user) {
		sessionFactory.getCurrentSession().saveOrUpdate(user);		
	}

	@Override
    @Transactional
	public void delete(String steamId) {
        sessionFactory.getCurrentSession().delete(new User().setSteamId(steamId));
	}
	
	@Override
	@Transactional
	public User get(String steamId) {
		return (User) sessionFactory.getCurrentSession().get(User.class, steamId);
	}
	
}
