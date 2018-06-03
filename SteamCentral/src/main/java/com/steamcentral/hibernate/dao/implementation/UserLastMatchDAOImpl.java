package com.steamcentral.hibernate.dao.implementation;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Root;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.steamcentral.hibernate.dao.UserLastMatchDAO;
import com.steamcentral.hibernate.pojo.UserLastMatch;

@Repository
public class UserLastMatchDAOImpl implements UserLastMatchDAO {

	@Autowired
    private SessionFactory sessionFactory;
	
	public UserLastMatchDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	@Transactional
	public void saveOrUpdate(UserLastMatch userLastMatch) {
		sessionFactory.getCurrentSession().saveOrUpdate(userLastMatch);		
	}


	@Override
	@Transactional
	public void delete(String steamId) {
		sessionFactory.getCurrentSession().delete(new UserLastMatch().setSteamId(steamId));		
	}


	@Override
	@Transactional
	public UserLastMatch get(String steamId) {
		return (UserLastMatch) sessionFactory.getCurrentSession().get(UserLastMatch.class, steamId);
	}
	
	@Override
	@Transactional
	public List<UserLastMatch> getAll() {
		CriteriaQuery<UserLastMatch> query = sessionFactory.getCurrentSession().getCriteriaBuilder().createQuery(UserLastMatch.class);
		Root<UserLastMatch> userLastMatchRoot = query.from(UserLastMatch.class);
		query.select(userLastMatchRoot);
		
		return sessionFactory.getCurrentSession().createQuery(query).getResultList();
	}
	
	@Override
	@Transactional
	public List<UserLastMatch> getTopPlayers(int maxPlayers, int days) {
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserLastMatch> query = builder.createQuery(UserLastMatch.class);
		Root<UserLastMatch> userLastMatchRoot = query.from(UserLastMatch.class);
		
		Date LastUpdateDate = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(LastUpdateDate);
		cal.add(Calendar.DATE, -days);
		
		query.select(userLastMatchRoot);
		query.where(builder.between(userLastMatchRoot.<Date>get("LastUpdate"), cal.getTime(), LastUpdateDate));
		query.orderBy(builder.desc(userLastMatchRoot.<Integer>get("ScorePointResult")));
		
		return sessionFactory.getCurrentSession().createQuery(query).setMaxResults(maxPlayers).getResultList();		
	}
	
	@Override
	@Transactional
	public List<UserLastMatch> getTopPlayersDependingOnMatchType(int days, int maxPlayers, int minRoundsRange, int maxRoundsRange, int minRoundsToEndMatch, int maxPlayersInMatch) {
		// Deathmatch: minRoundsRange = 1 , maxRoundsRange = 1 , minRoundsToEndMatch = 1 , maxPlayersInMatch = 20
		// Matchmaking: minRoundsRange = 16 , maxRoundsRange = 30, minRoundsToEndMatch = 15, maxPlayersInMatch = 10
		// Wingman: minRoundsRange = 9 , maxRoundsRange = 16, minRoundsToEndMatch = 8, maxPlayersInMatch = 4
		// Casual: minRoundsRange = 8 , maxRoundsRange = 15, minRoundsToEndMatch = 8, maxPlayersInMatch = 20
		
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserLastMatch> query = builder.createQuery(UserLastMatch.class);
		Root<UserLastMatch> userLastMatchRoot = query.from(UserLastMatch.class);
		Expression<Integer> sum = builder.sum(userLastMatchRoot.<Integer>get("CTRoundsWin"), userLastMatchRoot.<Integer>get("TTRoundsWin"));
		
		Date LastUpdateDate = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(LastUpdateDate);
		cal.add(Calendar.DATE, -days);
		
		query.select(userLastMatchRoot);
		query.where(builder.and(builder.between(userLastMatchRoot.<Date>get("LastUpdate"), cal.getTime(), LastUpdateDate), builder.between(sum, minRoundsRange, maxRoundsRange), builder.or(builder.greaterThanOrEqualTo(userLastMatchRoot.<Integer>get("CTRoundsWin"), minRoundsToEndMatch), builder.greaterThanOrEqualTo(userLastMatchRoot.<Integer>get("TTRoundsWin"), minRoundsToEndMatch)), builder.lessThanOrEqualTo(userLastMatchRoot.<Integer>get("MatchMaxPlayers"), maxPlayersInMatch)));
		query.orderBy(builder.desc(userLastMatchRoot.<Integer>get("ScorePointResult")));
		
		return sessionFactory.getCurrentSession().createQuery(query).setMaxResults(maxPlayers).getResultList();	
	}

}
