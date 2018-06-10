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
		<spring:url value="/resources/css/app-css/charts-view.css" var="chartsViewCss" />
		<spring:url value="/resources/css/fontawesome-all.min.css" var="fontawesomeCss" />
		<spring:url value="/resources/css/animate.min.css" var="animateCss" />
		
		<link href="${bootstrapCss}" rel="stylesheet" />	
		<link href="${navbarCss}" rel="stylesheet" />
		<link href="${chartsViewCss}" rel="stylesheet" />
		<link href="${fontawesomeCss}" type="text/css" rel="stylesheet" />
		<link href="${animateCss}" rel="stylesheet" />
		
		<spring:url value="/resources/media/steamcentralicon_large.png" var="steamcentral_iconPng" />	
	</head>
	<body data-ng-app="chartsController" data-ng-controller="chartsCtrl" class="no-js" id="removeBlinking">
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
	            	<ul class="nav navbar-nav navbar-left">
	                    <li>
		                    <a class="page-scroll" href="#statistics">
		  						<button onclick="location.href='/SteamCentral/'" class="btn btn-inverse-left dropdown-toggle" type="button" onclick="this.blur();">Statistics</button>
							</a>
						</li>
	                </ul>
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
		<div class="charts-stats">
			<div class="charts-stats-inner">		
				<div class="container charts-stats-container">				
					<div class="row">
			            <div class="col-sm-12 col-md-12 col-lg-12">
			                <h1 class="page-header page-header-stats wow fadeInDown" data-wow-duration="2s">CS:GO Statistics Charts<small class="page-header-small-padding-left">With in-depth analysis</small>
			                </h1>
			            </div>
			        </div>
			        <div data-ng-hide="hideChartsPanelLoading" data-ng-cloak>
						<div class="container">
							<div class="row loading-content-row-smaller">
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
					<div data-ng-hide="hideChartsPanel" data-ng-cloak class="panel-group charts-stats-sort-panel wow fadeIn" data-wow-duration="2s" data-wow-delay="1s">					    
					    <div class="panel panel-default charts-stats-sort-panel">
							<div class="panel-heading charts-stats-sort-panel" role="tab" data-toggle="collapse" data-target="#chartsStatsSortPanelCollapse" aria-expanded="true" aria-controls="chartsStatsSortPanelCollapse">
								<h4 class="panel-title charts-stats-sort-panel">
							    	Data selection for the axis of the chart
							    </h4>      				        
							</div>
							<div id="chartsStatsSortPanelCollapse" class="panel-collapse collapse in" role="tabpanel">
								<div class="panel-body charts-stats-sort-panel">
									<div class="row">
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 combobox-calculated-data">
											<div class="input-group">
										      	<span class="input-group-addon addon-format">Calculated data</span>
												<select class="form-control search-in-stats" data-ng-model="selectedItemChartsStatsCalculatedData" data-ng-change="">
													<option value="" disabled="disabled" selected="selected" hidden="hidden">Select calculated data...</option>
													<option data-ng-repeat="friend in friendList" value="{{ friend.steamId }}">{{ friend.personaname }}</option>
												</select>
											</div>
										</div>
									</div>								
									<div class="row">
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6 combobox-axis-x">
										    <div class="input-group">
										      	<span class="input-group-addon addon-format">Axis X</span>
										      	<select class="form-control search-in-stats" data-ng-model="selectedItemChartsStatsAxisX" data-ng-change="">
													<option value="" disabled="disabled" selected="selected" hidden="hidden">Select data for axis X...</option>
													<option data-ng-repeat="friend in friendList" value="{{ friend.steamId }}">{{ friend.personaname }}</option>
												</select>
										    </div> 
										</div>
										<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6">
											<div class="input-group">
										      	<span class="input-group-addon addon-format">Axis Y</span>
										      	<select class="form-control search-in-stats" data-ng-model="selectedItemChartsStatsAxisY" data-ng-change="">
													<option value="" disabled="disabled" selected="selected" hidden="hidden">Select data for axis Y...</option>
													<option data-ng-repeat="friend in friendList" value="{{ friend.steamId }}">{{ friend.personaname }}</option>
												</select>
										    </div>
										</div>
									</div>       	        			        	
								</div>
							</div>							      
						</div>     
					</div>					
					<div class="row" >
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
							<div id="chartContainer" class="chart-container-main-settings"></div>
						</div>
						<!-- <p style="font-size: 10px; color: white;">{{ userStats }}</p> -->
					</div>
				</div>
			</div>
		</div>
		<footer class="text-center main-user-footer wow fadeIn" data-wow-duration="2s" data-wow-delay="1s">
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
		<spring:url value="/resources/js/highcharts.js" var="highchartsJs" />	
		<spring:url value="/resources/js/no-data-to-display.js" var="highchartsNoDataJs" />			
		<spring:url value="/resources/js/export-data.js" var="highchartsExportDataJs" />	
		<spring:url value="/resources/js/exporting.js" var="highchartsExportingJs" />			
		<spring:url value="/resources/js/moment-with-locales.min.js" var="momentWithLocalesJs" />	
		<spring:url value="/resources/js/moment-timezone-with-data.min.js" var="momentTimezoneJs" />	
		<spring:url value="/resources/js/controller/chartsController.js" var="chartsControllerJs" />
		<spring:url value="/resources/js/bootstrap.js" var="bootstrapJs" />
		<spring:url value="/resources/js/jquery.easing.min.js" var="jqueryeasingminJs" />
		<spring:url value="/resources/js/wow.min.js" var="wowJs" />
		<spring:url value="/resources/js/common.js" var="commonJs" />
		
		<script src="${jqueryJs}"></script>		
		<script src="${angularJs}"></script>	
		<script src="${highchartsJs}"></script>
		<script src="${highchartsNoDataJs}"></script>
		<script src="${highchartsExportDataJs}"></script>
		<script src="${highchartsExportingJs}"></script>		
		<script src="${momentWithLocalesJs}"></script>
		<script src="${momentTimezoneJs}"></script>
		<script src="${chartsControllerJs}"></script>
		<script src="${bootstrapJs}"></script>
		<script src="${jqueryeasingminJs}"></script>
		<script src="${wowJs}"></script>
		<script src="${commonJs}"></script>
		
	</body>
</html>