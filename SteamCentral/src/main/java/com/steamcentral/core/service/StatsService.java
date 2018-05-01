package com.steamcentral.core.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.steamcentral.core.model.FileOperations;
import com.steamcentral.core.model.HttpConnection;
import com.steamcentral.core.model.SteamHelper;
import com.steamcentral.core.model.SteamUserInfo;

public class StatsService implements HttpConnection, FileOperations {
	
	private final static String TIMESTAMP_PATH, PRICES_FILE_PATH, DEFAULT_WEAPONS_FILE_PATH, CSGO_BACKPACK_URL, CSGO_STATS_URL, STEAM_FRIENDLIST_URL, STEAM_GAME_OWNED_URL, STEAM_PLAYER_SUMMARIES_URL, STEAM_RESOLVE_VANITY_URL;
	private final static int PROCESSORS_NUMBER, CSGO_BACKPACK_NORMAL_TIMEBREAK_MINUTES, CSGO_BACKPACK_ERROR_TIMEBREAK_MINUTES;
	
	static {
		TIMESTAMP_PATH = "src/main/resources/timestamp.date";
		PRICES_FILE_PATH = "src/main/resources/marketPrices.json";
		DEFAULT_WEAPONS_FILE_PATH = "src/main/resources/defaultWeapons.json";
		CSGO_BACKPACK_URL = "https://csgobackpack.net/api/GetItemsList/v2/?currency=USD&no_details=true";
		CSGO_STATS_URL = "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=" + SteamHelper.STEAM_WEB_API_KEY + "&steamid=";
		STEAM_FRIENDLIST_URL = "http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key=" + SteamHelper.STEAM_WEB_API_KEY + "&steamid=";
		STEAM_GAME_OWNED_URL = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v1/?key=" + SteamHelper.STEAM_WEB_API_KEY + "&format=json&steamid=";
		STEAM_PLAYER_SUMMARIES_URL = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" + SteamHelper.STEAM_WEB_API_KEY + "&steamids=";
		STEAM_RESOLVE_VANITY_URL = "http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=" + SteamHelper.STEAM_WEB_API_KEY + "&vanityurl=";
		// PROCESSORS_NUMBER = Runtime.getRuntime().availableProcessors();
		PROCESSORS_NUMBER = 32;
		CSGO_BACKPACK_NORMAL_TIMEBREAK_MINUTES = 240;
		CSGO_BACKPACK_ERROR_TIMEBREAK_MINUTES = 5;
	}

	private int csgoBackpackTimebreakInMinutes;
	private boolean firstTimePricesLoad, firstTimeDefaultWeaponsLoad;
	private Date marketPricesTimestamp;
	private final DateFormat timestampFormatter;
	private String marketPrices, defaultWeapons;

	public StatsService() {
		this.csgoBackpackTimebreakInMinutes = CSGO_BACKPACK_NORMAL_TIMEBREAK_MINUTES;
		this.firstTimePricesLoad = true;
		this.firstTimeDefaultWeaponsLoad = true;
		this.marketPricesTimestamp = null;
		this.timestampFormatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
		this.marketPrices = null;
		this.defaultWeapons = null;
	}
		
	public String getDefaultWeapons() {
		if(firstTimeDefaultWeaponsLoad) {
			defaultWeapons = readFile(DEFAULT_WEAPONS_FILE_PATH);
			firstTimeDefaultWeaponsLoad = false;
		}
		
		return defaultWeapons;
	}
	
	public Object[] getStrangerUserStats(String userInfo) {
		JSONObject userInfoObject = new JSONObject(userInfo);
		String steamId = userInfoObject.getString("steamId");
		
		if(userInfoObject.getBoolean("checkVanityUrl")) {
			String vanityResponse = getHttpContent(STEAM_RESOLVE_VANITY_URL + steamId);
			
			if(isJSON(vanityResponse)) {
				JSONObject vanityResponseObject = new JSONObject(vanityResponse);
				
				if(vanityResponseObject.getJSONObject("response").getInt("success") == 1) {
					steamId = vanityResponseObject.getJSONObject("response").getString("steamid");
				} else if(vanityResponseObject.getJSONObject("response").getInt("success") != 1 && userInfoObject.getBoolean("checkDigits")) {
					
				} else {
					return null;
				}
			} else {
				return null;
			}
		}
		
		SteamUserInfo sui = getGameOwnedInfo(steamId);
		
		if(sui != null) {
			sui = getFullUserInfo(sui);
			
			if(sui != null) {
				String csgoStats = getUserStats(sui.getSteamId());
				
				if(csgoStats != null) {
					return new Object[] {sui, csgoStats};
				}
			}
		}
		
		return null;
	}
	
	public String getUserInventory(String steamId) {
		String csgoInventory = getHttpContent("https://steamcommunity.com/profiles/" + steamId + "/inventory/json/730/2");
		
		if(isValidJSON(csgoInventory)) {
			return csgoInventory;
		}
		
		return null;
	}
	
	public String getUserStats(String steamId) {				
		String csgoStats = getHttpContent(CSGO_STATS_URL + steamId);
		
		if(isJSON(csgoStats)) {
			return csgoStats;
		}
		
		return null;
	}
	
	private SteamUserInfo getGameOwnedInfo(String steamId) {
		String userGameInfo = getHttpContent(STEAM_GAME_OWNED_URL + steamId + "&appids_filter[0]=730");
		
		if(isJSON(userGameInfo)) {
			JSONObject responseObject = new JSONObject(userGameInfo).getJSONObject("response");
			
			if(responseObject.has("game_count")) {
				if(responseObject.getInt("game_count") == 1) {
					JSONObject playtimeObject = responseObject.getJSONArray("games").getJSONObject(0);
					long playtimeTwoWeeks = playtimeObject.has("playtime_2weeks") ? playtimeObject.getLong("playtime_2weeks") : 0L;
					long playtimeForever = playtimeObject.has("playtime_forever") ? playtimeObject.getLong("playtime_forever") : 0L;
					
					return new SteamUserInfo(steamId, playtimeTwoWeeks, playtimeForever);
				}
			}	
		}
		
		return null;
	}
	
	private SteamUserInfo getFullUserInfo(SteamUserInfo userInfo) {
		String fullUserInfo = getHttpContent(STEAM_PLAYER_SUMMARIES_URL + userInfo.getSteamId());
		
		if(isJSON(fullUserInfo)) {
			JSONObject userInfoObject = new JSONObject(fullUserInfo).getJSONObject("response").getJSONArray("players").getJSONObject(0);
			return userInfo.setPersonaname(userInfoObject.getString("personaname")).setAvatarMediumURL(userInfoObject.getString("avatarmedium")).setAvatarFullURL(userInfoObject.getString("avatarfull"));			
		}
		
		return null;
	}
	
	public Set<SteamUserInfo> getFriendListFullInfo(String steamId) {
		Set<SteamUserInfo> friendListSet = getFriendList(steamId);
		
		if(friendListSet != null && !friendListSet.isEmpty()) {
			List<String> urlsDividedList = new ArrayList<>();
			int queriesAmount = (friendListSet.size() / 100) + (friendListSet.size() % 100 == 0 ? 0 : 1);
			
			for(int i=0; i<queriesAmount; i++) {
				urlsDividedList.add(friendListSet.stream().skip(i*100).limit(100).map(x -> x.getSteamId()).collect(Collectors.joining(",")));
			}
			
			ExecutorService friendsFullInfoThreadPool = Executors.newFixedThreadPool(PROCESSORS_NUMBER);
			
			for(String urls : urlsDividedList) {
				friendsFullInfoThreadPool.execute(() -> {	
					String friendListFullInfo = getHttpContent(STEAM_PLAYER_SUMMARIES_URL + urls);
					
					if(isJSON(friendListFullInfo)) {
						JSONArray friendListFullInfoArray = new JSONObject(friendListFullInfo).getJSONObject("response").getJSONArray("players");
						
						for(int i=0; i<friendListFullInfoArray.length(); i++) {
							String friendSteamId = friendListFullInfoArray.getJSONObject(i).getString("steamid");
							
							for(SteamUserInfo sui : friendListSet) {
								if(sui.getSteamId().equals(friendSteamId)) {
									sui.setPersonaname(friendListFullInfoArray.getJSONObject(i).getString("personaname")).setAvatarMediumURL(friendListFullInfoArray.getJSONObject(i).getString("avatarmedium")).setAvatarFullURL(friendListFullInfoArray.getJSONObject(i).getString("avatarfull"));	
									break;
								}
							}
						}
					}
				});
			}
			
			friendsFullInfoThreadPool.shutdown();
			
			try {
				if(!friendsFullInfoThreadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS)) {
					friendsFullInfoThreadPool.shutdownNow();
				}
			} catch (InterruptedException e) {
				friendsFullInfoThreadPool.shutdownNow();
				Thread.currentThread().interrupt();
			}
			
			return Collections.unmodifiableSet(friendListSet);
		}
				
		return null;
	}
	
	private Set<SteamUserInfo> getFriendList(String steamId) {
		String friendList = getHttpContent(STEAM_FRIENDLIST_URL + steamId + "&relationship=friend");
		
		if(isJSON(friendList)) {
			JSONArray friendListArray = new JSONObject(friendList).getJSONObject("friendslist").getJSONArray("friends");
			Set<SteamUserInfo> friendListSet = new HashSet<>();
			ExecutorService friendsThreadPool = Executors.newFixedThreadPool(PROCESSORS_NUMBER);
					
			for(int i=0; i<friendListArray.length(); i++) {
				String friendSteamId = friendListArray.getJSONObject(i).getString("steamid");
				
				friendsThreadPool.execute(() -> {	
					SteamUserInfo sui = getGameOwnedInfo(friendSteamId);
					
					if(sui != null) {
						friendListSet.add(sui);		
					}
				});
			}
			
			friendsThreadPool.shutdown();
			
			try {
				if(!friendsThreadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS)) {
					friendsThreadPool.shutdownNow();
				}
			} catch (InterruptedException e) {
				friendsThreadPool.shutdownNow();
				Thread.currentThread().interrupt();
			}
			
			return friendListSet;
		}
		
		return null;
	}

	public String getSkinsPrices() {
		boolean timestampExpired;
					
		if(firstTimePricesLoad) {
			String dateFromFile = readFileWithLock(TIMESTAMP_PATH);
			
			if(dateFromFile != null) {
				try {
					marketPricesTimestamp = timestampFormatter.parse(dateFromFile);
					timestampExpired = checkTimestamp(marketPricesTimestamp);
				} catch(ParseException e) {
					timestampExpired = true;
				}								
			} else {
				timestampExpired = true;
			}		
			
			firstTimePricesLoad = false;
		} else {
			timestampExpired = checkTimestamp(marketPricesTimestamp);
		}
						
		if(timestampExpired) {
			String tempMarketPrices = getHttpContent(CSGO_BACKPACK_URL);
			marketPricesTimestamp = new Date();
			writeFileWithLock(TIMESTAMP_PATH, marketPricesTimestamp.toString());
						
			if(isValidJSON(tempMarketPrices)) {
				writeFileWithLock(PRICES_FILE_PATH, tempMarketPrices);
				marketPrices = tempMarketPrices;
				csgoBackpackTimebreakInMinutes = CSGO_BACKPACK_NORMAL_TIMEBREAK_MINUTES;
			} else {
				if(marketPrices == null) {
					marketPrices = readFileWithLock(PRICES_FILE_PATH);
				}
				
				csgoBackpackTimebreakInMinutes = CSGO_BACKPACK_ERROR_TIMEBREAK_MINUTES;
			}								
		} else {
			if(marketPrices == null) {
				marketPrices = readFileWithLock(PRICES_FILE_PATH);
			}
		}
		
		return marketPrices;
	}

	private boolean checkTimestamp(Date lastUpdate) {
		try {
			Date tenMinutes = new Date(System.currentTimeMillis() - 1000 * 60 * csgoBackpackTimebreakInMinutes);
			return lastUpdate.before(tenMinutes);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean isValidJSON(String jsonString) {
		try {
			JSONObject jsonObjectFromString = new JSONObject(jsonString);
			
			if(jsonObjectFromString.has("success")) {
				if(!jsonObjectFromString.getBoolean("success")) {
					return false;
				}
			} else {
				return false;
			}
		} catch (JSONException ex) {
			return false;
		}

		return true;
	}

	@Override
	public boolean isJSON(String jsonString) {
		try {
			new JSONObject(jsonString);
		} catch (JSONException ex) {
			try {
				new JSONArray(jsonString);
			} catch (JSONException e) {
				return false;
			}
		}

		return true;
	}
}
