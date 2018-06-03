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
	/*$scope.steamId = '76561198078305233';*/
	/*$scope.steamId = '76561198023414915';*/
	$scope.url = "/SteamCentral/data";
	$scope.imageUrl = 'https://steamcommunity-a.akamaihd.net/economy/image/';
	
	$scope.friendList = null;
	$scope.friendListRequest = false;
	$scope.defaultWeapons = null;
	$scope.skinsPrices = null;
	
	$scope.mainUserStats = null;
	$scope.mainUserStatsOverall = null;
	$scope.mainUserStatsLastMatch = null;
	$scope.mainUserInventory = null;
	$scope.mainUserCollectibleItems = null;
	$scope.mainUserWeaponsStatsTemporary = null;
	$scope.mainUserWeaponsStats = null;
	 
	$scope.friendUserStats = null;
	$scope.friendUserStatsOverall = null;
	$scope.friendUserStatsLastMatch = null;
	$scope.friendUserInventory = null;
	$scope.friendUserCollectibleItems = null;
	$scope.friendUserWeaponsStatsTemporary = null;
	$scope.friendUserWeaponsStats = null;
	
	$scope.mainAndFriendUserWeaponsStats = null;
	
	$scope.hideMainUserStats = false;
	$scope.hideMainUserStatsPanel = false;
	$scope.hideMainUserStatsGeneralLoading = false;
	$scope.hideNavTabCompareOption = true;
	$scope.hideMainUserStatsGeneral = true;
	$scope.hideMainUserCollectibleItemsShowcase = true;
	$scope.hideMainUserStatsWeaponsLoading = true;
	$scope.hideMainUserStatsWeapons = true;
	$scope.cleanBlinkingMainUserStats = true;
	
	$scope.hideFriendUserStats = true;
	
	$scope.hideFriendUserStatsPanel = true;
	$scope.hideFriendUserStatsPanelFriendCombobox = true;
	$scope.hideFriendUserStatsPanelLoadingPoints = true;
	$scope.hideFriendUserStatsPanelFailButton = true;
	$scope.hideFriendUserStatsPanelLoading = true;
	
	$scope.hideFriendUserStatsGeneralLoading = true;
	$scope.hideFriendUserStatsGeneral = true;
	$scope.hideFriendUserStatsWeaponsLoading = true;
	$scope.hideFriendUserStatsWeapons = true;
	$scope.cleanBlinkingFriendUserStats = true;
	
	$scope.hideFailStatsDownloadingError = true;
	$scope.hideFailUserInventoryDownloadingWarning = true;
	$scope.hideFailSkinsPricesDownloadingWarning = true;
	$scope.hideFailDefaultWeaponsDownloadingError = true;
	
	$scope.hideFailFriendListDownloadingError = true;
	$scope.hideFailFriendStatsDownloadingError = true;
	$scope.hideFailFriendUserInventoryDownloadingWarning = true;
	
	$scope.hideFooter = true;
	$scope.hideFooterCompare = true;
	
	/*
	 * Watch mainUserWeaponsStats scope
	 */
	/*$scope.$watch("friendUserWeaponsStats", function(newValue, oldValue) {
		if(newValue != null) {
			console.log($scope.friendUserWeaponsStats);
		}
	});*/
	
	/*
	 * Remove friendStatsCompareButton disable state
	 */
	$scope.enableFriendStatsCompareButton = function(value) {
		if(value != null) {
			if($('#friendStatsCompareButton').attr('disabled')) {
				$('#friendStatsCompareButton').removeAttr('disabled');
			}
		}
	};
	
	/*
	 * Manipulates strangerStatsCompareButton disable state
	 */
	$scope.changeCompareButtonState = function(textFieldData) {
		if(textFieldData.length == 0) {
        	$('#strangerStatsCompareButton').attr('disabled', '');
        } else if($('#strangerStatsCompareButton').attr('disabled')) {
        	$('#strangerStatsCompareButton').removeAttr('disabled');
        }
	};
	
	/*
	 * Add footer CSS properties
	 */
	$scope.addFooterCssProperties = function() {
		$('body').css({
			'display' : 'flex',
			'min-height' : '100vh',
			'flex-direction' : 'column'
		});
		
		$('.main-user-stats').css({
			'flex' : '1'
		});
	};
	
	/*
	 * Obtain text width in pixels
	 */
	$scope.measureTextLengthInPixels = function(marketHashName, fontProperties, textWidth) {		
		var canvas = $scope.measureTextLengthInPixels.canvas || ($scope.measureTextLengthInPixels.canvas = document.createElement("canvas"));
	    var context = canvas.getContext("2d");
	    context.font = fontProperties;
	    var metrics = context.measureText(marketHashName);
	    
	    if(metrics.width > textWidth) {
			return true;
		}
		
		return false;
	};
	
	/*
	 * Split marketHashName into two paragraphs
	 */
	$scope.splitMarketHashName = function(marketHashName, specialWeapon) {
		var marketHashNameArray = marketHashName.split('(');
		var lineHeightProperty = specialWeapon ? 18 : 20;
		
		return '<p class="csgostats-weapon-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">' + marketHashNameArray[0].substring(0, marketHashNameArray[0].length - 1) + '</p><p class="csgostats-weapon-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">(' + marketHashNameArray[1] + '</p>';
	};
	
	/*
	 * Split marketHashName into two paragraphs showcase
	 */
	$scope.splitMarketHashNameShowcase = function(marketHashName) {
		var marketHashNameArray = marketHashName.split(' ');
				
		if(marketHashNameArray.length > 1) {
			var lineHeightProperty = 13;
			var iteration = null;
			var lengthDifference = Infinity;
			
			for(var i=0; i<marketHashNameArray.length; i++) {
				var firstPartLength = marketHashNameArray.slice(0, i + 1).join(' ').length;
				var secondPartLength = marketHashNameArray.slice(i + 1, marketHashNameArray.length).join(' ').length;
				var localLengthDifference = Math.abs(firstPartLength - secondPartLength);
				
				if(localLengthDifference < lengthDifference) {
					lengthDifference = localLengthDifference;
					iteration = i;
				}
			}
			
			return '<p class="csgostats-collectible-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">' + marketHashNameArray.slice(0, iteration + 1).join(' ') + '</p><p class="csgostats-collectible-name-formatter-center" style="line-height: ' + lineHeightProperty + 'px;">' + marketHashNameArray.slice(iteration + 1, marketHashNameArray.length).join(' ') + '</p>';
		} else {
			return '<p class="csgostats-collectible-name-formatter-center" style="line-height: ' + lineHeightProperty * 2 + 'px;">' + marketHashName + '</p>';
		}
	}
	
	/*
	 * Show friend user stats panel loading
	 */
	$scope.showFriendUserStatsPanelLoading = function() {
		if($scope.friendList == null) {
			$scope.hideFriendUserStatsPanelLoading = false;
		}
	};
	
	/*
	 * Show friend user stats module
	 */
	$scope.showFriendUserStats = function() {
		$scope.hideMainUserStats = true;
		$scope.hideFooter = true;		
		$scope.hideFooterCompare = false;
		$scope.hideFriendUserStats = false;
		
		if(!$scope.hideFailStatsDownloadingError) {
			$scope.removeAnimationByElementIdAndAnimationName('#failStatsDownloadingErrorAlert', 'fadeIn', true);
		}
		
		if(!$scope.hideFailUserInventoryDownloadingWarning) {
			$scope.removeAnimationByElementIdAndAnimationName('#failUserInventoryDownloadingWarningAlert', 'fadeIn', true);
		}

		if($scope.cleanBlinkingMainUserStats) {
			if(!$scope.hideMainUserStatsGeneral) {
				$scope.removeAnimationByElementIdAndAnimationName('#mainUserStatsPanelBlinking', 'fadeIn', true);
				$scope.removeAnimationByElementIdAndAnimationName('#mainUserStatsGeneralBlinking', 'fadeIn', true);
				$scope.removeAnimationByElementIdAndAnimationName('#mainUserStatsGeneralCollectibleItemsShowcaseBlinking', 'fadeIn', false);
			}
			
			if(!$scope.hideFailSkinsPricesDownloadingWarning) {
				$scope.removeAnimationByElementIdAndAnimationName('#failSkinsPricesDownloadingWarningAlert', 'fadeIn', true);
			}
			
			if(!$scope.hideFailDefaultWeaponsDownloadingError) {
				$scope.removeAnimationByElementIdAndAnimationName('#failDefaultWeaponsDownloadingErrorAlert', 'fadeIn', true);
			}
			
			$scope.cleanBlinkingMainUserStats = false;
		}
	};
	
	/*
	 * Show main user stats module
	 */
	$scope.showMainUserStats = function() {
		$scope.hideFriendUserStats = true;
		$scope.hideFooterCompare = true;
		$scope.hideFooter = false;		
		$scope.hideMainUserStats = false;
		
		if(!$scope.hideFriendUserStatsGeneral) {
			$scope.removeAnimationByElementIdAndAnimationName('#friendUserStatsGeneralBlinking', 'fadeIn', true);
		}
		
		if(!$scope.hideFailFriendUserInventoryDownloadingWarning) {
			$scope.removeAnimationByElementIdAndAnimationName('#failFriendUserInventoryDownloadingWarningAlert', 'fadeIn', true);
		}
		
		if(!$scope.hideFailFriendStatsDownloadingError) {
			$scope.removeAnimationByElementIdAndAnimationName('#failFriendStatsDownloadingErrorAlert', 'fadeIn', false);
		}
		
		if(!$scope.hideFailFriendListDownloadingError) {				
			$scope.removeAnimationByElementIdAndAnimationName('#failFriendListDownloadingErrorAlert', 'fadeIn', false);
		}
		
		if($scope.cleanBlinkingFriendUserStats) {
			if(!$scope.hideFriendUserStatsPanel) {
				$scope.removeAnimationByElementIdAndAnimationName('#friendUserStatsPanelBlinking', 'fadeIn', false);
			}
			
			if(!$scope.hideFriendUserStatsPanelFriendCombobox) {
				$scope.removeAnimationByElementIdAndAnimationName('#friendUserStatsPanelFriendComboboxBlinking', 'fadeIn', false);
			}
			
			$scope.cleanBlinkingFriendUserStats = false;
		}
	};
	
	/*
	 * Simply switches between two different animations of specified element
	 */
	$scope.changeAnimationOfElementById = function(elementId, animationToRemove, animationToAdd) {
		$(elementId).removeClass(animationToRemove).addClass(animationToAdd);
		$(elementId).css({ 'animation-name' : animationToAdd });
	}
	
	/*
	 * Append animation to friendUserStatsGeneralBlinking
	 */
	$scope.appendAnimationToFriendUserStatsGeneralBlinking = function() {
		$('#friendUserStatsGeneralBlinking').addClass('fadeIn').addClass('wow').addClass('animated').attr('data-wow-duration', '1.5s').attr('data-wow-delay', '1s');
		$('#friendUserStatsGeneralBlinking').css({ 'animation-duration' : '1.5s', 'animation-delay' : '1s', 'animation-name' : 'fadeIn' });
	};
	
	/*
	 * Simply removes animation given to specified element with optional deletion of animation duration
	 */
	$scope.removeAnimationByElementIdAndAnimationName = function(elementId, animationName, deleteDelay) {
		$(elementId).removeClass(animationName).removeClass('wow').removeClass('animated').removeAttr('data-wow-duration');
		$(elementId).css({ 'animation-duration' : '', 'animation-name' : '' });
		
		if(deleteDelay) {
			$(elementId).removeAttr('data-wow-delay');
			$(elementId).css({ 'animation-delay' : '' });
		}
	}
	
	/*
	 *  Simply removes animation delay given to specified element
	 */
	$scope.removeDelayOfAnimationByElementId = function(elementId) {
		$(elementId).removeAttr('data-wow-delay');
		$(elementId).css({ 'animation-delay' : '' });		
	};
	
	/*
	 * Replace failStatsDownloadingErrorAlert alert
	 */
	$scope.replaceFailStatsDownloadingErrorAlert = function() {
		$("#failStatsDownloadingErrorAlert").remove();
		var $textElement = $('<div data-ng-hide="hideFailStatsDownloadingError" id="failStatsDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert"><strong>Error:</strong> failed downloading user statistics. <a href="https://steamcommunity.com/profiles/{{ steamId }}/edit/settings" onclick="this.blur();" class="error-alert" target="_blank">Make sure that your Steam profile and inventory privacy settings are set to public</a> (it may take a while when privacy settings will be overridden) and then <a class="error-alert" data-ng-click="loadMainUserStats(true)" onclick="this.blur();">click here<i class="fas fa-sync-alt reload-icon-error-alert"></i></a> to try to download your statistics again.</div>').appendTo("#failStatsDownloadingErrorAlertOuter");
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace failUserInventoryDownloadingWarningAlert alert
	 */
	$scope.replaceFailUserInventoryDownloadingWarningAlert = function() {
		$("#failUserInventoryDownloadingWarningAlert").remove();
		var $textElement = $('<div data-ng-hide="hideFailUserInventoryDownloadingWarning" id="failUserInventoryDownloadingWarningAlert" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="0.5s" role="alert"><strong>Warning:</strong> failed downloading user inventory. <a href="https://steamcommunity.com/profiles/' + $scope.steamId + '/edit/settings" onclick="this.blur();" class="warning-alert" target="_blank">Make sure that your Steam inventory privacy settings are set to public</a> and then <a class="warning-alert" data-ng-click="reloadMainUserInventory()" onclick="this.blur();">click here<i class="fas fa-sync-alt reload-icon-warning-alert"></i></a> to try to reload your inventory.</div>').appendTo("#failUserInventoryDownloadingWarningAlertOuter");					
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace failFriendListDownloadingErrorAlert alert
	 */
	$scope.replaceFailFriendListDownloadingErrorAlert = function() {
		$("#failFriendListDownloadingErrorAlert").remove();	
		var $textElement = $("<div data-ng-hide='hideFailFriendListDownloadingError' id='failFriendListDownloadingErrorAlert' data-ng-cloak class='alert alert-custom alert-danger alert-dismissible fade in wow fadeIn' data-wow-duration='1s' role='alert'>" +
		"<strong>Error:</strong> failed downloading friend list. Try to download friend list again by clicking 'Reload friend list<i class='fas fa-sync-alt reload-icon-error-alert'></i>' button in 'Select Friend To Compare & Search Options' panel." +
		"<button type='button' class='close' data-dismiss='alert' aria-label='Close' onclick='this.blur();'><span aria-hidden='true'>&times;</span></button></div>").appendTo("#failFriendListDownloadingErrorAlertOuter");
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace failFriendStatsDownloadingErrorAlert alert for friend user
	 */
	$scope.replaceFailFriendStatsDownloadingErrorAlertFriend = function(friendSteamId) {
		$("#failFriendStatsDownloadingErrorAlert").remove();
		var $textElement = $("<div data-ng-hide='hideFailFriendStatsDownloadingError' id='failFriendStatsDownloadingErrorAlert' data-ng-cloak class='alert alert-custom alert-danger alert-dismissible fade in wow fadeIn' data-wow-duration='2s' role='alert'><strong>Error:</strong> failed downloading selected user statistics. <a href='https://steamcommunity.com/profiles/" + friendSteamId + "/' onclick='this.blur();' class='error-alert' target='_blank'>Try to chat to your friend and ask for setting Steam profile and inventory privacy to public</a> (it may take a while when privacy settings will be overridden) and then click 'Compare' button to download friend's statistics again.</div>").appendTo("#failFriendStatsDownloadingErrorAlertOuter");
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace failFriendStatsDownloadingErrorAlert alert for stranger user
	 */
	$scope.replaceFailFriendStatsDownloadingErrorAlertStranger = function() {
		$("#failFriendStatsDownloadingErrorAlert").remove();
		var $textElement = $("<div data-ng-hide='hideFailFriendStatsDownloadingError' id='failFriendStatsDownloadingErrorAlert' data-ng-cloak class='alert alert-custom alert-danger alert-dismissible fade in wow fadeIn' data-wow-duration='2s' role='alert'><strong>Error:</strong> failed downloading selected user statistics. It is highly likely that this user not exists or has privacy settings set to other than public. If you think this is a mistake try to download user's statistics again by clicking 'Compare' button.</div>").appendTo("#failFriendStatsDownloadingErrorAlertOuter");
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace failFriendUserInventoryDownloadingWarningAlert alert for friend user
	 */
	$scope.replaceFailFriendUserInventoryDownloadingWarningAlertFriend = function(friendSteamId) {
		$("#failFriendUserInventoryDownloadingWarningAlert").remove();
		var $textElement = $("<div data-ng-hide='hideFailFriendUserInventoryDownloadingWarning' id='failFriendUserInventoryDownloadingWarningAlert' data-ng-cloak class='alert alert-custom alert-warning alert-dismissible fade in wow fadeIn' data-wow-duration='2s' data-wow-delay='0.5s' role='alert'><strong>Warning:</strong> failed downloading selected user inventory. <a href='https://steamcommunity.com/profiles/" + friendSteamId + "/' onclick='this.blur();' class='warning-alert' target='_blank'>Try to chat to your friend and ask for setting Steam inventory privacy to public</a> and then <a class='warning-alert' data-ng-click='reloadFriendUserInventory(true)' onclick='this.blur();'>click here<i class='fas fa-sync-alt reload-icon-warning-alert'></i></a> to try to reload friend's inventory.</div>").appendTo("#failFriendUserInventoryDownloadingWarningAlertOuter");
		$compile($textElement)($scope);
	}
	
	/*
	 * Replace failFriendUserInventoryDownloadingWarningAlert alert for stranger user
	 */
	$scope.replaceFailFriendUserInventoryDownloadingWarningAlertStranger = function() {
		$("#failFriendUserInventoryDownloadingWarningAlert").remove();
		var $textElement = $("<div data-ng-hide='hideFailFriendUserInventoryDownloadingWarning' id='failFriendUserInventoryDownloadingWarningAlert' data-ng-cloak class='alert alert-custom alert-warning alert-dismissible fade in wow fadeIn' data-wow-duration='2s' data-wow-delay='0.5s' role='alert'><strong>Warning:</strong> failed downloading selected user inventory. It is highly likely that this user has inventory privacy settings set to other than public. If you are convinced that everything is fine <a class='warning-alert' data-ng-click='reloadFriendUserInventory(false)' onclick='this.blur();'>click here<i class='fas fa-sync-alt reload-icon-warning-alert'></i></a> to try to reload user's inventory.</div>").appendTo("#failFriendUserInventoryDownloadingWarningAlertOuter");
		$compile($textElement)($scope);
	}
	
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
		$scope.replaceFailStatsDownloadingErrorAlert();
		$scope.hideFailStatsDownloadingError = false;
	};
	
	/*
	 * Show failed downloading friend user stats error
	 */
	$scope.showFailFriendStatsDownloadingError = function() {
		$scope.hideFriendUserStatsGeneralLoading = true;
		$scope.hideFriendUserStatsWeaponsLoading = true;
		$scope.hideFailFriendStatsDownloadingError = false;	
	};
	
	/*
	 * Show failed downloading default weapons error
	 */
	$scope.showFailDefaultWeaponsDownloadingError = function() {
		$scope.hideMainUserStatsWeaponsLoading = true;
		$scope.hideFailDefaultWeaponsDownloadingError = false;		
	};
	
	/*
	 * Reload friend list with details
	 */
	$scope.reloadFriendList = function() {
		$scope.friendListRequest = false;

		if($scope.friendList == null && !$scope.friendListRequest) {
			$scope.friendListRequest = true;
			$scope.hideFriendUserStatsPanelFailButton = true;
			$scope.hideFailFriendListDownloadingError = true;
			$scope.hideFriendUserStatsPanelLoadingPoints = false;
			
			$http.post($scope.url + '/stats/friendList', $scope.steamId).then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendList = response.data;
					$scope.hideFriendUserStatsPanelLoadingPoints = true;
					$scope.hideFriendUserStatsPanelFriendCombobox = false;
				} else {
					$scope.hideFriendUserStatsPanelLoadingPoints = true;
					$scope.hideFriendUserStatsPanelFailButton = false;
					$scope.replaceFailFriendListDownloadingErrorAlert();
					$scope.hideFailFriendListDownloadingError = false;
					console.log('error: failed downloading friend list.');
				}
			}).catch(function(response) {
				$scope.hideFriendUserStatsPanelLoadingPoints = true;
				$scope.hideFriendUserStatsPanelFailButton = false;
				$scope.replaceFailFriendListDownloadingErrorAlert();
				$scope.hideFailFriendListDownloadingError = false;
				console.log('error: failed downloading friend list.');
			});
		}
	};
	
	/*
	 * Load friend list with details
	 */
	$scope.loadFriendList = function() {		
		if($scope.friendList == null && !$scope.friendListRequest) {
			$scope.friendListRequest = true;
			$scope.showFriendUserStatsPanelLoading();
			
			$http.post($scope.url + '/stats/friendList', $scope.steamId).then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendList = response.data;	
					$scope.hideFriendUserStatsPanelFriendCombobox = false;
					$scope.hideFriendUserStatsPanelLoading = true;
					$scope.hideFriendUserStatsPanel = false;
				} else {
					$scope.hideFriendUserStatsPanelLoading = true;
					$scope.hideFriendUserStatsPanelFailButton = false;
					$scope.hideFriendUserStatsPanel = false;
					$scope.replaceFailFriendListDownloadingErrorAlert();
					$scope.hideFailFriendListDownloadingError = false;
					console.log('error: failed downloading friend list.');
				}
			}).catch(function(response) {
				$scope.hideFriendUserStatsPanelLoading = true;
				$scope.hideFriendUserStatsPanelFailButton = false;
				$scope.hideFriendUserStatsPanel = false;
				$scope.replaceFailFriendListDownloadingErrorAlert();
				$scope.hideFailFriendListDownloadingError = false;
				console.log('error: failed downloading friend list.');
			});
		}
	};
	
	/*
	 * Create overall & last match stats array
	 */
	$scope.createLastMatchStats = function(statsResponse) {
		var statsArray = statsResponse.userStats.playerstats.stats;		
		
		var overallStats = [
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/total_playtime.png',
				statsName: '',
				name: 'Total playtime:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/playtime_2weeks.png',
				statsName: '',
				name: 'Last two weeks playtime:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/kill.png',
				statsName: 'total_kills',
				name: 'Total kills:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/death.png',
				statsName: 'total_deaths',
				name: 'Total deaths:',
				value: null,
				comparable: false,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/kdr.png',
				statsName: '',
				name: 'Kill Death Ratio:',
				value: null,
				comparable: true,
				reverse: false
			},						
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/shots_hit.png',
				statsName: 'total_shots_hit',
				name: 'Total shots hit:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/shots_fired.png',
				statsName: 'total_shots_fired',
				name: 'Total shots fired:',
				value: null,
				comparable: false,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/accuracy.png',
				statsName: '',
				name: 'Accuracy:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/spk.png',
				statsName: '',
				name: 'Shots per kill:',
				value: null,
				comparable: true,
				reverse: true
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/damage.png',
				statsName: 'total_damage_done',
				name: 'Total damage done:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/adr.png',
				statsName: 'total_rounds_played',
				name: 'Average Damage per Round:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/bombs_planted.png',
				statsName: 'total_planted_bombs',
				name: 'Total bombs planted:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/bombs_defused.png',
				statsName: 'total_defused_bombs',
				name: 'Total bombs defused:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/mvp.png',
				statsName: 'total_mvps',
				name: 'Total MVPs:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/revenge.png',
				statsName: 'total_revenges',
				name: 'Total revenges:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/zoomed_sniper.png',
				statsName: 'total_kills_against_zoomed_sniper',
				name: 'Kills against zoomed sniper:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/knife_fights.png',
				statsName: 'total_kills_knife_fight',
				name: 'Knife fights won:',
				value: null,
				comparable: true,
				reverse: false
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/money.png',
				statsName: 'total_money_earned',
				name: 'Total money earned:',
				value: null,
				comparable: true,
				reverse: false
			},
		];
		
		var lastMatchStats = [
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/ct_wins.png',
				statsName: 'last_match_ct_wins',
				name: 'CT rounds win:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/tt_wins.png',
				statsName: 'last_match_t_wins',
				name: 'TT rounds win:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/round_wins.png',
				statsName: 'last_match_wins',
				name: 'Match result:',
				value: null,
				color: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/max_players.png',
				statsName: 'last_match_max_players',
				name: 'Match max players:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/kill.png',
				statsName: 'last_match_kills',
				name: 'Kills:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/death.png',
				statsName: 'last_match_deaths',
				name: 'Deaths:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/kdr.png',
				statsName: '',
				name: 'Kill Death Ratio:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/damage.png',
				statsName: 'last_match_damage',
				name: 'Total damage given:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/adr.png',
				statsName: 'last_match_rounds',
				name: 'Average Damage per Round:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/mvp.png',
				statsName: 'last_match_mvps',
				name: 'MVPs:',
				value: null
			},
			{
				iconVariable: '/SteamCentral/resources/media/stats-img/score.png',
				statsName: 'last_match_contribution_score',
				name: 'Score point result:',
				value: null
			}
		];
		
		var totalKills = null;
		var totalDeaths = null;
		var totalShotsHit = null;
		var totalShotsFired = null;
		var totalDamage = null;
		var totalRounds = null;
		
		var lastMatchKills = null;
		var lastMatchDeaths = null;
		var lastMatchCTWins = null;
		var lastMatchTWins = null;	
		var lastMatchDamage = null;
		var lastMatchRounds = null;
		
		for(var i=0; i<statsArray.length; i++) {	
			for(var j=0; j<overallStats.length; j++) {
				if(overallStats[j].statsName == '') {
					continue;
				} else {
					if(statsArray[i].name == overallStats[j].statsName) {
						overallStats[j].value = statsArray[i].value;
						
						if(statsArray[i].name == 'total_kills') {
							totalKills = statsArray[i].value;
						} else if(statsArray[i].name == 'total_deaths') {
							totalDeaths = statsArray[i].value;
						} else if(statsArray[i].name == 'total_shots_hit') {
							totalShotsHit = statsArray[i].value;
						} else if(statsArray[i].name == 'total_shots_fired') {
							totalShotsFired = statsArray[i].value;
						} else if(statsArray[i].name == 'total_damage_done') {
							totalDamage = statsArray[i].value;
						} else if(statsArray[i].name == 'total_rounds_played') {
							totalRounds = statsArray[i].value;
						}
						
						break;
					}
				}
			}
						
			for(var j=0; j<lastMatchStats.length; j++) {
				if(lastMatchStats[j].statsName == '') {
					continue;
				} else {
					if(statsArray[i].name == lastMatchStats[j].statsName) {
						lastMatchStats[j].value = statsArray[i].value;
						
						if(statsArray[i].name == 'last_match_kills') {
							lastMatchKills = statsArray[i].value;
						} else if(statsArray[i].name == 'last_match_deaths') {
							lastMatchDeaths = statsArray[i].value;
						} else if(statsArray[i].name == 'last_match_ct_wins') {
							lastMatchCTWins = statsArray[i].value;
						} else if(statsArray[i].name == 'last_match_t_wins') {
							lastMatchTWins = statsArray[i].value;
						} else if(statsArray[i].name == 'last_match_damage') {
							lastMatchDamage = statsArray[i].value;
						} else if(statsArray[i].name == 'last_match_rounds') {
							lastMatchRounds = statsArray[i].value;
						}
						
						break;
					}										
				}								
			}
		}
		
		for(var i=0; i<overallStats.length; i++) {
			if(overallStats[i].name == 'Kill Death Ratio:') {
				overallStats[i].value = totalKills == 0 ? 0 : (totalKills / (totalDeaths == 0 ? 1 : totalDeaths)).toFixed(2);
			} else if(overallStats[i].name == 'Accuracy:') {
				overallStats[i].value = totalShotsFired == 0 ? 0 : ((totalShotsHit / totalShotsFired) * 100.0).toFixed(2) + '%';
			} else if(overallStats[i].name == 'Shots per kill:') {
				overallStats[i].value = totalKills == 0 ? 0 : (totalShotsHit / totalKills).toFixed(2);
			} else if(overallStats[i].name == 'Total playtime:') {
				overallStats[i].value = (statsResponse.userInfo.playtimeForever / 60).toFixed(1) + 'h';
			} else if(overallStats[i].name == 'Last two weeks playtime:') {
				overallStats[i].value = (statsResponse.userInfo.playtimeTwoWeeks / 60).toFixed(1) + 'h';
			} else if(overallStats[i].name == 'Average Damage per Round:') {
				overallStats[i].value = totalRounds == 0 ? 0 : (totalDamage / totalRounds).toFixed(2);
			}
		}
		
		for(var i=0; i<lastMatchStats.length; i++) {
			if(lastMatchStats[i].name == 'Kill Death Ratio:') {
				lastMatchStats[i].value = lastMatchKills == 0 ? 0 : (lastMatchKills / (lastMatchDeaths == 0 ? 1 : lastMatchDeaths)).toFixed(2);
			} else if(lastMatchStats[i].name == 'Average Damage per Round:') {
				lastMatchStats[i].value = lastMatchRounds == 0 ? 0 : (lastMatchDamage / lastMatchRounds).toFixed(2);
			} else if(lastMatchStats[i].statsName == 'last_match_wins') {
				if(lastMatchCTWins == lastMatchTWins) {
					lastMatchStats[i].value = 'TIE';
					lastMatchStats[i].color = '#8686d5'
				} else {
					var matchWin = true;
					
					if(lastMatchCTWins > lastMatchStats[i].value) {
						matchWin = false;
					} else if(lastMatchTWins > lastMatchStats[i].value) {
						matchWin = false;
					}
					
					if(matchWin) {
						lastMatchStats[i].value = 'WIN';
						lastMatchStats[i].color = '#a1dc03'
					} else {
						lastMatchStats[i].value = 'LOSS';
						lastMatchStats[i].color = '#fd3535'
					}
				}
			}
		}
		
		return [overallStats, lastMatchStats];
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
						
						if(skinsPricesList[item].price.hasOwnProperty('7_days') && !priceFound) {
							if(skinsPricesList[item].price['7_days'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['7_days'].median;
								priceFound = true;
							}																					
						} 
						
						if(skinsPricesList[item].price.hasOwnProperty('opskins_average') && !priceFound) {
							if(skinsPricesList[item].price.opskins_average != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price.opskins_average;
								priceFound = true;
							}							
						}
						
						if(skinsPricesList[item].price.hasOwnProperty('30_days') && !priceFound) {
							if(skinsPricesList[item].price['30_days'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['30_days'].median;
								priceFound = true;
							}																					
						}
						
						if(skinsPricesList[item].price.hasOwnProperty('all_time') && !priceFound) {
							if(skinsPricesList[item].price['all_time'].median != 0) {
								inventorySkinsArray[i].price = skinsPricesList[item].price['all_time'].median;
							}																				
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
		} else if (rarity == "Mil-Spec Grade" || rarity == 'High Grade') {
			rarityInt = 3;
		} else if (rarity == "Restricted" || rarity == 'Remarkable') {
			rarityInt = 4;
		} else if (rarity == "Classified" || rarity == 'Exotic') {
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
	$scope.getSkinsFromInventory = function(steamId, userInventory) {
		var inventorySkinsSet = new Set();
		var collectibleItemsSet = new Set();
		var rgDescriptions = userInventory.rgDescriptions;
		var rgInventory = userInventory.rgInventory;
		
		for(var item in rgDescriptions) {
			if(rgDescriptions.hasOwnProperty(item)) {
				var tagsArray = rgDescriptions[item].tags;				
							
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
								weaponItem['color'] = tagsArray[i].color;
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
					
					weaponItem['price'] = 0;
					
					inventorySkinsSet.add(weaponItem);
				} else if(tagsArray[0].name == 'Collectible') {
					var collectibleItem = {};
					var descriptionsArray = rgDescriptions[item].descriptions;
					
					collectibleItem['classid'] = rgDescriptions[item].classid;
					
					if(rgDescriptions[item].hasOwnProperty('icon_url')){
						collectibleItem['iconUrl'] = $scope.imageUrl + rgDescriptions[item].icon_url;
					}
					
					if(rgDescriptions[item].hasOwnProperty('icon_url_large')){
						collectibleItem['iconUrlLarge'] = $scope.imageUrl + rgDescriptions[item].icon_url_large;
					} else {
						collectibleItem['iconUrlLarge'] = $scope.imageUrl + rgDescriptions[item].icon_url;
					}
												
					collectibleItem['name'] = rgDescriptions[item].name;
					collectibleItem['marketHashName'] = rgDescriptions[item].market_hash_name;
					collectibleItem['nameColor'] = $scope.convertHexToRgb('#' + rgDescriptions[item].name_color);
					collectibleItem['description'] = descriptionsArray[0].value;
					
					for(var i=0; i<descriptionsArray.length; i++) {
						if(descriptionsArray[i].hasOwnProperty('value')) {
							if(descriptionsArray[i].value.toLowerCase().includes('date')) {
								collectibleItem['date'] = descriptionsArray[i].value.split(': ')[1];
							}
						}
					}
					
					if(rgDescriptions[item].hasOwnProperty('actions')){
						collectibleItem['inspectInGame'] = rgDescriptions[item].actions[0].link;
					}
					
					collectibleItem['type'] = tagsArray[0].name;
										
					for(var i=0; i<tagsArray.length; i++) {
						if(tagsArray[i].hasOwnProperty('category')) {
							if(tagsArray[i].category == 'Rarity') {
								collectibleItem['rarity'] = $scope.convertRarityToInt(tagsArray[i].name);
								collectibleItem['color'] = $scope.convertHexToRgb('#' + tagsArray[i].color);
							}
						}
					}
					
					collectibleItemsSet.add(collectibleItem);
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
		
		collectibleItemsSet.forEach(function(collectibleItem) {
			for(var item in rgInventory) {
				if(rgInventory.hasOwnProperty(item)) {
					if(rgInventory[item].classid == collectibleItem.classid) {
						collectibleItem.inspectInGame = collectibleItem.inspectInGame.replace('%owner_steamid%', steamId).replace('%assetid%', rgInventory[item].id);
						break;
					}
				}
			}
		});
		
		var inventorySkinsArray = Array.from(inventorySkinsSet).sort((a, b) => (a.marketHashName > b.marketHashName) - (a.marketHashName < b.marketHashName));
		var collectibleItemsArray = Array.from(collectibleItemsSet).sort(function (a, b) {
		    return b.rarity - a.rarity || a.marketHashName.localeCompare(b.marketHashName);
		});
		
		return [inventorySkinsArray, collectibleItemsArray];
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
			weaponsStatsList[i].shotsPerKill = weaponsStatsList[i].totalKills == 0 ? 0 : ((weaponsStatsList[i].totalHits * 1.0) / (weaponsStatsList[i].totalKills * 1.0)).toFixed(2);
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
	 * Concat two arrays in alternate order
	 */
	$scope.concatWeaponsSkinsArrays = function(mainUserWeaponsStatsArray, friendUserWeaponsStatsArray) {
		var mergedWeaponsSkinsArray = new Array();
		
		for(var i=0; i<mainUserWeaponsStatsArray.length; i++) {
			var weaponSkinsObject = {};
			
			weaponSkinsObject['mainUserWeaponSkin'] = mainUserWeaponsStatsArray[i];
			weaponSkinsObject['friendUserWeaponSkin'] = friendUserWeaponsStatsArray[i];
			weaponSkinsObject['weaponSide'] = mainUserWeaponsStatsArray[i].side;
			weaponSkinsObject['filterMarketHashName'] = mainUserWeaponsStatsArray[i].weaponSkin.marketHashName + ' ' + friendUserWeaponsStatsArray[i].weaponSkin.marketHashName;
			mergedWeaponsSkinsArray.push(weaponSkinsObject);			
		}
		
		return mergedWeaponsSkinsArray;
	}
	
	/*
	 * Append userInfo to friendUserStats
	 */
	$scope.appendUserinfoToFriendStats = function(steamId) {
		var userInfoObject = null;
		
		for(var i=0; i<$scope.friendList.length; i++) {
			if($scope.friendList[i].steamId == steamId) {
				userInfoObject = $scope.friendList[i];
				break;
			}
		}
		
		if(userInfoObject != null) {
			$scope.friendUserStats['userInfo'] = userInfoObject;
		}
	};
	
	/*
	 * Reload Friend / Stranger User inventory.
	 */
	$scope.reloadFriendUserInventory = function(friendUser) {
		$scope.hideFailFriendUserInventoryDownloadingWarning = true;
		
		$http.post($scope.url + '/stats/userInventory', $scope.friendUserStats.userInfo.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendUserInventory = response.data;
				var skinsFromInventory = $scope.getSkinsFromInventory($scope.friendUserStats.userInfo.steamId, $scope.friendUserInventory);
				$scope.friendUserCollectibleItems = skinsFromInventory[1];
				var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory[0]);
				$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.friendUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
			} else {				
				if(friendUser) {
					$scope.replaceFailFriendUserInventoryDownloadingWarningAlertFriend($scope.friendUserStats.userInfo.steamId);
				} else {
					$scope.replaceFailFriendUserInventoryDownloadingWarningAlertStranger();
				}
				
				$scope.hideFailFriendUserInventoryDownloadingWarning = false;				
				throw "failed downloading friend / stranger user inventory.";
			}
		}).catch(function(error) {
			console.log('error: ' + error);
		});	
	};
	
	/*
	 * Load stranger stats for comparison
	 */
	$scope.loadStrangerStatsToCompare = function(strangerProfileData) {
		$scope.hideFailFriendStatsDownloadingError = true;
		$('#strangerStatsCompareButton').attr('disabled', '');
		$scope.hideFriendUserStatsGeneral = true;
		$scope.appendAnimationToFriendUserStatsGeneralBlinking();
		$scope.friendUserInventory = null;
		$scope.friendUserWeaponsStats = null;
		$scope.hideFailFriendUserInventoryDownloadingWarning = true;
		$scope.hideFriendUserStatsWeapons = true;
		$scope.hideFriendUserStatsWeaponsLoading = true;
		$scope.hideFooterCompare = true;
		$scope.hideFriendUserStatsGeneralLoading = false;	
		
		var steamId = $scope.validateEnteredProfile(strangerProfileData);
		
		$http.post($scope.url + '/stats/strangerUserStats', steamId)
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendUserStats = response.data;
				
				var overallStatsArray = $scope.createLastMatchStats($scope.friendUserStats);
				$scope.friendUserStatsOverall = overallStatsArray[0];
				$scope.friendUserStatsLastMatch = overallStatsArray[1];
				$scope.hideFriendUserStatsGeneralLoading = true;
				$scope.hideFriendUserStatsGeneral = false;
				$scope.hideFriendUserStatsWeaponsLoading = false;
				return $http.post($scope.url + '/stats/userInventory', $scope.friendUserStats.userInfo.steamId);
			} else {
				$scope.replaceFailFriendStatsDownloadingErrorAlertStranger();
				$scope.showFailFriendStatsDownloadingError();				
				$scope.hideFooterCompare = false;
				throw "failed downloading stranger user stats.";
			}
		})
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendUserInventory = response.data;									
			} else {
				$scope.replaceFailFriendUserInventoryDownloadingWarningAlertStranger();
				$scope.hideFailFriendUserInventoryDownloadingWarning = false;
				console.log('error: failed downloading stranger user inventory.');
			}
			
			$scope.friendUserWeaponsStatsTemporary = $scope.createWeaponsStats($scope.friendUserStats.userStats.playerstats.stats);	
			
			if($scope.friendUserInventory != null) {
				var skinsFromInventory = $scope.getSkinsFromInventory($scope.friendUserStats.userInfo.steamId, $scope.friendUserInventory);	
				$scope.friendUserCollectibleItems = skinsFromInventory[1];
				var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory[0]);
				$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.friendUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);					
			} else {
				var skinsFromInventoryWithPrices = [];
				$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.friendUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
			}
			
			$scope.mainAndFriendUserWeaponsStats = $scope.concatWeaponsSkinsArrays($scope.mainUserWeaponsStats, $scope.friendUserWeaponsStats);
			$scope.hideFriendUserStatsWeaponsLoading = true;	
			$scope.hideFriendUserStatsWeapons = false;
			$scope.hideFooterCompare = false;
		})
		.catch(function(error) {
			console.log('error: ' + error);
		});						
	};
	
	/*
	 * Load friend stats for comparison
	 */
	$scope.loadFriendStatsToCompare = function(steamId) {
		$scope.hideFailFriendStatsDownloadingError = true;		
		$scope.hideFriendUserStatsGeneral = true;
		$scope.appendAnimationToFriendUserStatsGeneralBlinking();
		$scope.friendUserInventory = null;
		$scope.friendUserWeaponsStats = null;
		$scope.hideFailFriendUserInventoryDownloadingWarning = true;
		$scope.hideFriendUserStatsWeapons = true;
		$scope.hideFriendUserStatsWeaponsLoading = true;
		$scope.hideFooterCompare = true;
		$scope.hideFriendUserStatsGeneralLoading = false;	
		
		$http.post($scope.url + '/stats/userStats', steamId)
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendUserStats = response.data;
					
					$scope.appendUserinfoToFriendStats($scope.friendUserStats.userStats.playerstats.steamID);
					var overallStatsArray = $scope.createLastMatchStats($scope.friendUserStats);
					$scope.friendUserStatsOverall = overallStatsArray[0];
					$scope.friendUserStatsLastMatch = overallStatsArray[1];
					$scope.hideFriendUserStatsGeneralLoading = true;
					$scope.hideFriendUserStatsGeneral = false;
					$scope.hideFriendUserStatsWeaponsLoading = false;
					return $http.post($scope.url + '/stats/userInventory', steamId);
				} else {
					$scope.replaceFailFriendStatsDownloadingErrorAlertFriend(steamId);
					$scope.showFailFriendStatsDownloadingError();					
					$scope.hideFooterCompare = false;
					throw "failed downloading friend user stats.";
				}
			})
			.then(function(response) {
				if(response.data != "" && response.data != null) {
					$scope.friendUserInventory = response.data;					
				} else {
					$scope.replaceFailFriendUserInventoryDownloadingWarningAlertFriend(steamId);
					$scope.hideFailFriendUserInventoryDownloadingWarning = false;
					console.log('error: failed downloading friend user inventory.');
				}
				
				$scope.friendUserWeaponsStatsTemporary = $scope.createWeaponsStats($scope.friendUserStats.userStats.playerstats.stats);	
				
				if($scope.friendUserInventory != null) {
					var skinsFromInventory = $scope.getSkinsFromInventory(steamId, $scope.friendUserInventory);
					$scope.friendUserCollectibleItems = skinsFromInventory[1];
					var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory[0]);
					$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.friendUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);					
				} else {
					var skinsFromInventoryWithPrices = [];
					$scope.friendUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.friendUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
				}
				
				$scope.mainAndFriendUserWeaponsStats = $scope.concatWeaponsSkinsArrays($scope.mainUserWeaponsStats, $scope.friendUserWeaponsStats);
				$scope.hideFriendUserStatsWeaponsLoading = true;	
				$scope.hideFriendUserStatsWeapons = false;
				$scope.hideFooterCompare = false;
			})
			.catch(function(error) {
				console.log('error: ' + error);
			});
	};
	
	/*
	 * Reload Main User inventory.
	 */
	$scope.reloadMainUserInventory = function() {
		$scope.hideFailUserInventoryDownloadingWarning = true;
		
		$http.post($scope.url + '/stats/userInventory', $scope.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.mainUserInventory = response.data;
				var skinsFromInventory = $scope.getSkinsFromInventory($scope.steamId, $scope.mainUserInventory);
				$scope.mainUserCollectibleItems = skinsFromInventory[1];
				$scope.hideMainUserCollectibleItemsShowcase = false;
				var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory[0]);
				$scope.mainUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.mainUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
			} else {	
				$scope.replaceFailUserInventoryDownloadingWarningAlert();
				$scope.hideFailUserInventoryDownloadingWarning = false;
				throw "failed downloading user inventory.";
			}
		}).catch(function(error) {
			console.log('error: ' + error);
		});	
	};
	
	/*
	 * Load main user stats
	 */
	$scope.loadMainUserStats = function(statsReload) {
		if(statsReload) {
			$scope.removeDelayOfAnimationByElementId('#footerMainUserStatsCompare');
			$scope.hideFailStatsDownloadingError = true;
			$scope.hideMainUserStatsGeneralLoading = false;
			$scope.hideFooter = true;
		}
		
		$http.post($scope.url + '/stats/mainUserStats', '{ "steamId": "' + $scope.steamId + '", "checkVanityUrl": false, "checkDigits": false }')
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.mainUserStats = response.data;
				$scope.removeDelayOfAnimationByElementId('#footerMainUserStatsCompare');
				var overallStatsArray = $scope.createLastMatchStats($scope.mainUserStats);
				$scope.mainUserStatsOverall = overallStatsArray[0];
				$scope.mainUserStatsLastMatch = overallStatsArray[1];
				$scope.showMainUserStatsGeneral();
				$scope.hideMainUserStatsWeaponsLoading = false;
				return $http.post($scope.url + '/stats/userInventory', $scope.steamId);
			} else {
				$scope.showFailStatsDownloadingError();
				$scope.addFooterCssProperties();
				$scope.hideFooter = false;
				throw "failed downloading user stats.";
			}
		})
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.mainUserInventory = response.data;					
			} else {
				$scope.replaceFailUserInventoryDownloadingWarningAlert();
				$scope.hideFailUserInventoryDownloadingWarning = false;
				console.log('error: failed downloading user inventory.');
			}
			
			return $http.get($scope.url + '/stats/skinsPrices');
		})
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.skinsPrices = response.data;					
			} else {
				$scope.hideFailSkinsPricesDownloadingWarning = false;
				console.log('failed downloading skins prices.');
			}
			
			return $http.get($scope.url + '/stats/defaultWeapons');
		})
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.defaultWeapons = response.data;
				$scope.hideNavTabCompareOption = false;				
				$scope.mainUserWeaponsStatsTemporary = $scope.createWeaponsStats($scope.mainUserStats.userStats.playerstats.stats);		
				
				if($scope.mainUserInventory != null) {
					var skinsFromInventory = $scope.getSkinsFromInventory($scope.steamId, $scope.mainUserInventory);
					$scope.mainUserCollectibleItems = skinsFromInventory[1];
					$scope.hideMainUserCollectibleItemsShowcase = false;
					var skinsFromInventoryWithPrices = $scope.matchPricesToSkins(skinsFromInventory[0]);
					$scope.mainUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.mainUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
				} else {
					var skinsFromInventoryWithPrices = [];
					$scope.mainUserWeaponsStats = $scope.matchSkinsToWeaponsStats($scope.mainUserWeaponsStatsTemporary, skinsFromInventoryWithPrices);
				}
				
				$scope.showMainUserStatsWeapons();
				$scope.addFooterCssProperties();
				$scope.hideFooter = false;
				
				if($scope.mainUserInventory == null & $scope.skinsPrices != null && $scope.skinsPrices != null) {					
					$scope.replaceFailUserInventoryDownloadingWarningAlert();
				}
			} else {
				$scope.showFailDefaultWeaponsDownloadingError();
				$scope.addFooterCssProperties();
				$scope.hideFooter = false;
				throw "failed downloading default weapons.";
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
		$scope.loadMainUserStats(false);			
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
