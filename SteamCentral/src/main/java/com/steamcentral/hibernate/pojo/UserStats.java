package com.steamcentral.hibernate.pojo;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import com.vladmihalcea.hibernate.type.json.JsonStringType;

@Entity(name = "UserStats")
@Table(name = "userstats")
@TypeDef(name = "json", typeClass = JsonStringType.class)
public class UserStats {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Id")
	private int id;
	
	@Column(name = "SteamId")
	private String steamId;
	
	@Column(name = "TotalKills")
	private int totalKills;
	
	@Column(name = "TotalDeaths")
	private int totalDeaths;
	
	@Type(type = "json")
	@Column(name = "Stats", columnDefinition = "json")
	private String stats;
	
	@Column(name = "CreationDate")
	@JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	private LocalDateTime creationDate;
	
	transient private long creationDateEpoch;
	
	public UserStats() {
		
	}

	public UserStats(String steamId, int totalKills, int totalDeaths, String stats) {
		this.steamId = steamId;
		this.totalKills = totalKills;
		this.totalDeaths = totalDeaths;
		this.stats = stats;
	}
	
	public UserStats(int id, String steamId, String stats, long creationDateEpoch) {
		this.id = id;
		this.steamId = steamId;
		this.stats = stats;
		this.creationDateEpoch = creationDateEpoch;
	}

	public int getId() {
		return id;
	}
	
	public UserStats setId(int id) {
		this.id = id;
		return this;
	}
	
	public String getSteamId() {
		return steamId;
	}

	public UserStats setSteamId(String steamId) {
		this.steamId = steamId;
		return this;
	}

	public int getTotalKills() {
		return totalKills;
	}

	public UserStats setTotalKills(int totalKills) {
		this.totalKills = totalKills;
		return this;
	}

	public int getTotalDeaths() {
		return totalDeaths;
	}
	
	public UserStats setTotalDeaths(int totalDeaths) {
		this.totalDeaths = totalDeaths;
		return this;
	}

	public String getStats() {
		return stats;
	}

	public UserStats setStats(String stats) {
		this.stats = stats;
		return this;
	}

	public LocalDateTime getCreationDate() {
		return creationDate;
	}

	public UserStats setCreationDate(LocalDateTime creationDate) {
		this.creationDate = creationDate;
		return this;
	}

	public long getCreationDateEpoch() {
		return creationDateEpoch;
	}

	public UserStats setCreationDateEpoch(long creationDateEpoch) {
		this.creationDateEpoch = creationDateEpoch;
		return this;
	}
	
}
