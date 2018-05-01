<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
	<head>			
		<spring:url value="/resources/css/app-css/fonts.css" var="fontsCss" />
		<link href="${fontsCss}" rel="stylesheet"/>			
		<spring:url value="/resources/js/webfontloader.js" var="webFontLoaderJs" />	
		<script src="${webFontLoaderJs}"></script>		
		<script>
		  WebFont.load({
		    custom: {
		      families: ['kremlin', 'Skarpa Regular', 'Roboto Condensed Light', 'Roboto Condensed Light Italic', 'Roboto Condensed Regular', 'Roboto Light', 'Roboto Thin', 'Roboto Thin Italic', 'Roboto Light', 'Roboto Condensed Bold', 'Roboto Medium']
		    }
		  });
		</script>
		
		<spring:url value="/resources/css/bootstrap.css" var="bootstrapCss" />
		<spring:url value="/resources/css/app-css/navbar.css" var="navbarCss" />
		<spring:url value="/resources/css/app-css/index-view.css" var="indexViewCss" />
		<spring:url value="/resources/css/fontawesome-all.min.css" var="fontawesomeCss" />
		<spring:url value="/resources/css/animate.min.css" var="animateCss" />
		
		<link href="${bootstrapCss}" rel="stylesheet" />		
		<link href="${navbarCss}" rel="stylesheet" />
		<link href="${indexViewCss}" rel="stylesheet" />
		<link href="${fontawesomeCss}" type="text/css" rel="stylesheet" />
		<link href="${animateCss}" rel="stylesheet" />
		
		<spring:url value="/resources/media/steamcentralicon_large.png" var="steamcentral_iconPng" />
		<spring:url value="/resources/media/steamwhiteicon.png" var="steamwhiteiconPng" />
	</head>
	<body data-ng-app="indexController" data-ng-controller="indexCtrl" class="no-js" id="removeBlinking">
		
		<h1 style="font-size: 30px;">Hello!</h1>
		
		<button type="button" data-ng-click="loadFriendList()" class="btn btn-primary">Load</button>
		<p>FriendList:</p>
		<p>{{ friendList }}</p>
		
		<button type="button" data-ng-click="loadMainUserStats()" class="btn btn-primary">Load</button>
		<p>Main User Stats:</p>
		<p>{{ mainUserStats }}</p>
		
		<!-- <button type="button" data-ng-click="loadStrangerUserStats(76561198799925814)" class="btn btn-primary">Load</button>
		<p>Stranger User Stats:</p>
		<p>{{ strangerUserStats }}</p>
		
		<button type="button" data-ng-click="loadUserStats(76561198799925814)" class="btn btn-primary">Load</button>
		<p>User Stats:</p>
		<p>{{ userStats }}</p>
		
		<button type="button" data-ng-click="loadDefaultWeapons()" class="btn btn-primary">Load</button>
		<p>Default Weapons:</p>
		<p>{{ defaultWeapons }}</p>
		
		<button type="button" data-ng-click="loadSkinsPrices()" class="btn btn-primary">Load</button>
		<p>Skin Prices:</p>
		<p>{{ skinsPrices }}</p> -->
		
		<!-- <button type="button" data-ng-click="loadMainUserInventory()" class="btn btn-primary">Load</button>
		<p>Main User Inventory:</p>
		<p>{{ mainUserInventory }}</p> -->
		
		<!-- <button type="button" data-ng-click="loadSecondUserInventory(76561198799925814)" class="btn btn-primary">Load</button>
		<p>Second User Inventory:</p>
		<p>{{ secondUserInventory }}</p> -->
		
		<!-- <p>Main User Weapons Stats:</p>
		<p>{{ mainUserWeaponsStats }}</p> -->
		
		<button type="button" data-ng-click="loadStrangerData()" class="btn btn-primary">Load</button>
		<p>Stranger User Weapons Stats:</p>
		<p>{{ friendUserWeaponsStats }}</p>
		<!-- <p>{{ mainUserWeaponsStats }}</p> -->
								
	    <spring:url value="/resources/js/jquery-3.3.1.min.js" var="jqueryJs" />	
		<spring:url value="/resources/js/angular.js" var="angularJs" />
		<spring:url value="/resources/js/controller/indexController.js" var="indexControllerJs" />
		<spring:url value="/resources/js/bootstrap.js" var="bootstrapJs" />
		<spring:url value="/resources/js/jquery.easing.min.js" var="jqueryeasingminJs" />
		<spring:url value="/resources/js/wow.min.js" var="wowJs" />
		<spring:url value="/resources/js/common.js" var="commonJs" />
		
		<script src="${jqueryJs}"></script>		
		<script src="${angularJs}"></script>
		<script src="${indexControllerJs}"></script>
		<script src="${bootstrapJs}"></script>
		<script src="${jqueryeasingminJs}"></script>
		<script src="${wowJs}"></script>
		<script src="${commonJs}"></script>
		
	</body>
</html>