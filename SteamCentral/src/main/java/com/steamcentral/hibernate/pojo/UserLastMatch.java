package com.steamcentral.hibernate.pojo;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

@Entity(name = "UserLastMatch")
@Table(name = "userlastmatch")
public class UserLastMatch {

	@Id
	@Column(name = "SteamId")
	private String steamId;
	
	@Column(name = "CTRoundsWin")
	private int ctRoundsWin;
	
	@Column(name = "TTRoundsWin")
	private int ttRoundsWin;
	
	@Column(name = "PlayerRoundsWin")
	private int playerRoundsWin;
	
	@Column(name = "MatchMaxPlayers")
	private int matchMaxPlayers;
	
	@Column(name = "Kills")
	private int kills;
	
	@Column(name = "Deaths")
	private int deaths;
	
	@Column(name = "TotalDamage")
	private int totalDamage;
	
	@Column(name = "MVP")
	private int mvp;
	
	@Column(name = "ScorePointResult")
	private int scorePointResult;
	
	@Column(name = "LastUpdate")
	@JsonFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	private LocalDateTime lastUpdate;
	
	public UserLastMatch() {
		
	}

	public UserLastMatch(String steamId, int ctRoundsWin, int ttRoundsWin, int playerRoundsWin, int matchMaxPlayers, int kills, int deaths, int totalDamage, int mvp, int scorePointResult) {
		this.steamId = steamId;
		this.ctRoundsWin = ctRoundsWin;
		this.ttRoundsWin = ttRoundsWin;
		this.playerRoundsWin = playerRoundsWin;
		this.matchMaxPlayers = matchMaxPlayers;
		this.kills = kills;
		this.deaths = deaths;
		this.totalDamage = totalDamage;
		this.mvp = mvp;
		this.scorePointResult = scorePointResult;
	}

	public String getSteamId() {
		return steamId;
	}

	public UserLastMatch setSteamId(String steamId) {
		this.steamId = steamId;
		return this;
	}

	public int getCtRoundsWin() {
		return ctRoundsWin;
	}

	public UserLastMatch setCtRoundsWin(int ctRoundsWin) {
		this.ctRoundsWin = ctRoundsWin;
		return this;
	}

	public int getTtRoundsWin() {
		return ttRoundsWin;
	}

	public UserLastMatch setTtRoundsWin(int ttRoundsWin) {
		this.ttRoundsWin = ttRoundsWin;
		return this;
	}

	public int getPlayerRoundsWin() {
		return playerRoundsWin;
	}

	public UserLastMatch setPlayerRoundsWin(int playerRoundsWin) {
		this.playerRoundsWin = playerRoundsWin;
		return this;
	}

	public int getMatchMaxPlayers() {
		return matchMaxPlayers;
	}

	public UserLastMatch setMatchMaxPlayers(int matchMaxPlayers) {
		this.matchMaxPlayers = matchMaxPlayers;
		return this;
	}

	public int getKills() {
		return kills;
	}

	public UserLastMatch setKills(int kills) {
		this.kills = kills;
		return this;
	}

	public int getDeaths() {
		return deaths;
	}

	public UserLastMatch setDeaths(int deaths) {
		this.deaths = deaths;
		return this;
	}

	public int getTotalDamage() {
		return totalDamage;
	}

	public UserLastMatch setTotalDamage(int totalDamage) {
		this.totalDamage = totalDamage;
		return this;
	}

	public int getMvp() {
		return mvp;
	}

	public UserLastMatch setMvp(int mvp) {
		this.mvp = mvp;
		return this;
	}

	public int getScorePointResult() {
		return scorePointResult;
	}

	public UserLastMatch setScorePointResult(int scorePointResult) {
		this.scorePointResult = scorePointResult;
		return this;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public UserLastMatch setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
		return this;
	}
	
}
