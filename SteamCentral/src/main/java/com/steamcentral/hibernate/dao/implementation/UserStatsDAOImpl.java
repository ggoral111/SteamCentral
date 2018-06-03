package com.steamcentral.hibernate.dao.implementation;

import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.steamcentral.hibernate.dao.UserStatsDAO;
import com.steamcentral.hibernate.pojo.UserStats;

@Repository
public class UserStatsDAOImpl implements UserStatsDAO {

	@Autowired
    private SessionFactory sessionFactory;
	
	public UserStatsDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	@Transactional
	public void save(final UserStats userStats) {
		sessionFactory.getCurrentSession().save(userStats);
	}
	
	@Override
	@Transactional
	public void deleteAllUserStats(String steamId) {
		sessionFactory.getCurrentSession().createQuery("delete from userstats where SteamId = '" + steamId + "'").executeUpdate();
	}

	@Override
	@Transactional
	public List<UserStats> getAll(String steamId) {
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserStats> query = builder.createQuery(UserStats.class);
		Root<UserStats> userStatsRoot = query.from(UserStats.class);
		query.select(userStatsRoot);
		query.where(builder.equal(userStatsRoot.<String>get("SteamId"), steamId));
		query.orderBy(builder.asc(userStatsRoot.<Date>get("LastUpdate")));
				
		return sessionFactory.getCurrentSession().createQuery(query).getResultList();	
	}

}
