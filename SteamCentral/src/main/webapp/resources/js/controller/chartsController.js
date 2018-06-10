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
	 * Set chart parameters to display
	 */
	$scope.setChart = function(chartData, title, xAxisText, yAxisText, legendPointName) {
		
		/*(function (H) {
	        H.wrap(H.Chart.prototype, 'showResetZoom', function (proceed) {
	            proceed.apply(this, [].slice.call(arguments, 1));

	            var chart = this,
	                btn = this.resetZoomButton,
	                rect = btn.box.element.attributes;
	            
	            //btn.theme.title = 'kutas';
	            chart.renderer.image(
	                'http://highcharts.com/demo/gfx/sun.png',
	                -4, 0, 30, 30)
	                .add(btn);
	            $.each(rect, function (i, a) {
	                if (a.name == 'width') {
	                    a.value = "30";
	                } else if (a.name == 'height') {
	                    a.value = "30";
	                }
	            });
	        });
	    }(Highcharts));*/
		
		Highcharts.chart('chartContainer', {
            chart: {
            	backgroundColor: 'rgba(255, 255, 255, 0)',
                zoomType: 'xy',                
                resetZoomButton: {
	                position: {
		                align: "right",
		                verticalAlign: "top",
		                x: 0,
		                y: -50
	                },
	                theme: {
	                	title: '',        
	                    r: 2
	                }
                }
            },
            title: {
                text: title,
                style: { "color": "#FFFFFF", "fontSize": "24px", "fontFamily": "Oswald ExtraLight", "fontWeight": "bold"}
            },
            subtitle: {
                text: 'Pinch the chart to zoom in',
                style: { "color": "#e6e6e6", "fontSize": "14px", "fontFamily": "Oswald ExtraLight" }
            },
            xAxis: {
                type: xAxisText,
                dateTimeLabelFormats: {
                    millisecond: '%H:%M:%S.%L',
                    second: '%H:%M:%S',
                    minute: '%H:%M',
                    hour: '%H:%M',
                    day: '%e. %b',
                    /*day: '%e/%m',*/
                    week: '%e. %b',
                    month: '%b \'%y',
                    year: '%Y'
                },
                labels: {
                	style: {
                		fontSize: '12px',
                		fontFamily: 'Oswald ExtraLight',
                		color: '#e6e6e6'
                	}
                }
            },
            yAxis: {
                title: {
                    text: yAxisText,
                    style: {
                    	fontSize: '20px',
                		fontFamily: 'Oswald ExtraLight',
                		color: '#f2f2f2'
                    }
                },
                dateTimeLabelFormats: {
                    millisecond: '%H:%M:%S.%L',
                    second: '%H:%M:%S',
                    minute: '%H:%M',
                    hour: '%H:%M',
                    day: '%e. %b',
                    /*day: '%e/%m',*/
                    week: '%e. %b',
                    month: '%b \'%y',
                    year: '%Y'
                },
                labels: {
                	style: {
                		fontSize: '11px',
                		fontFamily: 'Oswald ExtraLight',
                		fontWeight: 'bold',
                		color: '#e6e6e6'
                	}
                },
                alternateGridColor: 'rgba(255, 255, 255, 0.03)'
            },
            legend: {
                enabled: true,
                itemStyle: {
                	fontFamily: 'Oswald ExtraLight',
                	fontSize: '14px',
                	fontWeight: 'normal',
                	color: '#f2f2f2',
                	cursor: 'default'
                },
                itemHoverStyle: {
                	color: '#f2f2f2'
                }/*,
                symbolHeight: 10*/
            },
            plotOptions: {
                area: {
                	color: '#1ebbbb',
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, Highcharts.getOptions().colors[5]], // 5
                            [1, Highcharts.Color(Highcharts.getOptions().colors[5]).setOpacity(0).get('rgba')]
                        ]
                    },
                    marker: {
                        radius: 4
                    },
                    lineWidth: 2,
                    states: {
                        hover: {
                            lineWidth: 3
                        }
                    },
                    threshold: null
                },
                series: {
                    events: {
                        legendItemClick: function () {
                            return false;
                        }
                    }
                }
            },
            credits: {
            	enabled: false
            },
            time: {
            	timezone: 'Europe/Warsaw',
            	useUTC: true
            },
            data: {
            	/*parseDate: 'tutaj funkcja, ktora zwraca: A callback function to parse string representations of dates into JavaScript timestamps. Should return an integer timestamp on success.'*/
            },
            exporting: {
            	buttons: {
            		
            	},
            	showTable: true
            },
            series: [{
                type: 'area',
                name: legendPointName,
                cursor: 'pointer',
                animation: {
                	duration: 1000
                },
                boostThreshold: 0,
                /*color: 'green',*/
                tooltip: {
                	dateTimeLabelFormats: {
                		millisecond:"%A, %b %e, %H:%M:%S.%L",
                	    second:"%A, %b %e, %H:%M:%S",
                	    minute:"%A, %b %e, %H:%M",
                	    hour:"%A, %b %e, %H:%M",
                	    day:"%A, %e/%m/%Y",
                	    week:"Week from %A, %b %e, %Y",
                	    month:"%B %Y",
                	    year:"%Y"
                	},
                	headerFormat: '<span style="font-size: 13px; font-family: Oswald ExtraLight;">{point.key}</span><br/>',
                	pointFormat: '<span style="color:{point.color}; font-size: 18px;">\u25CF</span> <span style="font-size: 13px; font-family: Oswald ExtraLight"> {series.name}: </span><span style="font-size: 13px; font-family: Oswald ExtraLight; font-weight: bold;">{point.y}</span><br/>'
                },
                data: chartData
            }],
            lang: {
                noData: 'There is no available statistics data gathered for your profile yet'
            },
            noData: {
                style: {
                	fontFamily: 'Oswald ExtraLight',
                	fontSize: '16px',
                	fontWeight: 'normal',
                	color: '#e6e6e6'
                }
            }
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
				
				// template check
				
				$http.get('https://cdn.rawgit.com/highcharts/highcharts/057b672172ccc6c08fe7dbb27fc17ebca3f5b770/samples/data/usdeur.json')
				.then(function(response) {
					if(response.data != "" && response.data != null) {
						
						var shortArray = new Array();
						
						for(var i=5; i<35; i++) {
							shortArray.push(response.data[i]);
						}
						
						$scope.setChart(shortArray, 'USD to EUR exchange rate over time', 'datetime', 'Exchange rate', 'USD to EUR');
							
					} else {				
						throw "chart test failed.";
					}
				})
				.catch(function(error) {
					console.log('error: ' + error);
				});
				
				// end of template check
				
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