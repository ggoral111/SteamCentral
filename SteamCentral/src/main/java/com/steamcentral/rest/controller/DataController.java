package com.steamcentral.rest.controller;

import java.util.Set;

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

@RestController
@RequestMapping("/data")
@EnableWebMvc
public class DataController {
	
	@Autowired
	private StatsService ss;
	
	@RequestMapping(value = "/stats/friendList", method = RequestMethod.POST)
	public ResponseEntity<String> getFriendListJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		Set<SteamUserInfo> friendList = ss.getFriendListFullInfo(steamId);
					
		if(friendList != null) {
			try {
				ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
				String friendListJSON = ow.writeValueAsString(friendList);				
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "application/json; charset=utf-8");
				
				return new ResponseEntity<String>(ow.writeValueAsString(friendListJSON), responseHeaders, HttpStatus.OK);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value = "/stats/strangerUserStats", method = RequestMethod.POST)
	public ResponseEntity<String> getStrangerStatsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		Object[] strangerUserStats = ss.getStrangerUserStats(steamId);
		
		if(strangerUserStats != null) {
			try {
				ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
				String userInfoJSON = ow.writeValueAsString(strangerUserStats[0]);
				String strangerUserStatsJSON = "{ \"userInfo\": " + userInfoJSON + ", \"userStats\": " + strangerUserStats[1] + " }";
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
	public ResponseEntity<String> getStatsJSON(@RequestBody String steamId, UriComponentsBuilder ucBuilder) {
		String userStatsJSON = ss.getUserStats(steamId);
		
		if(userStatsJSON != null) {
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
	
}