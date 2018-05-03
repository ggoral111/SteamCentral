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
		      families: ['kremlin', 'Skarpa Regular', 'Roboto Condensed Light', 'Roboto Condensed Light Italic', 'Roboto Condensed Regular', 'Roboto Light', 'Roboto Thin', 'Roboto Thin Italic', 'Roboto Light', 'Roboto Condensed Bold', 'Roboto Medium', 'Oswald ExtraLight']
		    }
		  });
		</script>
		
		<spring:url value="/resources/css/bootstrap.css" var="bootstrapCss" />
		<%-- <spring:url value="/resources/css/bootstrap-select.css" var="bootstrapSelectCss" /> --%>
		<spring:url value="/resources/css/app-css/navbar.css" var="navbarCss" />
		<spring:url value="/resources/css/app-css/index-view.css" var="indexViewCss" />
		<spring:url value="/resources/css/fontawesome-all.min.css" var="fontawesomeCss" />
		<spring:url value="/resources/css/animate.min.css" var="animateCss" />
		
		<link href="${bootstrapCss}" rel="stylesheet" />	
		<%-- <link href="${bootstrapSelectCss}" rel="stylesheet" />	 --%>
		<link href="${navbarCss}" rel="stylesheet" />
		<link href="${indexViewCss}" rel="stylesheet" />
		<link href="${fontawesomeCss}" type="text/css" rel="stylesheet" />
		<link href="${animateCss}" rel="stylesheet" />
		
		<spring:url value="/resources/media/steamcentralicon_large.png" var="steamcentral_iconPng" />
		<spring:url value="/resources/media/steamwhiteicon.png" var="steamwhiteiconPng" />
	</head>
	<body data-ng-app="indexController" data-ng-controller="indexCtrl" class="no-js" id="removeBlinking">
	
		<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
	        <div class="container">
	            <div class="navbar-header">
	                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
	                	<i class="fa fa-bars fa-2x"></i>
	                </button>
	                <a class="navbar-nonbrand page-scroll" href="" onclick="this.blur(); smoothscroll()">
	                    <img src="${steamcentral_iconPng}" width="40" height="40"></img>
	                    <span class="light">SteamCentral</span>
	                </a>
	            </div>           
	            <div class="collapse navbar-collapse navbar-main-collapse">
	                <ul class="nav navbar-nav navbar-right">
	                    <li>
		                    <a class="page-scroll" href="#logout">
		  						<button onclick="location.href='/SteamCentral/login'" class="btn btn-inverse-left dropdown-toggle" type="button" onclick="this.blur();">Logout</button>
							</a>
						</li>
	                </ul>
	            </div>
	        </div>
	    </nav>
		
		<div data-ng-hide="hideMainUserStats" data-ng-cloak class="main-user-stats">		
			<div class="container main-user-stats-container">
				
				<div class="row">
		            <div class="col-sm-12 col-md-12 col-lg-12">
		                <h1 class="page-header page-header-stats wow fadeInDown" data-wow-duration="2s">CS:GO Statistics <small>With comparison system</small>
		                </h1>
		            </div>
		        </div>
		        	        			
		        <ul class="nav-custom nav-tabs nav-justified wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" id="ul-switch-stats">
					<li class="active">
						<a href="" data-ng-click="" class="nav-tab-text-formatter">Your statistics</a>
					</li>
					<li>
						<a href="" data-ng-click="" class="nav-tab-text-formatter">Compare with friends & users</a>
					</li>
				</ul>
			
				<div class="panel-group main-user-stats-sort-panel wow fadeIn" data-wow-duration="2s" data-wow-delay="1s">
				    <div class="panel panel-default main-user-stats-sort-panel">
						<div class="panel-heading main-user-stats-sort-panel" data-toggle="collapse" data-target="#mainUserStatsSortPanelCollapse">
							<h4 class="panel-title main-user-stats-sort-panel">
						    	Sort & Search Options
						    </h4>      				        
						</div>
						<div id="mainUserStatsSortPanelCollapse" class="panel-collapse collapse">
							<div class="panel-body main-user-stats-sort-panel">
								<div class="row">
									<div class="col-sm-6 col-md-6 col-lg-6">
										<div class="input-group sort-combobox">
											<select class="form-control search-in-stats" data-ng-model="selectedItemMainUserStats">
											   	<option value="" disabled="disabled" selected="selected" hidden="hidden">Sort by...</option>								   		
											  	<option value="totalKills" label="Total Kills (ASC)">Total Kills (ASC)</option>					
											  	<option value="-totalKills" label="Total Kills (DESC)">Total Kills (DESC)</option>
											  	<option value="totalShots" label="Total Shots (ASC)">Total Shots (ASC)</option>					
											  	<option value="-totalShots" label="Total Shots (DESC)">Total Shots (DESC)</option>
											  	<option value="totalHits" label="Total Hits (ASC)">Total Hits (ASC)</option>					
											  	<option value="-totalHits" label="Total Hits (DESC)">Total Hits (DESC)</option>
											  	<option value="accuracy" label="Accuracy (ASC)">Accuracy (ASC)</option>					
											  	<option value="-accuracy" label="Accuracy (DESC)">Accuracy (DESC)</option>
											  	<option value="shotsPerKill" label="Shots Per Kill (ASC)">Shots Per Kill (ASC)</option>					
											  	<option value="-shotsPerKill" label="Shots Per Kill (DESC)">Shots Per Kill (DESC)</option>
											  	<option value="weaponSkin.marketHashName" label="Weapon Type (ASC)">Weapon Type (ASC)</option>					
											  	<option value="-weaponSkin.marketHashName" label="Weapon Type (DESC)">Weapon Type (DESC)</option>
											  	<option value="weaponSkin.rarity" label="Weapon Rarity (ASC)">Weapon Rarity (ASC)</option>					
											  	<option value="-weaponSkin.rarity" label="Weapon Rarity (DESC)">Weapon Rarity (DESC)</option>
											  	<option value="weaponSkin.price" label="Weapon Price (ASC)">Weapon Price (ASC)</option>					
											  	<option value="-weaponSkin.price" label="Weapon Price (DESC)">Weapon Price (DESC)</option>
											</select>
										</div>
									</div>
									<div class="col-sm-6 col-md-6 col-lg-6">
										<div class="input-group">
											<input type="text" data-ng-model="searchMainUserStatsPhrase" class="form-control search-stats" placeholder="Search for weapons...">
											<span class="input-group-btn">
												<button data-ng-click="searchMainUserStatsPhrase = ''" onclick="this.blur();" class="btn btn-default sort-clear-button" type="button">Clear</button>
											</span>
										</div>
									</div>
								</div>			        	        			        	
							</div>
						</div>							      
					</div>     
				</div>
				
				<div data-ng-hide="hideMainUserStatsGeneralLoading" data-ng-cloak>
					<div class="container">
						<div class="row loading-content-row">
							<div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
								<!-- <p class="loading-content-p wow fadeIn" data-wow-duration="2s" data-wow-delay="1.5s">Loading...</p> -->
								<div id="loading">
									<div id="loading-center">
										<div id="loading-center-absolute">
											<div class="object" id="object_four"></div>
											<div class="object" id="object_three"></div>
											<div class="object" id="object_two"></div>
											<div class="object" id="object_one"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
								
				<div data-ng-hide="hideFailStatsDownloadingError" data-ng-cloak class="alert alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
					<strong>Error:</strong> failed downloading user statistics.
					<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
								
				<div data-ng-hide="hideMainUserStatsGeneral" data-ng-cloak class="main-user-stats-general wow fadeIn" data-wow-duration="1.5s" data-wow-delay="1s">
					<div class="container">
						<div class="row">
							<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 csgostats-overall-grid">
								<div class="csgostats-overall-grid-cell">
									<div class="row center-block">
										<div class="col-md-12 col-csgostats-overall-grid-title">
											<p class="csgostats-overall-title-formatter-center">Overall statistics</p>
										</div>
									</div>
									<div class="row center-block">
										<div class="col-sm-4 col-md-3 col-xl-3" align="center">
											<div class="csgostats-overall-user-avatar-cell">
												<div class="row">
													<div class="col-md-12 csgostats-overall-user-avatar-image">
														<img data-ng-src="{{ mainUserStats.userInfo.avatarFullURL }}" class="img-responsive full-width">
													</div>
												</div>
												<div class="row">
													<div class="col-md-12 col-csgostats-overall-grid-user-name">
														<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank" class="csgostats-overall-user-name-formatter-center">{{ mainUserStats.userInfo.personaname }}</a>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-5 col-md-5 col-xl-5">
											<div class="csgostats-overall-all-stats-cell">
												<div class="row">
													<div class="col-md-12 col-csgostats-grid-weapon-name">
														<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank" class="csgostats-overall-user-name-formatter-center">{{ mainUserStats.userInfo.personaname }}</a>
													</div>
												</div>
												<p>TODO: main stats, avatar poprawic, za duzy i nie skaluje sie, filtrowanie weapons CT, TT, both sides</p>
											</div>
										</div>
										<div class="col-sm-3 col-md-4 col-xl-4">
											<div class="csgostats-overall-all-stats-cell">
												<div class="row">
													<div class="col-md-12 col-csgostats-grid-weapon-name">
														<p class="csgostats-overall-user-name-formatter-center">Last match:</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>			
								
				<div data-ng-hide="hideFailUserInventoryDownloadingWarning" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
					<strong>Warning:</strong> failed downloading user inventory.
					<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>				
				
				<div data-ng-hide="hideFailSkinsPricesDownloadingWarning" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
					<strong>Warning:</strong> failed downloading skins prices.
					<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
							
				<div data-ng-hide="hideFailDefaultWeaponsDownloadingError" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
					<strong>Error:</strong> failed downloading default weapons info.
					<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div data-ng-hide="hideMainUserStatsWeaponsLoading" data-ng-cloak>
					<div class="container">
						<div class="row loading-content-row">
							<div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
								<!-- <p class="loading-content-p wow fadeIn" data-wow-duration="2s" data-wow-delay="1.5s">Loading...</p> -->
								<div id="loading">
									<div id="loading-center">
										<div id="loading-center-absolute">
											<div class="object" id="object_four"></div>
											<div class="object" id="object_three"></div>
											<div class="object" id="object_two"></div>
											<div class="object" id="object_one"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
								
				<div data-ng-hide="hideMainUserStatsWeapons" data-ng-cloak class="main-user-stats-weapons">
					<div class="row center-block csgostats-row">
						<div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-xs-12 csgostats-grid" data-ng-repeat="weaponStats in mainUserWeaponsStats | filter:{filterHashName:searchMainUserStatsPhrase} | orderBy:selectedItemMainUserStats" data-ng-if="weaponStats !== null">
							<div class="csgostats-grid-cell wow fadeInDown">											
								<div class="row center-block">
									<div class="col-md-12 col-csgostats-grid-weapon-title">
										<p class="csgostats-weapon-title-formatter-center">{{ weaponStats.weaponSkin.type }}</p>
									</div>
								</div>
								<div class="row center-block">
									<div data-ng-if="weaponStats.weaponSkin.souvenir" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ weaponStats.weaponSkin.color }}, 0.4) 0%,rgba({{ weaponStats.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(255, 215, 0, 0.8) 95%,rgba(255, 215, 0, 0.8) 100%);">
										<div data-ng-if="marketHashNameLength(weaponStats.weaponSkin.marketHashName)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName) | unsafe"></div>								
										<p data-ng-if="!marketHashNameLength(weaponStats.weaponSkin.marketHashName)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
									</div>
									<div data-ng-if="weaponStats.weaponSkin.statTrak" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ weaponStats.weaponSkin.color }}, 0.4) 0%,rgba({{ weaponStats.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(207, 106, 50, 0.8) 95%,rgba(207, 106, 50, 0.8) 100%);">
										<div data-ng-if="marketHashNameLength(weaponStats.weaponSkin.marketHashName)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName) | unsafe"></div>								
										<p data-ng-if="!marketHashNameLength(weaponStats.weaponSkin.marketHashName)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
									</div>
									<div data-ng-if="!weaponStats.weaponSkin.souvenir && !weaponStats.weaponSkin.statTrak" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: rgba({{ weaponStats.weaponSkin.color }}, 0.4);">
										<div data-ng-if="marketHashNameLength(weaponStats.weaponSkin.marketHashName)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName) | unsafe"></div>								
										<p data-ng-if="!marketHashNameLength(weaponStats.weaponSkin.marketHashName)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
									</div>
								</div>
								<div class="row center-block">
									<div class="col-md-12 col-csgostats-grid-image-background">
										<div class="csgostats-weapon-image">
											<img data-ng-src="{{ weaponStats.weaponSkin.iconUrl }}" class="img-responsive full-width">	
										</div>
									</div>
								</div>
								<div class="row center-block">
									<div class="col-sm-6 col-md-6 col-xl-6 csgostats-grid-padding-left">
										<a href="http://steamcommunity.com/market/listings/730/{{ weaponStats.weaponSkin.marketHashName }}" target="_blank">
											<button data-ng-if="weaponStats.weaponSkin.price != 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: {{ weaponStats.weaponSkin.price }}$</button>
											<button data-ng-if="weaponStats.weaponSkin.price == 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: N/A</button>
										</a>									
									</div>
									<div class="col-sm-6 col-md-6 col-xl-6 csgostats-grid-padding-right">
										<a href="{{ weaponStats.weaponSkin.inspectInGame }}">
											<button class="btn csgostats-inspect-button" type="button" onclick="this.blur();">Inspect in-game</button>		
										</a>
									</div>
								</div>
								<div class="row center-block">
									<div class="col-md-12 col-csgostats-grid-weapon-stats-title">
										<p class="csgostats-weapon-title-formatter-center">Weapon Stats</p>
									</div>
								</div>
								<div class="row">
								    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-6">
								         <p class="modal-text-formatter-left p-games-list">Total kills:</p>
								         <p class="modal-text-formatter-left p-games-list">Total shots:</p>
								         <p class="modal-text-formatter-left p-games-list">Total hits:</p>
								         <p class="modal-text-formatter-left p-games-list">Accuracy:</p>
								         <p class="modal-text-formatter-left p-games-list">Shots per kill:</p>
									</div>
								    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-6">
										<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ weaponStats.totalKills }}</p>
										<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>
										<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.totalShots }}</p>
										<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves' || weaponStats.weaponSkin.type == 'Knife' || weaponStats.weaponSkin.type == 'High Explosive Grenade' || weaponStats.weaponSkin.type == 'Incendiary Grenade / Molotov'"class="modal-text-formatter p-games-list">N/A</p>
										<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.totalHits }}</p>
										<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves' || weaponStats.weaponSkin.type == 'Knife' || weaponStats.weaponSkin.type == 'High Explosive Grenade' || weaponStats.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>				            		   
										<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.accuracy }}%</p>
										<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves' || weaponStats.weaponSkin.type == 'Knife' || weaponStats.weaponSkin.type == 'High Explosive Grenade' || weaponStats.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>
										<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.shotsPerKill }}</p>
										<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves' || weaponStats.weaponSkin.type == 'Knife' || weaponStats.weaponSkin.type == 'High Explosive Grenade' || weaponStats.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>          
									</div>
								</div>			             	
							</div>			
						</div>
					</div>	
				</div>
				
			</div>		
		</div>
	
		<footer data-ng-hide="hideFooter" data-ng-cloak class="text-center">
		   <div class="footer-above">
		      <div class="container">
		         <div class="row">
		            <div class="footer-col col-md-4">
		               <h3 class="footer-above-font header">Web Creator</h3>
		               <p class="footer-above-font font">Jakub Podgórski</p>
		            </div>
		            <div class="footer-col col-md-4">
		               <h3 class="footer-above-font header">Contact</h3>
		               <ul class="list-inline">
		                  <li>
		                     <a href="mailto:ggoral111@gmail.com" class="btn-social btn-outline" onclick="this.blur();"><i class="far fa-envelope"></i></a>
		                  </li>
		                  <li>
		                     <a target="_blank " href="https://steamcommunity.com/profiles/76561198078305233" class="btn-social btn-outline" onclick="this.blur();"><i class="fab fa-steam-symbol"></i></a>
		                  </li>
		                  <li>
		                     <a target="_blank" href="https://twitter.com" class="btn-social btn-outline" onclick="this.blur();"><i class="fab fa-twitter"></i></a>
		                  </li>
		               </ul>
		            </div>
		            <div class="footer-col col-md-3">
		               <h3 class="footer-above-font header">About Project</h3>
		               <p class="footer-above-font font">This project was made for testing purpose only. Not gonna lie that it was not tested on my girlfriend. Have fun!</p>
		            </div>
		         </div>
		      </div>
		   </div>
		   <div class="footer-below">
		      <div class="container">
		         <div class="row">
		            <div class="col-lg-12">
		               <p class="footer-below-font font">Copyright &copy; SteamCentral {{ dateCreation }}</p>
		            </div>
		         </div>
		      </div>
		   </div>
		</footer>
								
	    <spring:url value="/resources/js/jquery-3.3.1.min.js" var="jqueryJs" />	
		<spring:url value="/resources/js/angular.js" var="angularJs" />
		<spring:url value="/resources/js/controller/indexController.js" var="indexControllerJs" />
		<spring:url value="/resources/js/bootstrap.js" var="bootstrapJs" />
		<%-- <spring:url value="/resources/js/bootstrap-select.min.js" var="bootstrapSelectJs" /> --%>
		<spring:url value="/resources/js/jquery.easing.min.js" var="jqueryeasingminJs" />
		<spring:url value="/resources/js/wow.min.js" var="wowJs" />
		<%-- <spring:url value="/resources/js/countUp.min.js" var="countUpJs" />
		<spring:url value="/resources/js/angular-countUp.min.js" var="angularCountUpJs" /> --%>
		<spring:url value="/resources/js/common.js" var="commonJs" />
		
		<script src="${jqueryJs}"></script>		
		<script src="${angularJs}"></script>
		<script src="${indexControllerJs}"></script>
		<script src="${bootstrapJs}"></script>
		<%-- <script src="${bootstrapSelectJs}"></script> --%>
		<script src="${jqueryeasingminJs}"></script>
		<script src="${wowJs}"></script>
		<%-- <script src="${countUpJs}"></script>
		<script src="${angularCountUpJs}"></script> --%>
		<script src="${commonJs}"></script>
		
	</body>
</html>