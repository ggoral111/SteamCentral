package com.steamcentral.rest.controller;

import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.steamcentral.core.model.SteamUserInfo;
import com.steamcentral.core.service.StatsService;
import com.steamcentral.hibernate.dao.UserBansDAO;
import com.steamcentral.hibernate.dao.UserDAO;
import com.steamcentral.hibernate.dao.UserLastMatchDAO;
import com.steamcentral.hibernate.dao.UserStatsDAO;
import com.steamcentral.hibernate.pojo.User;
import com.steamcentral.hibernate.pojo.UserBans;
import com.steamcentral.hibernate.pojo.UserLastMatch;
import com.steamcentral.hibernate.pojo.UserStats;

/**
 * Class which controls all application front-end data requests (GET, POST) and returns processed data in JSON format.
 * 
 * @author Jakub Podgórski
 *
 */
@RestController
@RequestMapping("/data")
@EnableWebMvc
public class DataController {
	
	@Autowired
	private StatsService ss;
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private UserBansDAO userBansDao;
	
	@Autowired
	private UserLastMatchDAO userLastMatchDao;
	
	@Autowired
	private UserStatsDAO userStatsDao;
	
	@RequestMapping(value = "/stats/friendList", method = RequestMethod.POST)
	public ResponseEntity<String> getFriendListJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		Set<SteamUserInfo> friendList = ss.getFriendListFullInfo(steamId);
					
		if(friendList != null) {
			try {
				ObjectWriter ow = new ObjectMapper().writer();
				String friendListJSON = ow.writeValueAsString(friendList);				
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "application/json; charset=utf-8");
				
				return new ResponseEntity<String>(friendListJSON, responseHeaders, HttpStatus.OK);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	/**
	 * 
	 * 
	 * @param steamId
	 * @param ucBuilder
	 * @return
	 */
	@RequestMapping(value = "/stats/mainUserStats", method = RequestMethod.POST)
	public ResponseEntity<String> getMainUserStatsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		Object[] mainUserStats = ss.getStrangerUserStats(steamId);
		
		if(mainUserStats != null) {
			try {
				SteamUserInfo sui = (SteamUserInfo) mainUserStats[0];
				userDao.saveOrUpdate(new User(sui.getSteamId(), sui.getPersonaname(), sui.getAvatarMediumURL(), sui.getAvatarFullURL()));
				JSONObject userBansObject = new JSONObject((String) mainUserStats[1]);
				userBansDao.saveOrUpdate(new UserBans(userBansObject.getString("SteamId"), userBansObject.getBoolean("VACBanned"), userBansObject.getString("EconomyBan"), userBansObject.getInt("NumberOfVACBans"), userBansObject.getBoolean("CommunityBanned"), userBansObject.getInt("DaysSinceLastBan"), userBansObject.getInt("NumberOfGameBans")));
				JSONArray userStatsArray = new JSONObject((String) mainUserStats[2]).getJSONObject("playerstats").getJSONArray("stats");
				
				int ctRoundsWin = 0, ttRoundsWin = 0, playerRoundsWin = 0, matchMaxPlayers = 0, kills = 0, deaths = 0, totalDamage = 0, mvp = 0, scorePointResult = 0, totalKills = 0, totalDeaths = 0;
				
				for(int i=0; i<userStatsArray.length(); i++) {					
					if(userStatsArray.getJSONObject(i).getString("name").equals("total_kills")) {
						totalKills = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("total_deaths")) {
						totalDeaths = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_t_wins")) {
						ttRoundsWin = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_ct_wins")) {
						ctRoundsWin = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_wins")) {
						playerRoundsWin = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_max_players")) {
						matchMaxPlayers = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_kills")) {
						kills = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_deaths")) {
						deaths = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_mvps")) {
						mvp = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_damage")) {
						totalDamage = userStatsArray.getJSONObject(i).getInt("value");
					} else if(userStatsArray.getJSONObject(i).getString("name").equals("last_match_contribution_score")) {
						scorePointResult = userStatsArray.getJSONObject(i).getInt("value");
					}
				}
				
				userLastMatchDao.saveOrUpdate(new UserLastMatch(sui.getSteamId(), ctRoundsWin, ttRoundsWin, playerRoundsWin, matchMaxPlayers, kills, deaths, totalDamage, mvp, scorePointResult));
				userStatsDao.save(new UserStats(sui.getSteamId(), totalKills, totalDeaths, userStatsArray.toString()));
				
				ObjectWriter ow = new ObjectMapper().writer();
				String userInfoJSON = ow.writeValueAsString(mainUserStats[0]);
				String mainUserStatsJSON = "{ \"userInfo\": " + userInfoJSON + ", \"userBansInfo\": " + mainUserStats[1] + ", \"userStats\": " + mainUserStats[2] + " }";
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "application/json; charset=utf-8");
				
				return new ResponseEntity<String>(mainUserStatsJSON, responseHeaders, HttpStatus.OK);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/strangerUserStats", method = RequestMethod.POST)
	public ResponseEntity<String> getStrangerUserStatsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		Object[] strangerUserStats = ss.getStrangerUserStats(steamId);
		
		if(strangerUserStats != null) {
			try {
				ObjectWriter ow = new ObjectMapper().writer();
				String userInfoJSON = ow.writeValueAsString(strangerUserStats[0]);
				String strangerUserStatsJSON = "{ \"userInfo\": " + userInfoJSON + ", \"userBansInfo\": " + strangerUserStats[1] + ", \"userStats\": " + strangerUserStats[2] + " }";
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "application/json; charset=utf-8");
				
				return new ResponseEntity<String>(strangerUserStatsJSON, responseHeaders, HttpStatus.OK);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/userStats", method = RequestMethod.POST)
	public ResponseEntity<String> getUserStatsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		String[] userStatsWithBans = ss.getUserStatsWithBans(steamId);
		
		if(userStatsWithBans != null) {
			String userStatsJSON = "{ \"userBansInfo\": " + userStatsWithBans[0] + ", \"userStats\": " + userStatsWithBans[1] + " }";	
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "application/json; charset=utf-8");
			
			return new ResponseEntity<String>(userStatsJSON, responseHeaders, HttpStatus.OK);
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/userInventory", method = RequestMethod.POST)
	public ResponseEntity<String> getUserInventoryJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		String userInventoryJSON = ss.getUserInventory(steamId);
		
		if(userInventoryJSON != null) {
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "application/json; charset=utf-8");
			
			return new ResponseEntity<String>(userInventoryJSON, responseHeaders, HttpStatus.OK);
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/defaultWeapons", method = RequestMethod.GET)
	public ResponseEntity<String> getDefaultWeaponsJSON() {
		String defaultWeaponsJSON = ss.getDefaultWeapons();
		
		if(defaultWeaponsJSON != null) {
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "application/json; charset=utf-8");
			
			return new ResponseEntity<String>(defaultWeaponsJSON, responseHeaders, HttpStatus.OK);
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/skinsPrices", method = RequestMethod.GET)
	public ResponseEntity<String> getSkinsPricesJSON() {
		String skinsPricesJSON = ss.getSkinsPrices();
		
		if(skinsPricesJSON != null) {
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "application/json; charset=utf-8");
			
			return new ResponseEntity<String>(skinsPricesJSON, responseHeaders, HttpStatus.OK);
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/userStatsDataForCharts", method = RequestMethod.POST)
	public ResponseEntity<String> getUserStatsDataForChartsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		List<UserStats> userStatsList = userStatsDao.getAll(steamId);
		List<UserStats> userStatsEpochList = new ArrayList<>();
		
		for(UserStats us : userStatsList) {
			userStatsEpochList.add(new UserStats(us.getId(), us.getSteamId(), us.getStats(), us.getCreationDate().atZone(ZoneId.systemDefault()).toInstant().toEpochMilli()));
		}
				
		if(userStatsEpochList != null) {
			try {
				ObjectWriter ow = new ObjectMapper().writer();
				String userStatsListJSON = ow.writeValueAsString(userStatsEpochList);				
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "application/json; charset=utf-8");
				
				return new ResponseEntity<String>(userStatsListJSON, responseHeaders, HttpStatus.OK);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
}