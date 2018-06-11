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
	 * Draw the table with the selected data
	 */
	$scope.drawDataTable = function(data, title, leftColTitle, rightColTitle) {
		document.getElementById("tableContainer").style["margin-top"] = "50px";
				
		var table = document.createElement("table");
		table.setAttribute("id", "dataTable");	    
	    
	    var caption = document.createElement("caption");
	    caption.setAttribute("class", "highcharts-table-caption");	    
	    var captionTitle = document.createTextNode(title);
	    caption.appendChild(captionTitle);	    
	    table.appendChild(caption);
	    
	    var tableHead = document.createElement("thead");
	    var tableR = document.createElement("tr");
	    tableHead.appendChild(tableR);
	    
	    var tableHLeft = document.createElement("th");
	    tableHLeft.setAttribute("class", "text");
	    tableHLeft.setAttribute("scope", "col");
	    var tableHLeftTitle = document.createTextNode(leftColTitle);
	    tableHLeft.appendChild(tableHLeftTitle);	
	    
	    var tableHRight = document.createElement("th");
	    tableHRight.setAttribute("class", "text");
	    tableHRight.setAttribute("scope", "col");
	    var tableHRightTitle = document.createTextNode(rightColTitle);
	    tableHRight.appendChild(tableHRightTitle);
	    
	    tableR.appendChild(tableHLeft);
	    tableR.appendChild(tableHRight);	    
	    table.appendChild(tableHead);
	    
	    var tableBody = document.createElement("tbody");
	    var options = { weekday: 'long', year: 'numeric', month: 'numeric', day: 'numeric' };
	    
	    for(var i=0; i<data.length; i++) {
	    	var tableRElement = document.createElement("tr");
	    	
	    	var tableHElement = document.createElement("th");
	    	tableHElement.setAttribute("class", "text");
	    	tableHElement.setAttribute("scope", "row");
	    	var tableHElementData = document.createTextNode(new Date(data[i][0]).toLocaleDateString("en-GB", options));
	    	tableHElement.appendChild(tableHElementData);
	    	
	    	var tableDElement = document.createElement("td");
	    	tableDElement.setAttribute("class", "number");
	    	var tableDElementData = document.createTextNode(data[i][1]);
	    	tableDElement.appendChild(tableDElementData);
	    	
	    	tableRElement.appendChild(tableHElement);
	    	tableRElement.appendChild(tableDElement);
	    	tableBody.appendChild(tableRElement);
	    }
	    
	    table.appendChild(tableBody);
	    document.getElementById('tableContainer').appendChild(table);
	};
	
	/*
	 * Set chart parameters to display
	 */
	$scope.setChart = function(chartData, title, xAxisText, yAxisText, legendPointName) {
		Highcharts.chart('chartContainer', {
            chart: {
            	backgroundColor: 'rgba(255, 255, 255, 0)',
                zoomType: 'xy', 
                pinchType: 'xy',
                resetZoomButton: {
	                position: {
		                align: "right",
		                verticalAlign: "top"
	                },
	                theme: {
	                	title: '',        
	                    r: 2,
	                    height: 13
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
                    /*day: '%e. %b',*/
                    day: '%e/%m',
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
                    /*day: '%e. %b',*/
                    day: '%e/%m',
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
                }
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
                            [0, Highcharts.getOptions().colors[5]],
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
            	/*timezone: 'Europe/Warsaw', When this option is enabled points on a chart are not following formatting rules*/
            	useUTC: true
            },
            data: {
            	/*parseDate: 'tutaj funkcja, ktora zwraca: A callback function to parse string representations of dates into JavaScript timestamps. Should return an integer timestamp on success.'*/
            },
            exporting: {
            	buttons: {
            		contextButton: {
            			symbol: "menu",
            			symbolStroke: "#FFFFFF",
            			y: 0,
            			menuItems: [
            				'downloadPNG',
            				'downloadJPEG',
            				'downloadSVG',
            				{
                            	textKey: 'downloadXLS',
                                onclick: function () {
                                    this.downloadXLS();
                                }
                            }, 
                            {
                                textKey: 'downloadCSV',
                                onclick: function () {
                                    this.downloadCSV();
                                }
                            }
            			],
            			theme: {
            				fill: "rgba(255, 255, 255, 0)",
            				states: {
        	                	hover: {
        	                        fill: "rgba(255, 255, 255, 0)"
        	                    },
        	                    select: {
        	                        fill: "rgba(255, 255, 255, 0.4)"
        	                    }
            				 }
            			}
            		}
            	},
            	filename: 'SteamCentralChart_' + title.replace(/ /g, '_'),
            	printMaxWidth: 1920,
            	scale: 1,
            	showTable: false /* conflicts with data exporting javascript files */
            },
            series: [{
                type: 'area',
                name: legendPointName,
                cursor: 'pointer',
                animation: {
                	duration: 1000
                },
                boostThreshold: 0,
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
                noData: 'There is no available statistics data gathered for your profile yet',
                contextButtonTitle: '',
                downloadPNG: 'Download PNG',
                downloadJPEG: 'Download JPEG',
                downloadSVG: 'Download SVG',
                downloadCSV: 'Download CSV',
                downloadXLS: 'Download XLS'
            },
            navigation: {
                menuStyle: {
                	boxShadow: null
                },
                menuItemStyle: {
                	paddingLeft: '20px',
                	paddingRight: '20px',
                    fontSize: '12px',
                    fontFamily: 'Oswald ExtraLight',
                    color: '#4f4f4f'
                },
                menuItemHoverStyle: {
                    background: '#a6a6a6',
                    color: '#ffffff',
                    transition: 'all 0.3s ease-in-out'
                },
                buttonOptions: {
                	fontFamily: 'Oswald ExtraLight',
                	theme: {
                		fontFamily: 'Oswald ExtraLight'
                    }
                }
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
						
						if(shortArray != "" && shortArray != null) {
							var elementToRemove = document.getElementById("dataTable");
							
							if(elementToRemove != null) {
								elementToRemove.remove();
							}
							
							$scope.drawDataTable(shortArray, 'USD to EUR exchange rate over time', 'DateTime', 'USD to EUR');
						}
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