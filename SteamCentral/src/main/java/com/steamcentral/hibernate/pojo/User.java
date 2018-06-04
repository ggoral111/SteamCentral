package com.steamcentral.hibernate.pojo;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "User")
@Table(name = "user")
public class User {
	
	@Id
	@Column(name = "SteamId")
	private String steamId;
	
	@Column(name = "Personaname")
	private String personaname;
	
	@Column(name = "AvatarMediumURL")
	private String avatarMediumURL;
	
	@Column(name = "AvatarFullURL")
	private String avatarFullURL;
	
	@Column(name = "LastUpdate")
	private LocalDateTime lastUpdate;
	
	@Column(name = "CreationDate")
	private LocalDateTime creationDate;
	
	public User() {
		
	}

	public User(String steamId, String personaname, String avatarMediumURL, String avatarFullURL) {
		this.steamId = steamId;
		this.personaname = personaname;
		this.avatarMediumURL = avatarMediumURL;
		this.avatarFullURL = avatarFullURL;
	}

	public String getSteamId() {
		return steamId;
	}

	public User setSteamId(String steamId) {
		this.steamId = steamId;
		return this;
	}

	public String getPersonaname() {
		return personaname;
	}

	public User setPersonaname(String personaname) {
		this.personaname = personaname;
		return this;
	}

	public String getAvatarMediumURL() {
		return avatarMediumURL;
	}

	public User setAvatarMediumURL(String avatarMediumURL) {
		this.avatarMediumURL = avatarMediumURL;
		return this;
	}

	public String getAvatarFullURL() {
		return avatarFullURL;
	}

	public User setAvatarFullURL(String avatarFullURL) {
		this.avatarFullURL = avatarFullURL;
		return this;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public User setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
		return this;
	}

	public LocalDateTime getCreationDate() {
		return creationDate;
	}

	public User setCreationDate(LocalDateTime creationDate) {
		this.creationDate = creationDate;
		return this;
	}
	
}
