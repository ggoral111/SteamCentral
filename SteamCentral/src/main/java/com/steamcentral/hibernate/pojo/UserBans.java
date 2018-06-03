package com.steamcentral.hibernate.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "UserBans")
@Table(name = "userbans")
public class UserBans {

	@Id
	@Column(name = "SteamId")
	private String steamId;
	
	@Column(name = "VACBanned")
	private boolean vacBanned;
	
	@Column(name = "EconomyBan")
	private String economyBan;
	
	@Column(name = "NumberOfVACBans")
	private int numberOfVACBans;
	
	@Column(name = "CommunityBanned")
	private boolean communityBanned;
	
	@Column(name = "DaysSinceLastBan")
	private int daysSinceLastBan;
	
	@Column(name = "NumberOfGameBans")
	private int mumberOfGameBans;
	
	public UserBans() {
		
	}

	public UserBans(String steamId, boolean vacBanned, String economyBan, int numberOfVACBans, boolean communityBanned, int daysSinceLastBan, int mumberOfGameBans) {
		this.steamId = steamId;
		this.vacBanned = vacBanned;
		this.economyBan = economyBan;
		this.numberOfVACBans = numberOfVACBans;
		this.communityBanned = communityBanned;
		this.daysSinceLastBan = daysSinceLastBan;
		this.mumberOfGameBans = mumberOfGameBans;
	}

	public String getSteamId() {
		return steamId;
	}

	public UserBans setSteamId(String steamId) {
		this.steamId = steamId;
		return this;
	}

	public boolean isVacBanned() {
		return vacBanned;
	}

	public UserBans setVacBanned(boolean vacBanned) {
		this.vacBanned = vacBanned;
		return this;
	}

	public String getEconomyBan() {
		return economyBan;
	}

	public UserBans setEconomyBan(String economyBan) {
		this.economyBan = economyBan;
		return this;
	}

	public int getNumberOfVACBans() {
		return numberOfVACBans;
	}

	public UserBans setNumberOfVACBans(int numberOfVACBans) {
		this.numberOfVACBans = numberOfVACBans;
		return this;
	}

	public boolean isCommunityBanned() {
		return communityBanned;
	}

	public UserBans setCommunityBanned(boolean communityBanned) {
		this.communityBanned = communityBanned;
		return this;
	}

	public int getDaysSinceLastBan() {
		return daysSinceLastBan;
	}

	public UserBans setDaysSinceLastBan(int daysSinceLastBan) {
		this.daysSinceLastBan = daysSinceLastBan;
		return this;
	}

	public int getMumberOfGameBans() {
		return mumberOfGameBans;
	}

	public UserBans setMumberOfGameBans(int mumberOfGameBans) {
		this.mumberOfGameBans = mumberOfGameBans;
		return this;
	}
	
}
