$(document).ready(function(){
	$("div#loginRow").css("margin-top", function() {
		return (($(window).height() - $("div#loginRow").height()) / 2) +"px";
	});
	
	$(window).resize(function() {
		$("div#loginRow").css("margin-top", function() {
			return (($(window).height() - $("div#loginRow").height()) / 2) +"px";
		});
	});	
});

var loginController = angular.module('loginController',[]);

loginController.controller('loginCtrl', ['$scope', '$http', '$filter', '$compile', function($scope, $http, $filter, $compile) {
	$scope.dateCreation = '2018';
	
	
	
	
	
	
}]);

indexController.config( [
    '$compileProvider',
    function($compileProvider) {   
        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|local|data|ftp|mailto|chrome-extension):/);
    }
]);