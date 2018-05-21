<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
	<head>		
		<title>SteamCentral</title>
		<spring:url value="/resources/media/steamcentralicon.ico" var="steamCentralIcon" />
		<link href="${steamCentralIcon}" rel="icon" />
			
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
		<div class="main-user-stats">		
			<div class="container main-user-stats-container">				
				<div class="row">
		            <div class="col-sm-12 col-md-12 col-lg-12">
		                <h1 class="page-header page-header-stats wow fadeInDown" data-wow-duration="2s">CS:GO Statistics <small>With comparison system</small>
		                </h1>
		            </div>
		        </div>	        	        			
		        <ul class="nav-custom nav-tabs nav-justified wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" id="ul-switch-stats">
					<li class="active">
						<a href="" data-ng-click="showMainUserStats()" class="nav-tab-text-formatter">Your statistics</a>
					</li>
					<li data-ng-hide="hideNavTabCompareOption" data-ng-cloak>
						<a href="" data-ng-click="showFriendUserStats(); loadFriendList()" class="nav-tab-text-formatter">Compare with friends & users</a>
					</li>
				</ul>				
				<div data-ng-hide="hideMainUserStats" data-ng-cloak class="wow fadeIn" data-wow-duration="1s">
					<div data-ng-hide="hideMainUserStatsPanel" data-ng-cloak id="mainUserStatsPanelBlinking" class="panel-group main-user-stats-sort-panel wow fadeIn" data-wow-duration="2s" data-wow-delay="1s">
					    <div class="panel panel-default main-user-stats-sort-panel">
							<div class="panel-heading main-user-stats-sort-panel" role="tab" data-toggle="collapse" data-target="#mainUserStatsSortPanelCollapse" aria-expanded="true" aria-controls="mainUserStatsSortPanelCollapse">
								<h4 class="panel-title main-user-stats-sort-panel">
							    	Sort & Search Options
							    </h4>      				        
							</div>
							<div id="mainUserStatsSortPanelCollapse" class="panel-collapse collapse" role="tabpanel">
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
										<div class="col-sm-6 col-md-6 col-lg-6 col-panel-search-input">
											<div class="input-group">
												<input type="text" data-ng-model="searchMainUserStatsPhrase" class="form-control search-stats" placeholder="Search for weapons...">
												<span class="input-group-btn">
													<button data-ng-click="searchMainUserStatsPhrase = ''" onclick="this.blur();" class="btn btn-default sort-clear-button" type="button">Clear</button>
												</span>
											</div>
										</div>
									</div>	
									<div class="row">
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="0" data-ng-false-value="" data-ng-model="mainUserWeaponsStatsSideFilter" name="checkbox" id="checkbox1"/>
										            <label for="checkbox1">Show TT weapons only</label>
										        </div>
									        </div>
										</div>
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="1" data-ng-false-value="" data-ng-model="mainUserWeaponsStatsSideFilter" name="checkbox" id="checkbox2"/>
										            <label for="checkbox2">Show CT weapons only</label>
										        </div>
									        </div>
										</div>
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="2" data-ng-false-value="" data-ng-model="mainUserWeaponsStatsSideFilter" name="checkbox" id="checkbox3"/>
										            <label for="checkbox3">Show both sides weapons only</label>
										        </div>
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
					<div data-ng-hide="hideFailStatsDownloadingError" id="failStatsDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<strong>Error:</strong> failed downloading user statistics. <a href="https://steamcommunity.com/profiles/{{ steamId }}/edit/settings" onclick="this.blur();" class="error-alert" target="_blank">Make sure that your Steam profile and inventory privacy settings are set to public</a> (it may take a while when privacy settings will be overridden) and then <a class="error-alert" data-ng-click="loadMainUserStats(true)" onclick="this.blur();">click here<i class="fas fa-sync-alt reload-icon-error-alert"></i></a> to try to download your statistics again.
					</div>								
					<div data-ng-hide="hideMainUserStatsGeneral" data-ng-cloak id="mainUserStatsGeneralBlinking" class="main-user-stats-general wow fadeIn" data-wow-duration="1.5s" data-wow-delay="1s">
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
											<div class="col-xs-12 col-sm-12 col-md-6 col-xl-6 col-csgostats-overall-section-outer">										
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-user-info-section-outer">
														<div class="row">
															<div class="col-xs-12 col-sm-4 col-md-6 col-lg-5 col-xl-5 col-csgostats-avatar-section-inner">
																<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">
																	<img data-ng-src="{{ mainUserStats.userInfo.avatarFullURL }}" class="img-rounded img-responsive csgostats-avatar-img">
																</a>
															</div>
															<div class="col-xs-12 col-sm-8 col-md-6 col-lg-7 col-xl-7 col-csgostats-overall-section-user-info">
																<div class="row">
																	<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																		<p class="csgostats-overall-info-formatter-center">User info</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section"></div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-5 col-sm-4 col-md-4 col-lg-4 col-xl-4 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Username:</p>
																	</div>
																	<div class="col-xs-7 col-sm-8 col-md-8 col-lg-8 col-xl-8 col-csgostats-overall-user-info-entry">																	
																		<p class="csgostats-overall-user-info-text-right">
																			<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">{{ mainUserStats.userInfo.personaname }}</a>
																		</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-4 col-sm-7 col-md-5 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">SteamID:</p>
																	</div>
																	<div class="col-xs-8 col-sm-5 col-md-7 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ mainUserStats.userInfo.steamId }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">VAC banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!mainUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of VAC bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfVACBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ mainUserStats.userBansInfo.NumberOfVACBans }}</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ mainUserStats.userBansInfo.NumberOfVACBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of game bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ mainUserStats.userBansInfo.NumberOfGameBans }}</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ mainUserStats.userBansInfo.NumberOfGameBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans == 0 && mainUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-left">Days since last ban:</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans != 0 || mainUserStats.userBansInfo.NumberOfVACBans != 0" class="csgostats-overall-user-info-text-left text-red">Days since last ban:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ mainUserStats.userBansInfo.DaysSinceLastBan }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Community banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!mainUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Economy banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.EconomyBan != 'none'" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="mainUserStats.userBansInfo.EconomyBan == 'none'" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section-end"></div>
															</div>
														</div>
													</div>
												</div>												
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section">
														<div class="row">
															<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																<p class="csgostats-overall-info-formatter-center">Last match</p>
															</div>
														</div>	
														<div class="row row-csgostats-overall-section"></div>
														<div class="row row-csgostats-overall-entry" data-ng-repeat="lastMatchStats in mainUserStatsLastMatch" data-ng-if="lastMatchStats.value !== null">
															<div class="col-xs-2 col-sm-2 col-md-2 col-xl-2 col-csgostats-overall-stats-entry">
																<img data-ng-src="{{ lastMatchStats.iconVariable }}" class="csgostats-overall-stats-image"></img>
															</div>
															<div class="col-xs-7 col-sm-7 col-md-7 col-xl-7 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-left">{{ lastMatchStats.name }}</p>
															</div>
															<div class="col-xs-3 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p data-ng-if="lastMatchStats.statsName == 'last_match_wins'" class="csgostats-overall-stats-text-right" style="color: {{ lastMatchStats.color }};">{{ lastMatchStats.value.toLocaleString() }}</p>
																<p data-ng-if="lastMatchStats.statsName != 'last_match_wins'" class="csgostats-overall-stats-text-right">{{ lastMatchStats.value.toLocaleString() }}</p>
															</div>
														</div>
													</div>
												</div>																	
											</div>										
											<div class="col-xs-12 col-sm-12 col-md-6 col-xl-6 col-csgostats-overall-section-outer-overall-stats">	
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section">								
														<div class="row">
															<div class="col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																<p class="csgostats-overall-info-formatter-center">Overall</p>
															</div>
														</div>
														<div class="row row-csgostats-overall-section"></div>
														<div class="row row-csgostats-overall-entry" data-ng-repeat="overallStats in mainUserStatsOverall" data-ng-if="overallStats.value !== null">
															<div class="col-xs-2 col-sm-2 col-md-2 col-xl-2 col-csgostats-overall-stats-entry">
																<img data-ng-src="{{ overallStats.iconVariable }}" class="csgostats-overall-stats-image"></img>
															</div>
															<div class="col-xs-5 col-sm-7 col-md-7 col-xl-7 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-left">{{ overallStats.name }}</p>
															</div>
															<div class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p data-ng-if="!(overallStats.statsName == 'total_money_earned')" class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
																<p data-ng-if="overallStats.statsName == 'total_money_earned'" class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>
														</div>																					
													</div>
												</div>
											</div>
											<!-- <div data-ng-hide="hideMainUserCollectibleItemsShowcase" id="mainUserStatsGeneralCollectibleItemsShowcaseBlinking" data-ng-cloak class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-overall-section-collectible-stats wow fadeIn" data-wow-duration="1.5s">	
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section">								
														<div class="row collapsed" style="cursor: pointer;" data-toggle="collapse" data-target="#mainUserCollectibleItemsShowcaseCollapse" aria-expanded="false" aria-controls="mainUserCollectibleItemsShowcaseCollapse">
															<div class="col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																<p class="csgostats-overall-info-formatter-center">Coins & Medals & Pins showcase</p>
															</div>
														</div>
														<div class="row center-block csgostats-row">
															<div class="collapse" id="mainUserCollectibleItemsShowcaseCollapse">
																<div class="col-xl-2 col-lg-2 col-md-2 col-sm-3 col-xs-6 csgostats-grid" data-ng-repeat="collectibleItem in mainUserCollectibleItems" data-ng-if="collectibleItem !== null">
																	<div class="csgostats-grid-cell wow fadeIn">																											
																		<div class="row center-block">
																			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-collectible-name" style="background: rgb({{ collectibleItem.color }}); background: linear-gradient(to bottom, rgba({{ collectibleItem.color }}, 0.4) 0%,rgba({{ collectibleItem.color }}, 0.4) 95%,#000000 95%,rgba({{ collectibleItem.nameColor }}, 0.8) 95%,rgba({{ collectibleItem.nameColor }}, 0.8) 100%);">
																				<div data-ng-if="measureTextLengthInPixels(collectibleItem.marketHashName, '11px Roboto Condensed Regular', 100)" data-ng-bind-html="splitMarketHashNameShowcase(collectibleItem.marketHashName) | unsafe"></div>								
																				<p data-ng-if="!measureTextLengthInPixels(collectibleItem.marketHashName, '11px Roboto Condensed Regular', 100)" class="csgostats-collectible-name-formatter-center">{{ collectibleItem.marketHashName }}</p>
																			</div>
																		</div>
																		<div class="row center-block">
																			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-image-background">
																				<div class="csgostats-collectible-image">
																					<img data-ng-src="{{ collectibleItem.iconUrlLarge }}" class="img-responsive full-width">	
																				</div>
																			</div>
																		</div>
																		<div class="row">
																			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">																			
																				<a href="{{ collectibleItem.inspectInGame }}">
																					<button class="btn csgostats-collectible-inspect-button" type="button" onclick="this.blur();">Inspect in-game</button>		
																				</a>									
																			</div>
																		</div>																	            	
																	</div>			
																</div>
															</div>
														</div>																			
													</div>
												</div>
											</div> -->																			
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>									
					<div data-ng-hide="hideFailUserInventoryDownloadingWarning" id="failUserInventoryDownloadingWarningAlert" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<div id="failUserInventoryDownloadingWarningAlertInner">
							<strong>Warning:</strong> failed downloading user inventory.						
						</div>
					</div>									
					<div data-ng-hide="hideFailSkinsPricesDownloadingWarning" id="failSkinsPricesDownloadingWarningAlert" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<strong>Warning:</strong> failed downloading skins prices.
						<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>								
					<div data-ng-hide="hideFailDefaultWeaponsDownloadingError" id="failDefaultWeaponsDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<strong>Error:</strong> failed downloading default weapons info.
						<button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.blur();">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>					
					<div data-ng-hide="hideMainUserStatsWeaponsLoading" data-ng-cloak>
						<div class="container">
							<div class="row loading-content-row">
								<div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
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
					<div data-ng-hide="hideMainUserStatsWeapons" data-ng-cloak>
						<div class="row center-block csgostats-row">
							<div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-xs-12 csgostats-grid" data-ng-repeat="weaponStats in mainUserWeaponsStats | filter:{filterHashName: searchMainUserStatsPhrase, side: mainUserWeaponsStatsSideFilter} | orderBy:selectedItemMainUserStats" data-ng-if="weaponStats !== null">
								<div class="csgostats-grid-cell wow fadeInDown">											
									<div class="row center-block">
										<div class="col-md-12 col-csgostats-grid-weapon-title">
											<p class="csgostats-weapon-title-formatter-center">{{ weaponStats.weaponSkin.type }}</p>
										</div>
									</div>
									<div class="row center-block">
										<div data-ng-if="weaponStats.weaponSkin.souvenir" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ weaponStats.weaponSkin.color }}, 0.4) 0%,rgba({{ weaponStats.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(255, 215, 0, 0.8) 95%,rgba(255, 215, 0, 0.8) 100%);">
											<div data-ng-if="measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName, true) | unsafe"></div>								
											<p data-ng-if="!measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
										</div>
										<div data-ng-if="weaponStats.weaponSkin.statTrak" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ weaponStats.weaponSkin.color }}, 0.4) 0%,rgba({{ weaponStats.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(207, 106, 50, 0.8) 95%,rgba(207, 106, 50, 0.8) 100%);">
											<div data-ng-if="measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName, true) | unsafe"></div>								
											<p data-ng-if="!measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
										</div>
										<div data-ng-if="!weaponStats.weaponSkin.souvenir && !weaponStats.weaponSkin.statTrak" class="col-md-12 col-csgostats-grid-weapon-name" style="background: rgb({{ weaponStats.weaponSkin.color }}); background: rgba({{ weaponStats.weaponSkin.color }}, 0.4);">
											<div data-ng-if="measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(weaponStats.weaponSkin.marketHashName, false) | unsafe"></div>								
											<p data-ng-if="!measureTextLengthInPixels(weaponStats.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ weaponStats.weaponSkin.marketHashName }}</p>
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
										<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-left">
											<a href="http://steamcommunity.com/market/listings/730/{{ weaponStats.weaponSkin.marketHashName }}" target="_blank">
												<button data-ng-if="weaponStats.weaponSkin.price != 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: {{ weaponStats.weaponSkin.price }}$</button>
												<button data-ng-if="weaponStats.weaponSkin.price == 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: N/A</button>
											</a>									
										</div>
										<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-right">
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
											<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ weaponStats.totalKills.toLocaleString() }}</p>
											<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>
											<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.totalShots.toLocaleString() }}</p>
											<p data-ng-if="weaponStats.weaponSkin.type == 'Gloves' || weaponStats.weaponSkin.type == 'Knife' || weaponStats.weaponSkin.type == 'High Explosive Grenade' || weaponStats.weaponSkin.type == 'Incendiary Grenade / Molotov'"class="modal-text-formatter p-games-list">N/A</p>
											<p data-ng-if="weaponStats.weaponSkin.type != 'Gloves' && weaponStats.weaponSkin.type != 'Knife' && weaponStats.weaponSkin.type != 'High Explosive Grenade' && weaponStats.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ weaponStats.totalHits.toLocaleString() }}</p>
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
				<div data-ng-hide="hideFriendUserStats" data-ng-cloak class="wow fadeIn" data-wow-duration="1s">				
					<div data-ng-hide="hideFriendUserStatsPanelLoading" data-ng-cloak>
						<div class="container">
							<div class="row loading-content-row-smaller">
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
					<div data-ng-hide="hideFriendUserStatsPanel" data-ng-cloak id="friendUserStatsPanelBlinking" class="panel-group main-user-stats-sort-panel wow fadeIn" data-wow-duration="1s">
					    <div class="panel panel-default main-user-stats-sort-panel">
							<div class="panel-heading main-user-stats-sort-panel" role="tab" data-toggle="collapse" data-target="#friendUserStatsSortPanelCollapse" aria-expanded="true" aria-controls="friendUserStatsSortPanelCollapse">
								<h4 class="panel-title main-user-stats-sort-panel">
							    	Select Friend To Compare & Search Options
							    </h4>      				        
							</div>
							<div id="friendUserStatsSortPanelCollapse" class="panel-collapse collapse in" role="tabpanel">
								<div class="panel-body main-user-stats-sort-panel">																										
									<div  class="row">
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6">
											<div data-ng-hide="hideFriendUserStatsPanelFriendCombobox" data-ng-cloak id="friendUserStatsPanelFriendComboboxBlinking" class="input-group wow fadeIn" data-wow-duration="1s">
												<select class="form-control search-in-stats" data-ng-model="selectedUserFriendSteamId" data-ng-change="enableFriendStatsCompareButton(selectedUserFriendSteamId)">
													<option value="" disabled="disabled" selected="selected" hidden="hidden">Select friend to compare...</option>
												    <option data-ng-repeat="friend in friendList" value="{{ friend.steamId }}">{{ friend.personaname }}</option>
												</select>	
												<span class="input-group-btn">
													<button data-ng-click="loadFriendStatsToCompare(selectedUserFriendSteamId)" onclick="this.blur();" class="btn btn-default compare-button" id="friendStatsCompareButton" type="button" disabled>Compare</button>
												</span>						
											</div>
											<div data-ng-hide="hideFriendUserStatsPanelFailButton" data-ng-cloak>
												<span class="input-group-btn">
													<button data-ng-click="reloadFriendList()" onclick="this.blur();" class="btn btn-default fail-button" type="button">Reload friend list<i class="fas fa-sync-alt reload-icon-margin"></i></button>
												</span>
											</div>
											<div id="loading-points">
												<div data-ng-hide="hideFriendUserStatsPanelLoadingPoints" data-ng-cloak id="loading-center-points">
													<div id="loading-center-absolute-points">
														<div class="object-points" id="object_one-points"></div>
														<div class="object-points" id="object_two-points"></div>
														<div class="object-points" id="object_three-points"></div>					
													</div>
												</div>					 
											</div>																		
										</div>
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6 col-panel-search-input">
											<div class="input-group">
												<input type="text" data-ng-model="compareFriendUserStrangerProfileData" data-ng-change='changeCompareButtonState(compareFriendUserStrangerProfileData)' class="form-control search-stats" placeholder="Find user to compare by username or Steam profile URL...">
												<span class="input-group-btn">
													<button data-ng-click="loadStrangerStatsToCompare(compareFriendUserStrangerProfileData); compareFriendUserStrangerProfileData = ''" onclick="this.blur();" class="btn btn-default compare-button" id="strangerStatsCompareButton" type="button" disabled>Compare</button>
												</span>
											</div>
										</div>										
									</div>									
									<div class="row">
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-friend-stats-pane-margin-top">
											<div class="input-group">
												<input type="text" data-ng-model="searchFriendUserStatsPhrase" class="form-control search-stats" placeholder="Search for weapons...">
												<span class="input-group-btn">
													<button data-ng-click="searchFriendUserStatsPhrase = ''" onclick="this.blur();" class="btn btn-default filter-search-button" type="button">Clear</button>
												</span>
											</div>
										</div>
									</div>									
									<div class="row">
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="0" data-ng-false-value="" data-ng-model="friendUserWeaponsStatsSideFilter" name="checkbox" id="checkbox4"/>
										            <label for="checkbox4">Show TT weapons only</label>
										        </div>
									        </div>
										</div>
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="1" data-ng-false-value="" data-ng-model="friendUserWeaponsStatsSideFilter" name="checkbox" id="checkbox5"/>
										            <label for="checkbox5">Show CT weapons only</label>
										        </div>
									        </div>
										</div>
										<div class="col-sm-4 col-md-4 col-lg-4">
											<div class="custom-checkbox">
												<div class="custom-checkbox-default">
										            <input type="checkbox" data-ng-true-value="2" data-ng-false-value="" data-ng-model="friendUserWeaponsStatsSideFilter" name="checkbox" id="checkbox6"/>
										            <label for="checkbox6">Show both sides weapons only</label>
										        </div>
									        </div>
										</div>
									</div>									
								</div>
							</div>
						</div>
					</div>					
					<div data-ng-hide="hideFailFriendListDownloadingError" id="failFriendListDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<strong>Error:</strong> failed downloading friend list. Try to download friend list again by clicking 'Reload friend list<i class="fas fa-sync-alt reload-icon-error-alert"></i>' button in 'Select Friend To Compare & Search Options' panel.
					</div>					
					<div data-ng-hide="hideFailFriendStatsDownloadingError" id="failFriendStatsDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<div id="failFriendStatsDownloadingErrorAlertInner">
							<strong>Error:</strong> failed downloading selected user statistics.						
						</div>
					</div>
					<div data-ng-hide="hideFriendUserStatsGeneralLoading" data-ng-cloak>
						<div class="container">
							<div class="row loading-content-row">
								<div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
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
					<div data-ng-hide="hideFriendUserStatsGeneral" data-ng-cloak id="friendUserStatsGeneralBlinking" class="main-user-stats-general wow fadeIn" data-wow-duration="1.5s" data-wow-delay="1s">
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
											<div class="col-xs-12 col-sm-12 col-md-6 col-xl-6 col-csgostats-overall-section-outer">										
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-user-info-section-outer">
														<div class="row">
															<div class="col-xs-12 col-sm-4 col-md-6 col-lg-5 col-xl-5 col-csgostats-avatar-section-inner">
																<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">
																	<img data-ng-src="{{ mainUserStats.userInfo.avatarFullURL }}" class="img-rounded img-responsive csgostats-avatar-img">
																</a>
															</div>
															<div class="col-xs-12 col-sm-8 col-md-6 col-lg-7 col-xl-7 col-csgostats-overall-section-user-info">
																<div class="row">
																	<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																		<p class="csgostats-overall-info-formatter-center">User info</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section"></div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-5 col-sm-4 col-md-4 col-lg-4 col-xl-4 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Username:</p>
																	</div>
																	<div class="col-xs-7 col-sm-8 col-md-8 col-lg-8 col-xl-8 col-csgostats-overall-user-info-entry">																	
																		<p class="csgostats-overall-user-info-text-right">
																			<a href="http://steamcommunity.com/profiles/{{ mainUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">{{ mainUserStats.userInfo.personaname }}</a>
																		</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-4 col-sm-7 col-md-5 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">SteamID:</p>
																	</div>
																	<div class="col-xs-8 col-sm-5 col-md-7 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ mainUserStats.userInfo.steamId }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">VAC banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!mainUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of VAC bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfVACBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ mainUserStats.userBansInfo.NumberOfVACBans }}</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ mainUserStats.userBansInfo.NumberOfVACBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of game bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ mainUserStats.userBansInfo.NumberOfGameBans }}</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ mainUserStats.userBansInfo.NumberOfGameBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans == 0 && mainUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-left">Days since last ban:</p>
																		<p data-ng-if="mainUserStats.userBansInfo.NumberOfGameBans != 0 || mainUserStats.userBansInfo.NumberOfVACBans != 0" class="csgostats-overall-user-info-text-left text-red">Days since last ban:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ mainUserStats.userBansInfo.DaysSinceLastBan }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Community banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!mainUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Economy banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="mainUserStats.userBansInfo.EconomyBan != 'none'" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="mainUserStats.userBansInfo.EconomyBan == 'none'" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section-end"></div>
															</div>
														</div>
													</div>
												</div>												
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section">								
														<div class="row">
															<div class="col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																<p class="csgostats-overall-info-formatter-center">Overall user info</p>
															</div>
														</div>
														<div class="row row-csgostats-overall-section">
															<div data-ng-if="!friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value < mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-green-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value < mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-red-stats">
															</div>
															<div data-ng-if="!friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value > mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-red-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value > mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-green-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].value == mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-gray-stats">
															</div>
														</div>
														<div class="row row-csgostats-overall-entry" data-ng-repeat="overallStats in mainUserStatsOverall" data-ng-if="overallStats.value !== null">
															<div class="col-xs-2 col-sm-2 col-md-2 col-xl-2 col-csgostats-overall-stats-entry">
																<img data-ng-src="{{ overallStats.iconVariable }}" class="csgostats-overall-stats-image"></img>
															</div>
															<div class="col-xs-5 col-sm-7 col-md-7 col-xl-7 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-left">{{ overallStats.name }}</p>
															</div>
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && !overallStats.reverse && overallStats.value > friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && !overallStats.reverse && overallStats.value > friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.reverse && overallStats.value > friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.reverse && overallStats.value > friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && !overallStats.reverse && overallStats.value < friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && !overallStats.reverse && overallStats.value < friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.reverse && overallStats.value < friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.reverse && overallStats.value < friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.value == friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-gray-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.value == friendUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-gray-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && !overallStats.comparable" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && !overallStats.comparable" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>
														</div>																					
													</div>
												</div>																	
											</div>								
											<div class="col-xs-12 col-sm-12 col-md-6 col-xl-6 col-csgostats-overall-section-outer-overall-stats">	
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-user-info-section-outer">
														<div class="row">
															<div class="col-xs-12 col-sm-4 col-md-6 col-lg-5 col-xl-5 col-csgostats-avatar-section-inner">
																<a href="http://steamcommunity.com/profiles/{{ friendUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">
																	<img data-ng-src="{{ friendUserStats.userInfo.avatarFullURL }}" class="img-rounded img-responsive csgostats-avatar-img">
																</a>
															</div>
															<div class="col-xs-12 col-sm-8 col-md-6 col-lg-7 col-xl-7 col-csgostats-overall-section-user-info">
																<div class="row">
																	<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																		<p class="csgostats-overall-info-formatter-center">Friend / Stranger info</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section"></div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-5 col-sm-4 col-md-4 col-lg-4 col-xl-4 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Username:</p>
																	</div>
																	<div class="col-xs-7 col-sm-8 col-md-8 col-lg-8 col-xl-8 col-csgostats-overall-user-info-entry">																	
																		<p class="csgostats-overall-user-info-text-right">
																			<a href="http://steamcommunity.com/profiles/{{ friendUserStats.userInfo.steamId }}" onclick="this.blur();" target="_blank">{{ friendUserStats.userInfo.personaname }}</a>
																		</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-4 col-sm-7 col-md-5 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">SteamID:</p>
																	</div>
																	<div class="col-xs-8 col-sm-5 col-md-7 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ friendUserStats.userInfo.steamId }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">VAC banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!friendUserStats.userBansInfo.VACBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of VAC bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfVACBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ friendUserStats.userBansInfo.NumberOfVACBans }}</p>
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ friendUserStats.userBansInfo.NumberOfVACBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Number of game bans:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfGameBans > 0" class="csgostats-overall-user-info-text-right text-red">{{ friendUserStats.userBansInfo.NumberOfGameBans }}</p>
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfGameBans == 0" class="csgostats-overall-user-info-text-right text-green">{{ friendUserStats.userBansInfo.NumberOfGameBans }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfGameBans == 0 && friendUserStats.userBansInfo.NumberOfVACBans == 0" class="csgostats-overall-user-info-text-left">Days since last ban:</p>
																		<p data-ng-if="friendUserStats.userBansInfo.NumberOfGameBans != 0 || friendUserStats.userBansInfo.NumberOfVACBans != 0" class="csgostats-overall-user-info-text-left text-red">Days since last ban:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-right">{{ friendUserStats.userBansInfo.DaysSinceLastBan }}</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Community banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="!friendUserStats.userBansInfo.CommunityBanned" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-entry">
																	<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7 col-csgostats-overall-user-info-entry">
																		<p class="csgostats-overall-user-info-text-left">Economy banned:</p>
																	</div>
																	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5 col-csgostats-overall-user-info-entry">
																		<p data-ng-if="friendUserStats.userBansInfo.EconomyBan != 'none'" class="csgostats-overall-user-info-text-right text-red">YES</p>
																		<p data-ng-if="friendUserStats.userBansInfo.EconomyBan == 'none'" class="csgostats-overall-user-info-text-right text-green">NO</p>
																	</div>
																</div>
																<div class="row row-csgostats-overall-section-end"></div>
															</div>
														</div>
													</div>
												</div>												
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section">								
														<div class="row">
															<div class="col-sm-12 col-md-12 col-xl-12 col-csgostats-overall-section-name">
																<p class="csgostats-overall-info-formatter-center">Overall friend / stranger info</p>
															</div>
														</div>
														<div class="row row-csgostats-overall-section">
															<div data-ng-if="!friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value > mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-green-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value > mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-red-stats">
															</div>
															<div data-ng-if="!friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value < mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-red-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].reverse && friendUserStatsOverall[0].value < mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-green-stats">
															</div>
															<div data-ng-if="friendUserStatsOverall[0].value == mainUserStatsOverall[0].value" class="col-xs-offset-7 col-xs-5 col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3 col-xl-offset-9 col-xl-3 col-csgostats-overall-section-compare-stats background-color-gray-stats">
															</div>
														</div>
														<div class="row row-csgostats-overall-entry" data-ng-repeat="overallStats in friendUserStatsOverall" data-ng-if="overallStats.value !== null">
															<div class="col-xs-2 col-sm-2 col-md-2 col-xl-2 col-csgostats-overall-stats-entry">
																<img data-ng-src="{{ overallStats.iconVariable }}" class="csgostats-overall-stats-image"></img>
															</div>
															<div class="col-xs-5 col-sm-7 col-md-7 col-xl-7 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-left">{{ overallStats.name }}</p>
															</div>
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && !overallStats.reverse && overallStats.value > mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && !overallStats.reverse && overallStats.value > mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>														
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.reverse && overallStats.value > mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.reverse && overallStats.value > mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && !overallStats.reverse && overallStats.value < mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && !overallStats.reverse && overallStats.value < mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-red-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.reverse && overallStats.value < mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.reverse && overallStats.value < mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-green-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>														
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && overallStats.comparable && overallStats.value == mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-gray-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && overallStats.comparable && overallStats.value == mainUserStatsOverall[$index].value" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry background-color-gray-stats">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
															</div>															
															<div data-ng-if="!(overallStats.statsName == 'total_money_earned') && !overallStats.comparable" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}</p>
															</div>
															<div data-ng-if="overallStats.statsName == 'total_money_earned' && !overallStats.comparable" class="col-xs-5 col-sm-3 col-md-3 col-xl-3 col-csgostats-overall-stats-entry">
																<p class="csgostats-overall-stats-text-right">{{ overallStats.value.toLocaleString() }}$</p>
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
					</div>		
					<div data-ng-hide="hideFailFriendUserInventoryDownloadingWarning" id="failFriendUserInventoryDownloadingWarningAlert" data-ng-cloak class="alert alert-custom alert-warning alert-dismissible fade in wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" role="alert">
						<div id="failFriendUserInventoryDownloadingWarningAlertInner">
							<strong>Warning:</strong> failed downloading selected user inventory.
						</div>
					</div>		
					<div data-ng-hide="hideFriendUserStatsWeaponsLoading" data-ng-cloak>
						<div class="container">
							<div class="row loading-content-row">
								<div class="col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
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
					<div data-ng-hide="hideFriendUserStatsWeapons" data-ng-cloak>
						<div class="row center-block csgostats-row">
							<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-xs-12 csgostats-grid" data-ng-repeat="friendWeaponStats in mainAndFriendUserWeaponsStats | filter:{filterMarketHashName: searchFriendUserStatsPhrase, weaponSide: friendUserWeaponsStatsSideFilter}" data-ng-if="friendWeaponStats !== null">
								<div class="csgostats-grid-cell wow fadeInDown">									
									<div class="row center-block">
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-title">
											<p class="csgostats-weapon-title-formatter-center">{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.type }}</p>
										</div>
									</div>								
									<div class="row center-block">
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6">								
											<div class="row">										
												<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.souvenir" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}, 0.4) 0%,rgba({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(255, 215, 0, 0.8) 95%,rgba(255, 215, 0, 0.8) 100%);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, true) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>
												<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.statTrak" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}, 0.4) 0%,rgba({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(207, 106, 50, 0.8) 95%,rgba(207, 106, 50, 0.8) 100%);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, true) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>
												<div data-ng-if="!friendWeaponStats.mainUserWeaponSkin.weaponSkin.souvenir && !friendWeaponStats.mainUserWeaponSkin.weaponSkin.statTrak" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}); background: rgba({{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.color }}, 0.4);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, false) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>																						
											</div>
											<div class="row">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-compare-image-background">
													<div class="csgostats-weapon-image">
														<img data-ng-src="{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.iconUrl }}" class="img-responsive full-width">	
													</div>
												</div>																					
											</div>
											<div class="row">
												<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-left">
													<a href="http://steamcommunity.com/market/listings/730/{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.marketHashName }}" target="_blank">
														<button data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.price != 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: {{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.price }}$</button>
														<button data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.price == 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: N/A</button>
													</a>								
												</div>
												<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-right">
													<a href="{{ friendWeaponStats.mainUserWeaponSkin.weaponSkin.inspectInGame }}">
														<button class="btn csgostats-inspect-button" type="button" onclick="this.blur();">Inspect in-game</button>		
													</a>
												</div>												
											</div>								
										</div>
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6">
											<div class="row">
												<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.souvenir" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}, 0.4) 0%,rgba({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(255, 215, 0, 0.8) 95%,rgba(255, 215, 0, 0.8) 100%);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, true) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>
												<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.statTrak" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}); background: linear-gradient(to bottom, rgba({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}, 0.4) 0%,rgba({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}, 0.4) 95%,#000000 95%,rgba(207, 106, 50, 0.8) 95%,rgba(207, 106, 50, 0.8) 100%);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, true) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>
												<div data-ng-if="!friendWeaponStats.friendUserWeaponSkin.weaponSkin.souvenir && !friendWeaponStats.friendUserWeaponSkin.weaponSkin.statTrak" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-name" style="background: rgb({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}); background: rgba({{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.color }}, 0.4);">
													<div data-ng-if="measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" data-ng-bind-html="splitMarketHashName(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, false) | unsafe"></div>								
													<p data-ng-if="!measureTextLengthInPixels(friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName, '13px Roboto Condensed Regular', 190)" class="csgostats-weapon-name-formatter-center">{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName }}</p>
												</div>
											</div>
											<div class="row">
												<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-compare-image-background-right">
													<div class="csgostats-weapon-image">
														<img data-ng-src="{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.iconUrl }}" class="img-responsive full-width">	
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-left">
													<a href="http://steamcommunity.com/market/listings/730/{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.marketHashName }}" target="_blank">
														<button data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.price != 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: {{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.price }}$</button>
														<button data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.price == 0" class="btn csgostats-price-button" type="button" onclick="this.blur();">Price: N/A</button>
													</a>									
												</div>
												<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 csgostats-grid-padding-right">
													<a href="{{ friendWeaponStats.friendUserWeaponSkin.weaponSkin.inspectInGame }}">
														<button class="btn csgostats-inspect-button" type="button" onclick="this.blur();">Inspect in-game</button>		
													</a>
												</div>
											</div>
										</div>
									</div>																
									<div class="row center-block">
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 col-csgostats-grid-weapon-stats-title">
											<p class="csgostats-weapon-title-formatter-center">Weapon Stats</p>
										</div>
									</div>
									<div class="row center-block">
									    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-6">
									         <p class="modal-text-formatter-left p-games-list">Total kills:</p>				         
										</div>
									    <div data-ng-if="friendWeaponStats.mainUserWeaponSkin.totalKills > friendWeaponStats.friendUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>					          
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.totalKills < friendWeaponStats.friendUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>	
									    </div>
									    <div data-ng-if="friendWeaponStats.mainUserWeaponSkin.totalKills == friendWeaponStats.friendUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>	
									    </div>
									    <div data-ng-if="friendWeaponStats.friendUserWeaponSkin.totalKills > friendWeaponStats.mainUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>																             
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.totalKills < friendWeaponStats.mainUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.totalKills == friendWeaponStats.mainUserWeaponSkin.totalKills" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.totalKills.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
									</div>	
									<div class="row center-block">
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-6">
											<p class="modal-text-formatter-left p-games-list">Total shots:</p>
										</div>
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.totalShots.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'"class="modal-text-formatter p-games-list">N/A</p>
										</div>
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.totalShots.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'"class="modal-text-formatter p-games-list">N/A</p>
										</div>
									</div>
									<div class="row center-block">
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-6">
											<p class="modal-text-formatter-left p-games-list">Total hits:</p>
										</div>										
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.totalHits.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.totalHits.toLocaleString() }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
									</div>
									<div class="row center-block">
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-6">
											<p class="modal-text-formatter-left p-games-list">Accuracy:</p>
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.accuracy > friendWeaponStats.friendUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>					
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.accuracy < friendWeaponStats.friendUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>		
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.accuracy == friendWeaponStats.friendUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.accuracy > friendWeaponStats.mainUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>							
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.accuracy < friendWeaponStats.mainUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.accuracy == friendWeaponStats.mainUserWeaponSkin.accuracy" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.accuracy }}%</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>	
										</div>
									</div>
									<div class="row center-block">
										<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-6">
											<p class="modal-text-formatter-left p-games-list">Shots per kill:</p>
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.shotsPerKill < friendWeaponStats.friendUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>    								
										</div>
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.shotsPerKill > friendWeaponStats.friendUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>   
										</div>	
										<div data-ng-if="friendWeaponStats.mainUserWeaponSkin.shotsPerKill == friendWeaponStats.friendUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.mainUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.mainUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.mainUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>   
										</div>						
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.shotsPerKill < friendWeaponStats.mainUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-green-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>  		
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.shotsPerKill > friendWeaponStats.mainUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-red-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>  
										</div>
										<div data-ng-if="friendWeaponStats.friendUserWeaponSkin.shotsPerKill == friendWeaponStats.mainUserWeaponSkin.shotsPerKill" data-ng-class="{true: 'background-color-gray-stats'}[friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov']" class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-3">
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Gloves' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Knife' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'High Explosive Grenade' && friendWeaponStats.friendUserWeaponSkin.weaponSkin.type != 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">{{ friendWeaponStats.friendUserWeaponSkin.shotsPerKill }}</p>
											<p data-ng-if="friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Gloves' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Knife' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'High Explosive Grenade' || friendWeaponStats.friendUserWeaponSkin.weaponSkin.type == 'Incendiary Grenade / Molotov'" class="modal-text-formatter p-games-list">N/A</p>  
										</div>
									</div>																			
								</div>
							</div>
						</div>
					</div>					
				</div>
			</div>	
		</div>	
		<footer data-ng-hide="hideFooter" data-ng-cloak class="text-center main-user-footer wow fadeIn" data-wow-duration="2s" data-wow-delay="1s" id="footerMainUserStatsCompare">
		   <div class="footer-above">
		      <div class="container">
		         <div class="row">
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
		               <h3 class="footer-above-font header">Web Creator</h3>
		               <p class="footer-above-font font">Jakub Podgórski</p>
		            </div>
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
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
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
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
		<footer data-ng-hide="hideFooterCompare" data-ng-cloak class="text-center friend-user-footer wow fadeIn" data-wow-duration="1s" id="footerFriendStatsCompare">
			<div class="footer-above">
		      <div class="container">
		         <div class="row">
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
		               <h3 class="footer-above-font header">Web Creator</h3>
		               <p class="footer-above-font font">Jakub Podgórski</p>
		            </div>
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
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
		            <div class="footer-col col-xs-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
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