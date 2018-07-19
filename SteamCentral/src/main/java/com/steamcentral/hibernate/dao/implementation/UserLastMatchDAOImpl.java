package com.steamcentral.hibernate.dao.implementation;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

/**
 * Implementation of UserLastMatchDAO interface.
 * 
 * @author Jakub Podgórski
 *
 */
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
	public List<UserLastMatch> getTopPlayers(int maxPlayersMatches, int days) {
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserLastMatch> query = builder.createQuery(UserLastMatch.class);
		Root<UserLastMatch> userLastMatchRoot = query.from(UserLastMatch.class);
		LocalDateTime LastUpdateDate = LocalDateTime.now();
		
		query.select(userLastMatchRoot);
		query.where(builder.between(userLastMatchRoot.<LocalDateTime>get("lastUpdate"), LastUpdateDate.minus(days, ChronoUnit.DAYS), LastUpdateDate));
		query.orderBy(builder.desc(userLastMatchRoot.<Integer>get("scorePointResult")));
		
		return sessionFactory.getCurrentSession().createQuery(query).setMaxResults(maxPlayersMatches).getResultList();		
	}
	
	@Override
	@Transactional
	public List<UserLastMatch> getTopPlayersDependingOnMatchType(int days, int maxPlayersMatches, int minRoundsRange, int maxRoundsRange, int minRoundsToEndMatch, int maxPlayersInMatch) {
		// Deathmatch: minRoundsRange = 1 , maxRoundsRange = 1 , minRoundsToEndMatch = 1 , maxPlayersInMatch = 20
		// Matchmaking: minRoundsRange = 16 , maxRoundsRange = 30, minRoundsToEndMatch = 15, maxPlayersInMatch = 10
		// Wingman: minRoundsRange = 9 , maxRoundsRange = 16, minRoundsToEndMatch = 8, maxPlayersInMatch = 4
		// Casual: minRoundsRange = 8 , maxRoundsRange = 15, minRoundsToEndMatch = 8, maxPlayersInMatch = 20
		
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserLastMatch> query = builder.createQuery(UserLastMatch.class);
		Root<UserLastMatch> userLastMatchRoot = query.from(UserLastMatch.class);
		Expression<Integer> sum = builder.sum(userLastMatchRoot.<Integer>get("ctRoundsWin"), userLastMatchRoot.<Integer>get("ttRoundsWin"));
		LocalDateTime LastUpdateDate = LocalDateTime.now();
		
		query.select(userLastMatchRoot);
		query.where(builder.and(builder.between(userLastMatchRoot.<LocalDateTime>get("lastUpdate"), LastUpdateDate.minus(days, ChronoUnit.DAYS), LastUpdateDate), builder.between(sum, minRoundsRange, maxRoundsRange), builder.or(builder.greaterThanOrEqualTo(userLastMatchRoot.<Integer>get("ctRoundsWin"), minRoundsToEndMatch), builder.greaterThanOrEqualTo(userLastMatchRoot.<Integer>get("ttRoundsWin"), minRoundsToEndMatch)), builder.lessThanOrEqualTo(userLastMatchRoot.<Integer>get("matchMaxPlayers"), maxPlayersInMatch)));
		query.orderBy(builder.desc(userLastMatchRoot.<Integer>get("scorePointResult")));
		
		return sessionFactory.getCurrentSession().createQuery(query).setMaxResults(maxPlayersMatches).getResultList();
	}

}
