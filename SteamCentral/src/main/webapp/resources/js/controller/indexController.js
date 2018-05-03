$('ul#ul-switch-stats').on('click', 'li', function(){
    $('ul#ul-switch-stats li').removeClass('active');
    $(this).addClass('active');
});

function smoothscroll() {
    var currentScroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currentScroll > 0) {
         window.requestAnimationFrame(smoothscroll);
         window.scrollTo (0,currentScroll - (currentScroll/20));
    }
};

var indexController = angular.module('indexController',[]);

indexController.controller('indexCtrl', ['$scope', '$http', '$filter', '$compile', function($scope, $http, $filter, $compile) {
	$scope.dateCreation = '2018';
	$scope.steamId = '76561198078305233';
	$scope.url = "/SteamCentral/data";
	$scope.imageUrl = 'https://steamcommunity-a.akamaihd.net/economy/image/';
	
	$scope.friendList = null;
	$scope.defaultWeapons = null;
	$scope.skinsPrices = null;
	
	$scope.mainUserStats = null;
	$scope.mainUserInventory = null;
	$scope.mainUserWeaponsStats = null;
	 
	$scope.friendUserStats = null;
	$scope.friendUserInventory = null;
	$scope.friendUserWeaponsStats = null;
	
	$scope.hideMainUserStatsGeneralLoading = false;
	$scope.hideMainUserStatsGeneral = true;
	$scope.hideMainUserStatsWeaponsLoading = true;
	$scope.hideMainUserStatsWeapons = true;
	
	$scope.hideFailStatsDownloadingError = true;
	$scope.hideFailUserInventoryDownloadingWarning = true;
	$scope.hideFailSkinsPricesDownloadingWarning = true;
	$scope.hideFailDefaultWeaponsDownloadingError = true;
	
	$scope.hideFooter = true;
	
	/*
	 * Watch mainUserWeaponsStats scope
	 */
	$scope.$watch("mainUserWeaponsStats", function(newValue, oldValue) {
		if(newValue != null) {
			console.log('Watch: ' + $(".col-csgostats-grid-weapon-name").width());
		}
	});
	
	/*
	 * Add footer css properties
	 */
	$scope.addFooterCssProperties = function() {
		$('footer').css({
			'position' : 'fixed',
			'width' : '100%',
			'bottom' : '0'
		});
	};
	
	/*
	 * Check marketHashName length
	 */
	$scope.marketHashNameLength = function(marketHashName) {
		if(marketHashName.length > 40) {
			return true;
		}
		
		return false;
	}
	
	/*
	 * Split marketHashName into two paragraphs
	 */
	$scope.splitMarketHashName = function(marketHashName, specialWeapon) {
		var marketHashNameArray = marketHashName.split('(');
		var lineHeightProperty = specialWeapon ? 18 : 20;
		
		return '<p class="csgostats-weapon-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">' + marketHashNameArray[0].substring(0, marketHashNameArray[0].length - 1) + '</p><p class="csgostats-weapon-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">(' + marketHashNameArray[1] + '</p>';
	}
	
	/*
	 * Show main user weapons stats loading
	 */
	$scope.showMainUserStatsWeaponsLoading = function() {
		$scope.hideMainUserStatsWeaponsLoading = false;
	};
	
	/*
	 * Show overall stats module
	 */
	$scope.showMainUserStatsGeneral = function() {
		$scope.hideMainUserStatsGeneralLoading = true;
		$scope.hideMainUserStatsGeneral = false;
	};
	
	/*
	 * Show weapons stats module
	 */
	$scope.showMainUserStatsWeapons = function() {
		$scope.hideMainUserStatsWeaponsLoading = true;
		$scope.hideMainUserStatsWeapons = false;
	};
	
	/*
	 * Show failed downloading user stats error
	 */
	$scope.showFailStatsDownloadingError = function() {
		$scope.hideMainUserStatsGeneralLoading = true;
		$scope.hideMainUserStatsWeaponsLoading = true;
		$scope.hideFailStatsDownloadingError = false;
	};
	
	/*
	 * Show failed downloading user inventory warning
	 */
	$scope.showFailUserInventoryDownloadingWarning = function() {
		$scope.hideFailUserInventoryDownloadingWarning = false;
	};
	
	/*
	 * Show failed downloading skins prices warning
	 */
	$scope.showFailSkinsPricesDownloadingWarning = function() {
		$scope.hideFailSkinsPricesDownloadingWarning = false;
	};
	
	/*
	 * Show failed downloading default weapons error
	 */
	$scope.showFailDefaultWeaponsDownloadingError = function() {
		$scope.hideMainUserStatsWeaponsLoading = true;
		$scope.hideFailDefaultWeaponsDownloadingError = false;
	};
	
	/*
	 * Show footer
	 */
	$scope.showFooter = function() {
		$scope.hideFooter = false;
	};
	
	/*
	 * Load friend list with details
	 */
	$scope.loadFriendList = function() {	
		$http.post($scope.url + '/stats/friendList', $scope.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendList = response.data;
			} else {
				console.log("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			console.log("Server encountered some error while downloading data. Please try again later.");
		});
	};
							
	/*
	 * Match skins to weapons stats
	 */
	$scope.matchSkinsToWeaponsStats = function(statsArray, skinsArray) {
		var defaultWeaponsArray = $scope.defaultWeapons.items;
		
		for(var i=0; i<statsArray.length; i++) {
			var skinObject = null;
			var filterHashName = null;
			
			for(var j=0; j<skinsArray.length; j++) {
				if(skinsArray[j].type == statsArray[i].name) {
					if(skinObject == null) {
						skinsArray[j].color = $scope.convertHexToRgb('#' + skinsArray[j].color);
						skinObject = skinsArray[j];
						filterHashName = skinsArray[j].marketHashName;
					} else {
						if(skinsArray[j].price > skinObject.price) {
							skinsArray[j].color = $scope.convertHexToRgb('#' + skinsArray[j].color);
							skinObject = skinsArray[j];
							filterHashName = skinsArray[j].marketHashName;
						}
					}
				}
			}
			
			if(skinObject == null) {
				for(var j=0; j<defaultWeaponsArray.length; j++) {
					if(defaultWeaponsArray[j].type == statsArray[i].name) {
						defaultWeaponsArray[j].color = $scope.convertHexToRgb('#' + defaultWeaponsArray[j].color);
						skinObject = defaultWeaponsArray[j];
						filterHashName = defaultWeaponsArray[j].marketHashName;
						break;
					}
				}
			}
			
			statsArray[i].weaponSkin = skinObject;
			statsArray[i]['filterHashName'] = filterHashName;
		}
		
		// statsArray.sort((a, b) => parseInt(b.totalKills) - parseInt(a.totalKills));
		
		return statsArray;
	}
	
	/*
	 * Match skins prices to skins
	 */
	$scope.matchPricesToSkins = function(inventorySkinsArray) {
		var skinsPricesList = $scope.skinsPrices.items_list;
		
		for(var i=0; i<inventorySkinsArray.length; i++) {
			for(var item in skinsPricesList) {
				if(skinsPricesList.hasOwnProperty(item)) {
					if(item == inventorySkinsArray[i].marketHashName) {
						var priceFound = false;
						
						if(skinsPricesList[item].price.hasOwnProperty('24_hours')) {
							if(skinsPricesList[item].price['24_hours'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['24_hours'].median;
								priceFound = true;
							}														
						} 
						
						if(skinsPricesList[item].price.hasOwnProperty('7_days') && priceFound == false) {
							if(skinsPricesList[item].price['7_days'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['7_days'].median;
								priceFound = true;
							}																					
						} 
						
						if(skinsPricesList[item].price.hasOwnProperty('opskins_average') && priceFound == false) {
							if(skinsPricesList[item].price.opskins_average != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price.opskins_average;
								priceFound = true;
							}							
						}
						
						if(skinsPricesList[item].price.hasOwnProperty('30_days') && priceFound == false) {
							if(skinsPricesList[item].price['30_days'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['30_days'].median;
								priceFound = true;
							}																					
						}
						
						if(skinsPricesList[item].price.hasOwnProperty('all_time') && priceFound == false) {
							if(skinsPricesList[item].price['all_time'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['all_time'].median;
								priceFound = true;
							}																					
						}
												
						if(!priceFound) {
							inventorySkinsArray[i].price = 0;
						}
						
						break;
					}
				}
			}
		}
						
		return inventorySkinsArray;
	}
	
	/*
	 * Convert hex color notation to RGB standard
	 */
	$scope.convertHexToRgb = function(hexColor) {
	    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexColor);
	    
	    return result ? parseInt(result[1], 16) + ', ' + parseInt(result[2], 16) + ', ' + parseInt(result[3], 16) : null;
	}
		
	/*
	 * Convert item rarity to integer
	 */
	$scope.convertRarityToInt = function(rarity) {
		var rarityInt = null;
		
		if (rarity == "Consumer Grade") {
			rarityInt = 1;
		} else if (rarity == "Industrial Grade") {
			rarityInt = 2;
		} else if (rarity == "Mil-Spec Grade") {
			rarityInt = 3;
		} else if (rarity == "Restricted") {
			rarityInt = 4;
		} else if (rarity == "Classified") {
			rarityInt = 5;
		} else if (rarity == "Covert" || rarity == 'Extraordinary') {
			rarityInt = 6;
		} else if (rarity == "Contraband") {
			rarityInt = 7;
		} else {
			rarityInt = 0;
		}
		
		return rarityInt;
	}
	
	/*
	 * Get skins list from inventory
	 */
	$scope.getSkinsFromInventory = function(steamId) {
		var inventorySkinsSet = new Set();
		var rgDescriptions = $scope.mainUserInventory.rgDescriptions;
		var rgInventory = $scope.mainUserInventory.rgInventory;
		
		for(var item in rgDescriptions) {
			if(rgDescriptions.hasOwnProperty(item)) {
				if(rgDescriptions[item].marketable == 1) {
					var tagsArray = rgDescriptions[item].tags;
					
					if(tagsArray.length > 3) {
						if(tagsArray[0].name == 'Knife' || tagsArray[0].name == 'Gloves' || tagsArray[1].category == 'Weapon') {
							var weaponItem = {};
							var statTrakWeapon = false;
							var souvenirWeapon = false;
							
							weaponItem['classid'] = rgDescriptions[item].classid;
							
							if(rgDescriptions[item].hasOwnProperty('icon_url')){
								weaponItem['iconUrl'] = $scope.imageUrl + rgDescriptions[item].icon_url;
							}
							
							if(rgDescriptions[item].hasOwnProperty('icon_url_large')){
								weaponItem['iconUrlLarge'] = $scope.imageUrl + rgDescriptions[item].icon_url_large;
							}
														
							weaponItem['name'] = rgDescriptions[item].name;
							
							if(rgDescriptions[item].hasOwnProperty('fraudwarnings')){
								weaponItem['fraudwarnings'] = rgDescriptions[item].fraudwarnings;
							}
							
							weaponItem['marketHashName'] = rgDescriptions[item].market_hash_name;
							
							if(rgDescriptions[item].market_hash_name.includes('StatTrak')) {
								statTrakWeapon = true;
							}
							
							weaponItem['statTrak'] = statTrakWeapon;
							
							if(rgDescriptions[item].market_hash_name.includes('Souvenir')) {
								souvenirWeapon = true;
							}
							
							weaponItem['souvenir'] = souvenirWeapon;
														
							if(tagsArray[0].name == 'Knife' || tagsArray[0].name == 'Gloves') {
								weaponItem['type'] = tagsArray[0].name;
								weaponItem['collection'] = '';
							} else {
								weaponItem['type'] = tagsArray[1].name;
								weaponItem['collection'] = tagsArray[2].name;
							}
																					
							for(var i=0; i<tagsArray.length; i++) {
								if(tagsArray[i].hasOwnProperty('category')) {
									if(tagsArray[i].category == 'Rarity') {
										weaponItem['rarity'] = $scope.convertRarityToInt(tagsArray[i].name);
									}
								}
							}
							
							if(rgDescriptions[item].hasOwnProperty('actions')){
								weaponItem['inspectInGame'] = rgDescriptions[item].actions[0].link;
							}
							
							var descriptionsArray = rgDescriptions[item].descriptions;
							
							if(descriptionsArray.length >= 3) {
								weaponItem['exterior'] = descriptionsArray[0].value.replace('Exterior: ', '');
							}
							
							if(tagsArray[0].name == 'Knife') {
								if(tagsArray[3].hasOwnProperty('color')){
									weaponItem['color'] = tagsArray[3].color;
								}
							} else if(tagsArray[0].name == 'Gloves') {
								if(tagsArray[2].hasOwnProperty('color')){
									weaponItem['color'] = tagsArray[2].color;
								}
							} else if(tagsArray[1].category == 'Weapon') {
								if(tagsArray[4].hasOwnProperty('color')){
									weaponItem['color'] = tagsArray[4].color;
								}
							}
							
							weaponItem['price'] = null;
							
							inventorySkinsSet.add(weaponItem);
						}
					}
				}
			}
		}
				
		inventorySkinsSet.forEach(function(weaponItem) {
			for(var item in rgInventory) {
				if(rgInventory.hasOwnProperty(item)) {
					if(rgInventory[item].classid == weaponItem.classid) {
						weaponItem.inspectInGame = weaponItem.inspectInGame.replace('%owner_steamid%', steamId).replace('%assetid%', rgInventory[item].id);
						break;
					}
				}
			}
		});
		
		var inventorySkinsArray = Array.from(inventorySkinsSet).sort((a, b) => (a.marketHashName > b.marketHashName) - (a.marketHashName < b.marketHashName));
		
		return inventorySkinsArray;
	};
	
	/*
	 * Create weapons stats
	 */
	$scope.createWeaponsStats = function(statsArray) {
		var weaponsStatsList = [];
		var weaponsNames = ['AK-47', 'M4A1-S', 'M4A4', 'AWP', 'SSG 08', 'SG 553', 'AUG', 'Galil AR', 'FAMAS', 'Glock-18', 'P2000', 'USP-S', 'Five-SeveN', 'Tec-9', 'CZ75-Auto', 'Desert Eagle', 'R8 Revolver', 'P250', 'Dual Berettas', 'P90', 'MP7', 'MAC-10', 'UMP-45', 'PP-Bizon', 'MP9', 'XM1014', 'G3SG1', 'M249', 'SCAR-20', 'Nova', 'Negev', 'Sawed-Off', 'MAG-7', 'Knife', 'Gloves', 'Zeus x27', 'High Explosive Grenade', 'Incendiary Grenade / Molotov'];
		var weaponsNamesId = ['ak47', 'm4a1', 'm4a1', 'awp', 'ssg08', 'sg556', 'aug', 'galilar', 'famas', 'glock', 'hkp2000', 'hkp2000', 'fiveseven', 'tec9', 'cz75auto', 'deagle', 'deagle', 'p250', 'elite', 'p90', 'mp7', 'mac10', 'ump45', 'bizon', 'mp9', 'xm1014', 'g3sg1', 'm249', 'scar20', 'nova', 'negev', 'sawedoff', 'mag7', 'knife', 'gloves', 'taser', 'hegrenade', 'molotov'];
		var weaponsCategories = ['Rifle', 'Rifle', 'Rifle', 'Sniper Rifle', 'Sniper Rifle', 'Rifle', 'Rifle', 'Rifle', 'Rifle', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'Pistol', 'SMG', 'SMG', 'SMG', 'SMG', 'SMG', 'SMG', 'Shotgun', 'Sniper Rifle', 'Machinegun', 'Sniper Rifle', 'Shotgun', 'Machinegun', 'Shotgun', 'Shotgun', 'Knife', 'Gloves', 'Taser', 'Grenade', 'Grenade'];
		var weaponsSide = [0, 1, 1, 2, 2, 0, 1, 0, 1, 0, 1, 1, 1, 0, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 1, 2, 0, 2, 1, 2, 2, 0, 1, 2, 2, 2, 2, 2];
		var weaponsNamesToCloneFrom = ['M4A1-S', 'P2000', 'Desert Eagle', 'Five-SeveN', 'Tec-9'];
		var weaponsNamesToUpdate = ['M4A4', 'USP-S', 'R8 Revolver', 'CZ75-Auto', 'CZ75-Auto'];	
		
		for(var i=0; i<weaponsNames.length; i++) {
			var weaponObject = {};
			
			weaponObject['name'] = weaponsNames[i];
			weaponObject['nameId'] = weaponsNamesId[i];
			weaponObject['category'] = weaponsCategories[i];
			weaponObject['side'] = weaponsSide[i];
			weaponObject['totalKills'] = 0;
			weaponObject['totalShots'] = 0;
			weaponObject['totalHits'] = 0;
			weaponObject['accuracy'] = 0;
			weaponObject['shotsPerKill'] = 0;
			weaponObject['weaponSkin'] = null;
			
			weaponsStatsList.push(weaponObject);
		}
		
		for(var i=0; i<statsArray.length; i++) {
			for(var j=0; j<weaponsStatsList.length; j++) {
				if(statsArray[i].name.endsWith(weaponsStatsList[j].nameId)) {
					if(statsArray[i].name.includes('total_kills')) {
						weaponsStatsList[j].totalKills = statsArray[i].value;
						break;
					} else if(statsArray[i].name.includes('total_shots')) {
						weaponsStatsList[j].totalShots = statsArray[i].value;
						break;
					} else if(statsArray[i].name.includes('total_hits')) {
						weaponsStatsList[j].totalHits = statsArray[i].value;
						break;
					}
				}			
			}			
		}
							
		for(var i=0; i<weaponsStatsList.length; i++) {
			for(var h=0; h<weaponsNamesToUpdate.length; h++) {
				if(weaponsStatsList[i].name == weaponsNamesToCloneFrom[h]) {
					for(var j=0; j<weaponsStatsList.length; j++) {
						if(weaponsStatsList[j].name == weaponsNamesToUpdate[h]) {
							weaponsStatsList[j].totalKills += weaponsStatsList[i].totalKills;
							weaponsStatsList[j].totalShots += weaponsStatsList[i].totalShots;
							weaponsStatsList[j].totalHits += weaponsStatsList[i].totalHits;
							break;
						}
					}
					
					break;
				}
			}
		}
		
		for(var i=0; i<weaponsStatsList.length; i++) {
			if(weaponsStatsList[i].name == 'Zeus x27') {
				weaponsStatsList[i].totalHits = weaponsStatsList[i].totalKills;
			}
			
			weaponsStatsList[i].accuracy = weaponsStatsList[i].totalShots == 0 ? 0 : (((weaponsStatsList[i].totalHits * 1.0) / (weaponsStatsList[i].totalShots * 1.0)) * 100.0).toFixed(2);
			weaponsStatsList[i].shotsPerKill = weaponsStatsList[i].totalHits == 0 ? 0 : ((weaponsStatsList[i].totalHits * 1.0) / (weaponsStatsList[i].totalKills * 1.0)).toFixed(2);
		}
				
		return weaponsStatsList;
	};
	
	/*
	 * Checking if entered profile is valid
	 */
	$scope.validateEnteredProfile = function(steamProfileData) {
		var checkVanity = true;
		var checkDigits = false;
		var profileValue = null;
		
		steamProfileData = steamProfileData.trim();
		
		if(steamProfileData.includes('id/')) {
			profileValue = steamProfileData.split('id/')[1];
			
			if(profileValue.includes('/')) {
				profileValue = profileValue.split('/')[0];
			}			
		} else if(steamProfileData.includes('profiles/')) {
			profileValue = steamProfileData.split('profiles/')[1];
			
			if(profileValue.includes('/')) {
				profileValue = profileValue.split('/')[0];
			}
			
			checkVanity = false;
		} else if(!steamProfileData.match(/^-{0,1}\d+$/)) {
			profileValue = steamProfileData;
		} else {
			profileValue = steamProfileData;
			checkDigits = true;
		}
		
		return '{ "steamId": "' + profileValue + '", "checkVanityUrl": ' + checkVanity + ', "checkDigits": ' + checkDigits + ' }';
	};
	
	/*
	 * Load stranger stats for comparison
	 */
	$scope.loadStrangerStatsToCompare = function(strangerProfileData) {
		var steamId = $scope.validateEnteredProfile(strangerProfileData);

		$http.post($scope.url + '/stats/strangerUserStats', steamId)
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendUserStats = response.data;
				return $http.post($scope.url + '/stats/userInventory', $scope.friendUserStats.userInfo.steamId);
			} else {
				throw "failed downloading stranger user stats.";
			}
		})
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendUserInventory = response.data;
				var weaponsStats = $scope.createWeaponsStats($scope.friendUserStats.userStats.playerstats.stats);										
				var skinsFromInventory = $scope.getSkinsFromInventory($scope.friendUserStats.userInfo.steamId);				
				var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory);
				$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats(weaponsStats, skinsFromInventoryWithPrices);					
			} else {
				throw "failed downloading stranger user inventory.";
			}
		})
		.catch(function(error) {
			console.log('error: ' + error);
		});						
	};
	
	/*
	 * Load friend stats for comparison
	 */
	$scope.loadFriendStatsToCompare = function(steamId) {
		$http.post($scope.url + '/stats/userStats', steamId)
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendUserStats = response.data;
					return $http.post($scope.url + '/stats/userInventory', steamId);
				} else {
					throw "failed downloading friend user stats.";
				}
			})
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendUserInventory = response.data;
					var weaponsStats = $scope.createWeaponsStats($scope.friendUserStats.userStats.playerstats.stats);										
					var skinsFromInventory = $scope.getSkinsFromInventory(steamId);					
					var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory);
					$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats(weaponsStats, skinsFromInventoryWithPrices);					
				} else {
					throw "failed downloading friend user inventory.";
				}
			})
			.catch(function(error) {
				console.log('error: ' + error);
			});
	};
	
	/*
	 * Load content after logging in
	 */	
	$scope.$watch('$viewContentLoaded', function(){		
		$http.post($scope.url + '/stats/strangerUserStats', '{ "steamId": "' + $scope.steamId + '", "checkVanityUrl": false, "checkDigits": false }')
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.mainUserStats = response.data;
					$scope.showMainUserStatsGeneral();
					$scope.showMainUserStatsWeaponsLoading();
					return $http.post($scope.url + '/stats/userInventory', $scope.steamId);
				} else {
					$scope.showFailStatsDownloadingError();
					$scope.addFooterCssProperties();
					$scope.showFooter();
					throw "failed downloading user stats.";
				}
			})
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.mainUserInventory = response.data;					
				} else {
					$scope.showFailUserInventoryDownloadingWarning();
					console.log('error: failed downloading user inventory.');
				}
				
				return $http.get($scope.url + '/stats/skinsPrices');
			})
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.skinsPrices = response.data;					
				} else {
					$scope.showFailSkinsPricesDownloadingWarning();
					console.log('failed downloading skins prices.');
				}
				
				return $http.get($scope.url + '/stats/defaultWeapons');
			})
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.defaultWeapons = response.data;
					var weaponsStats = $scope.createWeaponsStats($scope.mainUserStats.userStats.playerstats.stats);		
					
					if($scope.mainUserInventory != null) {
						var skinsFromInventory = $scope.getSkinsFromInventory($scope.steamId);					
						var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory);
						$scope.mainUserWeaponsStats = $scope.matchSkinsToWeaponsStats(weaponsStats, skinsFromInventoryWithPrices);
					} else {
						var skinsFromInventoryWithPrices = [];
						$scope.mainUserWeaponsStats = $scope.matchSkinsToWeaponsStats(weaponsStats, skinsFromInventoryWithPrices);
					}
					
					$scope.showMainUserStatsWeapons();
					$scope.showFooter();
				} else {
					$scope.showFailDefaultWeaponsDownloadingError();
					$scope.addFooterCssProperties();
					$scope.showFooter();
					throw "Failed downloading default weapons.";
				}
			})
			.catch(function(error) {
				console.log('error: ' + error);
			});				
	});
	
}]);

indexController.config( [
    '$compileProvider',
    function($compileProvider) {   
        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|local|steam|data|ftp|mailto|chrome-extension):/);
    }
]);

indexController.filter('unsafe', function($sce) { 
	return $sce.trustAsHtml; 
});

