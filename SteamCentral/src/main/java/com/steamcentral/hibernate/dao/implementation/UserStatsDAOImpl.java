package com.steamcentral.hibernate.dao.implementation;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

	private final static int USERSTATS_MAX_ROWS_SIZE;
	private final static int USERSTATS_MIN_NUMBER_OF_DAYS_BETWEEN_INSERT;
	
	static {
		USERSTATS_MAX_ROWS_SIZE = 30;
		USERSTATS_MIN_NUMBER_OF_DAYS_BETWEEN_INSERT = 1;
	}
	
	@Autowired
    private SessionFactory sessionFactory;
	
	public UserStatsDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	@Transactional
	public void save(final UserStats userStats) {
		List<UserStats> userStatsList = getAll(userStats.getSteamId());
		
		if(!userStatsList.isEmpty()) {
			boolean readyToSave = false;			
			LocalDateTime LastUpdateDate = userStatsList.get(userStatsList.size() - 1).getCreationDate();
			LocalDateTime UpdateDateToCompare = LocalDateTime.now().minus(USERSTATS_MIN_NUMBER_OF_DAYS_BETWEEN_INSERT, ChronoUnit.DAYS);
			
			if(LastUpdateDate.compareTo(UpdateDateToCompare) <= 0 && userStatsList.get(userStatsList.size() - 1).getTotalKills() != userStats.getTotalKills() && userStatsList.get(userStatsList.size() - 1).getTotalDeaths() != userStats.getTotalDeaths()) {
				readyToSave = true;
			}
			
			if(readyToSave) {
				if(userStatsList.size() == USERSTATS_MAX_ROWS_SIZE) {
					sessionFactory.getCurrentSession().flush();
					sessionFactory.getCurrentSession().clear();
					sessionFactory.getCurrentSession().delete(new UserStats().setId(userStatsList.get(0).getId()));	
				}
				
				sessionFactory.getCurrentSession().save(userStats);
			}
		} else {
			sessionFactory.getCurrentSession().save(userStats);
		}		
	}
	
	@Override
	@Transactional
	public void deleteAllUserStats(String steamId) {
		sessionFactory.getCurrentSession().createQuery("delete from UserStats where steamId = '" + steamId + "'").executeUpdate();
	}

	@Override
	@Transactional
	public List<UserStats> getAll(String steamId) {
		CriteriaBuilder builder = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<UserStats> query = builder.createQuery(UserStats.class);
		Root<UserStats> userStatsRoot = query.from(UserStats.class);
		query.select(userStatsRoot);
		query.where(builder.equal(userStatsRoot.<String>get("steamId"), steamId));
		query.orderBy(builder.asc(userStatsRoot.<LocalDateTime>get("creationDate")));
				
		return sessionFactory.getCurrentSession().createQuery(query).getResultList();	
	}

}
