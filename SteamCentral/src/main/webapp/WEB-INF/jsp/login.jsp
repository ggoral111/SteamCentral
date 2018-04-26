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
		<spring:url value="/resources/css/app-css/login-view.css" var="loginViewCss" />
		<spring:url value="/resources/css/fontawesome-all.min.css" var="fontawesomeCss" />
		<spring:url value="/resources/css/animate.min.css" var="animateCss" />
		
		<link href="${bootstrapCss}" rel="stylesheet" />		
		<link href="${navbarCss}" rel="stylesheet" />
		<link href="${loginViewCss}" rel="stylesheet" />
		<link href="${fontawesomeCss}" type="text/css" rel="stylesheet" />
		<link href="${animateCss}" rel="stylesheet" />
		
		<spring:url value="/resources/media/steamcentralicon_large.png" var="steamcentral_iconPng" />
		<spring:url value="/resources/media/steamwhiteicon.png" var="steamwhiteiconPng" />
	</head>
	<body data-ng-app="loginController" data-ng-controller="loginCtrl" class="no-js" id="removeBlinking">
	
		<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
	        <div class="container">
	            <div class="navbar-header">
	                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
	                	<i class="fa fa-bars fa-2x"></i>
	                </button>
	                <a class="navbar-nonbrand page-scroll" href="#login" onclick="this.blur();">
	                    <img src="${steamcentral_iconPng}" width="40" height="40"></img>
	                    <span class="light">SteamCentral</span>
	                </a>
	            </div>           
	            <div class="collapse navbar-collapse navbar-main-collapse">
	                <ul class="nav navbar-nav navbar-right">
	                    <li>
		                    <a class="page-scroll" href="#login">
		  						<button class="btn btn-inverse-left dropdown-toggle" type="button" onclick="this.blur();">Login</button>
							</a>
						</li>
						<li>
							<a class="page-scroll" href="#about">
		  						<button class="btn btn-inverse-left dropdown-toggle" type="button" onclick="this.blur();">About</button>
							</a>
						</li>
	                </ul>
	            </div>
	        </div>
	    </nav>
	    
		<header id="login" class="intro">
		   <div class="intro-body">
		      <div class="container">
		         <div class="row intro-body-row" id="loginRow">
		            <div class="col-md-8 col-md-offset-2">
		               <p class="intro-text wow fadeInDown" data-wow-duration="2s">Discover new features.</p>
		               <h1 class="brand-heading wow fadeIn" data-wow-duration="3s" data-wow-delay="1.5s">Welcome to SteamCentral</h1>
		               <button id="singInThroughSteam" class="btn btn-xl wow fadeIn" data-wow-duration="3s" data-wow-delay="2s" onclick="this.blur();">
		                  <img class="header-button-img sign-steam" src="${steamwhiteiconPng}"/>Sign in through STEAM
		               </button>
		               <br>
		               <a href="#about" class="btn btn-circle page-scroll wow fadeIn" data-wow-duration="3s" data-wow-delay="2s" onclick="this.blur();">                       
		               		<i class="fa fa-angle-double-down animated"></i>
		               </a>
		            </div>
		         </div>
		      </div>
		   </div>
		</header>
		
		<section id="about" class="service-item">
		   <div class="container">
		      <div class="center text-center">
		         <img class="img-steam-central-icon img-steam" src="${steamcentral_iconPng}" alt="">           
		      </div>
		      <div class="center wow fadeInDown text-center">
		         <h2 class="header-section header">About SteamCentral</h2>
		         <p class="header-section text">You still not gonna believe how easy can be inspecting your Counter Strike: Global Offensive stats without putting much effort in it. SteamCentral is made for quick and easy inspecting all crucial aspects of your gameplay and every single weapon type stats comparison. Are you worse than your worst enemy? Improve youself and delete him. Are you still not convinced? Just log in and try it! This is absolutely free.</p>
		      </div>
		      <div class="row section-row">
		         <div class="col-md-4">
		            <div class="media about-wrap wow fadeInDown">
		               <div class="pull-left">		                  
		               		<i class="fas fa-5x fa-chart-area" aria-hidden="true"></i>
		               </div>
		               <div class="media-body">
		                  <h6 class="media-heading title">CS:GO Stats</h6>
		                  <p class="media-heading text">Do you seriously think that you know everything about your skill? Login and fetch your CS:GO stats after every gameplay and see how you improved or lowered your skill over a last month.</p>
		               </div>
		            </div>
		         </div>
		         <div class="col-md-4">
		            <div class="media about-wrap wow fadeInDown">
		               <div class="pull-left">
		               		<i class="fa fa-5x fa-users" aria-hidden="true"></i>		                  
		               </div>
		               <div class="media-body">
		                  <h6 class="media-heading title">Friends</h6>
		                  <p class="media-heading text">Compare your Counter Strike: Global Offensive stats with other players. Find out in which aspects you are better than the others or in which you still need to improve.</p>
		               </div>
		            </div>
		         </div>
		         <div class="col-md-4">
		            <div class="media about-wrap wow fadeInDown">
		               <div class="pull-left">
		               		<i class="far fa-5x fa-gem" aria-hidden="true"></i>
		               </div>
		               <div class="media-body">
		                  <h6 class="media-heading title">Inventory</h6>
		                  <p class="media-heading text">Quickly inspect your highest value skins which corresponds to a specific gun type. Compare your stats with other users and see who is owning higher price tier items!</p>
		               </div>
		            </div>
		         </div>
		      </div>
		   </div>
		</section>
		
		<footer class="text-center">
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
		<spring:url value="/resources/js/controller/loginController.js" var="loginControllerJs" />
		<spring:url value="/resources/js/bootstrap.js" var="bootstrapJs" />
		<spring:url value="/resources/js/jquery.easing.min.js" var="jqueryeasingminJs" />
		<spring:url value="/resources/js/wow.min.js" var="wowJs" />
		<spring:url value="/resources/js/common.js" var="commonJs" />
		
		<script src="${jqueryJs}"></script>		
		<script src="${angularJs}"></script>
		<script src="${loginControllerJs}"></script>
		<script src="${bootstrapJs}"></script>
		<script src="${jqueryeasingminJs}"></script>
		<script src="${wowJs}"></script>
		<script src="${commonJs}"></script>
		
	</body>
</html>