package com.steamcentral.hibernate.pojo;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

/**
 * Plain Old Java Object UserBans class implementation that maps its attributes with the corresponding columns of the relational database.
 * 
 * @author Jakub Podgórski
 *
 */
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
	
	@Column(name = "LastUpdate")
	@JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	private LocalDateTime lastUpdate;
	
	/**
	 * Default constructor of UserBans. Creates {@link com.steamcentral.hibernate.pojo.UserBans} object.
	 */
	public UserBans() {
		
	}

	/**
	 * Constructor of UserBans. Creates {@link com.steamcentral.hibernate.pojo.UserBans} object with set of parameters described below.
	 * 
	 * @param steamId the unique string of numbers which represents Steam user profile.
	 * @param vacBanned the boolean variable which indicates that user is currently banned by Valve Anti-Cheat (VAC).
	 * @param economyBan the String variable which indicates that user is currently economy banned.
	 * @param numberOfVACBans the integer variable which stores information about amount of VAC bans gained by user.
	 * @param communityBanned the boolean variable which indicates that user is currently community banned.
	 * @param daysSinceLastBan the integer variable which stores information about amount of days since last ban.
	 * @param mumberOfGameBans the integer variable which stores information about amount of game bans gained by user.
	 */
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

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public UserBans setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
		return this;
	}
	
}
