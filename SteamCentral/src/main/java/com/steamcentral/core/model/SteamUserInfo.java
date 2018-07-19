package com.steamcentral.core.model;

import java.util.Objects;

/**
 * Simply stores crucial information about Steam user.
 * Mainly used by {@link com.steamcentral.core.service.StatsService}
 * 
 * @author Jakub Podgórski
 *
 */
public class SteamUserInfo implements Comparable<SteamUserInfo> {
	
	private String steamId, personaname, avatarMediumURL, avatarFullURL;
	private long playtimeTwoWeeks, playtimeForever;

	public SteamUserInfo(String steamId, long playtimeTwoWeeks, long playtimeForever) {
		this.steamId = steamId;
		this.playtimeTwoWeeks = playtimeTwoWeeks;
		this.playtimeForever = playtimeForever;
	}

	public String getAvatarMediumURL() {
		return avatarMediumURL;
	}

	public SteamUserInfo setAvatarMediumURL(String avatarMediumURL) {
		this.avatarMediumURL = avatarMediumURL;
		return this;
	}

	public String getAvatarFullURL() {
		return avatarFullURL;
	}

	public SteamUserInfo setAvatarFullURL(String avatarFullURL) {
		this.avatarFullURL = avatarFullURL;
		return this;
	}

	public String getSteamId() {
		return steamId;
	}

	public long getPlaytimeTwoWeeks() {
		return playtimeTwoWeeks;
	}

	public long getPlaytimeForever() {
		return playtimeForever;
	}
		
	public String getPersonaname() {
		return personaname;
	}

	public SteamUserInfo setPersonaname(String personaname) {
		this.personaname = personaname;
		return this;
	}

	@Override
	public int hashCode() {
		return Objects.hash(getSteamId());
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}
		
		if (obj == null) {
			return false;
		}
			
		if(!(obj instanceof SteamUserInfo)) {
			return false;
		}
		
		SteamUserInfo sui = (SteamUserInfo) obj;

		return steamId.equals(sui.getSteamId());
	}

	@Override
	public int compareTo(SteamUserInfo sui) {
		return personaname.toLowerCase().compareTo(sui.getPersonaname().toLowerCase());
	}
		
}
