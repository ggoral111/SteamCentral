var indexController = angular.module('indexController',[]);

indexController.controller('indexCtrl', ['$scope', '$http', '$filter', '$compile', function($scope, $http, $filter, $compile) {
	$scope.dateCreation = '2018';
	$scope.steamId = '76561198078305233';
	$scope.url = "http://localhost:8080/SteamCentral/data";
	$scope.friendList = null;
	$scope.mainUserStats = null;
	$scope.strangerUserStats = null;
	$scope.userStats = null;
	$scope.defaultWeapons = null;
	$scope.skinsPrices = null;
	$scope.mainUserInventory = null;
	$scope.secondUserInventory = null;
	
	$scope.loadFriendList = function() {	
		$http.post($scope.url + '/stats/friendList', $scope.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.friendList = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
	$scope.loadMainUserStats = function() {	
		$http.post($scope.url + '/stats/strangerUserStats', $scope.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.mainUserStats = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
		
	$scope.loadStrangerUserStats = function(strangerSteamId) {	
		$http.post($scope.url + '/stats/strangerUserStats', $scope.strangerSteamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.strangerUserStats = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
	$scope.loadUserStats = function(userSteamId) {	
		$http.post($scope.url + '/stats/userStats', $scope.userSteamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.userStats = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
	$scope.loadDefaultWeapons = function() {	
		$http.get($scope.url + '/stats/defaultWeapons').then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.defaultWeapons = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
	$scope.loadSkinsPrices = function() {	
		$http.get($scope.url + '/stats/skinsPrices').then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.skinsPrices = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
		
	$scope.loadMainUserInventory = function() {	
		$http.post($scope.url + '/stats/userInventory', $scope.steamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.mainUserInventory = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
	$scope.loadSecondUserInventory = function(inventorySteamId) {	
		$http.post($scope.url + '/stats/userInventory', $scope.inventorySteamId).then(function(response) {
			if(response.data != "" && response.data != null) {
				$scope.secondUserInventory = response.data;
			} else {
				alert("Server encountered some error while downloading data. Please try again later.");
			}
		}).catch(function(response) {
			alert("Server encountered some error while downloading data. Please try again later.");
		});
	};
	
}]);

indexController.config( [
    '$compileProvider',
    function($compileProvider) {   
        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|local|data|ftp|mailto|chrome-extension):/);
    }
]);
