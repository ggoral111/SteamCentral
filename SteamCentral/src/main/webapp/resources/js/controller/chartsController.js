function smoothscroll() {
    var currentScroll = document.documentElement.scrollTop || document.body.scrollTop;
    if (currentScroll > 0) {
         window.requestAnimationFrame(smoothscroll);
         window.scrollTo (0,currentScroll - (currentScroll/20));
    }
};

var chartsController = angular.module('chartsController',[]);

chartsController.controller('chartsCtrl', ['$scope', '$http', '$filter', '$compile', function($scope, $http, $filter, $compile) {
	$scope.dateCreation = '2018';
	$scope.steamId = '76561198078305233';	
	$scope.url = "/SteamCentral/data";
	
	$scope.userStats = null;
	
	$scope.hideChartsPanelLoading = true;
	$scope.hideChartsPanel = false;
	
	/*
	 * Add footer CSS properties
	 */
	$scope.addFooterCssProperties = function() {
		$('body').css({
			'display' : 'flex',
			'min-height' : '100vh',
			'flex-direction' : 'column'
		});
		
		$('.charts-stats').css({
			'flex' : '1'
		});
	};
	
	/*
	 * Load user stats from database
	 */
	$scope.loadUserStats = function() {
		$http.post($scope.url + '/stats/userStatsDataForCharts', $scope.steamId)
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				for(var i=0; i<response.data.length; i++) {
					response.data[i].stats = JSON.parse(response.data[i].stats);
				}
				
				$scope.userStats = response.data;
			} else {				
				throw "failed downloading user stats from database.";
			}
		})
		.catch(function(error) {
			console.log('error: ' + error);
		});	
	};
	
	/*
	 * Load content after redirecting to charts page
	 */	
	$scope.$watch('$viewContentLoaded', function(){		
		$scope.addFooterCssProperties();	
		$scope.loadUserStats();
	});
}]);