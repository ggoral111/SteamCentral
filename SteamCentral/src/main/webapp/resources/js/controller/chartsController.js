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
	$scope.statsNameList = null;
	$scope.tableCaptionTitle = null;
	$scope.tableLeftColTitle = null;
	$scope.tableRightColTitle = null;
	$scope.tableData = null;
	
	$scope.hideChartsPanelLoading = false;
	$scope.hideChartsPanel = true;
	$scope.hideDataTable = true;
	$scope.hideFooter = true;
	
	$scope.hideSetAllRequiredOptionsWarningAlert = true;
	$scope.hideFailStatsDownloadingError = true;
	
	$scope.calculatedData = [
		{
			name: 'Accuracy (%) [Daily]',
			value: ['total_shots_hit', 'total_shots_fired'],
			total: false
		},
		{
			name: 'Accuracy (%) [Total]',
			value: ['total_shots_hit', 'total_shots_fired'],
			total: true
		},
		{
			name: 'Average Damage per Round (ADR) [Daily]',
			value: ['total_damage_done', 'total_rounds_played'],
			total: false
		},
		{
			name: 'Average Damage per Round (ADR) [Total]',
			value: ['total_damage_done', 'total_rounds_played'],
			total: true
		},
		{
			name: 'Kill Death Ratio (KDR) [Daily]',
			value: ['total_kills', 'total_deaths'],
			total: false
		},
		{
			name: 'Kill Death Ratio (KDR) [Total]',
			value: ['total_kills', 'total_deaths'],
			total: true
		},
		{
			name: 'MVP / Payed Rounds Ratio [Daily]',
			value: ['total_mvps', 'total_rounds_played'],
			total: false
		},
		{
			name: 'MVP / Payed Rounds Ratio [Total]',
			value: ['total_mvps', 'total_rounds_played'],
			total: true
		},
		{
			name: 'Shots per Kill [Daily]',
			value: ['total_shots_hit', 'total_kills'],
			total: false
		},
		{
			name: 'Shots per Kill [Total]',
			value: ['total_shots_hit', 'total_kills'],
			total: true
		}
	];
	
	$scope.statsNameReplacements = [
		{
			containedString: 'hkp2000',
			replacement: 'USP-S / P2000'
		},
		{
			containedString: 'elite',
			replacement: 'Dual Berettas'
		},
		{
			containedString: 'deagle',
			replacement: 'Desert Eagle / R8 Revolver'
		},
		{
			containedString: 'galilar',
			replacement: 'Galil AR'
		},
		{
			containedString: 'm4a1',
			replacement: 'M4A1-S / M4A4'
		},
		{
			containedString: 'sg556',
			replacement: 'SG 553'
		},
		{
			containedString: 'fiveseven',
			replacement: 'Five-SeveN / CZ75-Auto'
		},
		{
			containedString: 'tec9',
			replacement: 'Tec-9 / CZ75-Auto'
		}
	];
	
	/*
	 * Replace failStatsDownloadingErrorAlert alert
	 */
	$scope.replaceFailStatsDownloadingErrorAlert = function() {
		$("#failStatsDownloadingErrorAlert").remove();
		var $textElement = $('<div data-ng-hide="hideFailStatsDownloadingError" id="failStatsDownloadingErrorAlert" data-ng-cloak class="alert alert-custom alert-danger alert-dismissible fade in wow fadeIn" data-wow-duration="1s" role="alert"><strong>Error:</strong> failed downloading statistics from server. <a class="error-alert" data-ng-click="loadUserStats()" onclick="this.blur();">Click here<i class="fas fa-sync-alt reload-icon-error-alert"></i></a> to try to download your statistics again.</div>').appendTo("#failStatsDownloadingErrorAlertOuter");
		$compile($textElement)($scope);
	};
	
	/*
	 * Replace setAllRequiredOptionsWarningAlert alert
	 */
	$scope.replaceSetAllRequiredOptionsWarningAlert = function(warningValues) {
		$("#setAllRequiredOptionsWarningAlert").remove();
		var $textElement = $("<div data-ng-hide='hideSetAllRequiredOptionsWarningAlert' id='setAllRequiredOptionsWarningAlert' data-ng-cloak class='alert alert-custom alert-warning alert-dismissible fade in wow fadeIn' data-wow-duration='1s' role='alert'><strong>Warning:</strong> " + warningValues + " not filled properly. Please select all required values from drop-down lists and try again by clicking 'Create chart <i class='fas fa-chart-line reload-icon-warning-alert'></i>' button.<button type='button' class='close' data-dismiss='alert' aria-label='Close' onclick='this.blur();'><span aria-hidden='true'>&times;</span></button></div>").appendTo("#setAllRequiredOptionsWarningAlertOuter");				
		$compile($textElement)($scope);
	};
	
	/*
	 * Create list of available stats for drop-down lists
	 */
	$scope.createListOfStats = function(statsList) {
		var statsListArray = new Array();
		
		for(var i=0; i<statsList.length; i++) {
			if(!statsList[i].name.includes('GI.lesson')) {			
				var statsItem = {};
				var tempName = statsList[i].name;
				
				for(var j=0;j<$scope.statsNameReplacements.length; j++) {
					if(statsList[i].name.includes($scope.statsNameReplacements[j].containedString)) {
						tempName = statsList[i].name.replace($scope.statsNameReplacements[j].containedString, $scope.statsNameReplacements[j].replacement);
						break;
					}
				}
				
				statsItem['name'] = $scope.createReadableTextFromStringOfChars(tempName);
				statsItem['value'] = statsList[i].name;	
				statsListArray.push(statsItem);
			}
		}
		
		$scope.statsNameList = statsListArray.sort((a, b) => (a.name > b.name) - (a.name < b.name));
	};
	
	/*
	 * Prepare data to show it in a chart
	 */
	$scope.prepareDataForChart = function(selectedItem) {
		if(selectedItem != null) {
			var preparedDataArray = new Array();
			
			for(var i=0; i<$scope.userStats.length; i++) {
				var statsData = $scope.userStats[i].stats;
				var dayStatsDataArray = new Array();
				
				for(var j=0; j<statsData.length; j++) {
					for(var k=0; k<selectedItem.value.length; k++) {
						if(statsData[j].name == selectedItem.value[k]) {
							dayStatsDataArray.push(statsData[j]);
						}
					}
				}
				
				var orderedStatsValuesArray = new Array();
				
				for(var j=0; j<selectedItem.value.length; j++) {
					for(var k=0; k<dayStatsDataArray.length; k++) {
						if(selectedItem.value[j] == dayStatsDataArray[k].name) {
							orderedStatsValuesArray.push(dayStatsDataArray[k].value);
						}
					}
				}
				
				var dailyStatsArray = new Array();
				
				if(selectedItem.total) {
					dailyStatsArray.push($scope.userStats[i].creationDateEpoch, orderedStatsValuesArray[0] == 0 || orderedStatsValuesArray[1] == 0 ? 0 : Math.round((orderedStatsValuesArray[0] / orderedStatsValuesArray[1]) * 1e2) / 1e2);
				} else {
					dailyStatsArray.push($scope.userStats[i].creationDateEpoch, orderedStatsValuesArray);
				}
				
				preparedDataArray.push(dailyStatsArray);
			}
			
			if(!selectedItem.total) {
				var preparedDailyDataArray = new Array();
				
				for(var i=0; i<preparedDataArray.length; i++) {
					var tempDailyArray = new Array();
					
					if(i == 0) {
						tempDailyArray.push(preparedDataArray[i][0], preparedDataArray[i][1][0] == 0 || preparedDataArray[i][1][1] == 0 ? 0 : Math.round((preparedDataArray[i][1][0] / preparedDataArray[i][1][1]) * 1e2) / 1e2);
					} else {
						var firstValueDifference = preparedDataArray[i][1][0] - preparedDataArray[i-1][1][0];
						var secondValueDifference = preparedDataArray[i][1][1] - preparedDataArray[i-1][1][1];
						
						tempDailyArray.push(preparedDataArray[i][0], firstValueDifference == 0 || secondValueDifference == 0 ? 0 : Math.round((firstValueDifference / secondValueDifference) * 1e2) / 1e2);
					}
					
					preparedDailyDataArray.push(tempDailyArray);
				}
				
				return preparedDailyDataArray;
			}
			
			return preparedDataArray;
		}		
	};
	
	$scope.statsFunctionDependencies = [
		{
			name: 'Accuracy (%)',
			values: ['total_hits', 'total_shots']
		},
		{
			name: 'Shots per Kill',
			values: ['total_hits', 'total_kills']
		}
	];
	
	/*
	 * Format name for custom chart
	 */
	$scope.formatChartName = function(valueX, valueY) {
		var valueXsplitted = valueX.value.split('_');
		var valueYsplitted = valueY.value.split('_');
		
		if(valueXsplitted[valueXsplitted.length - 1] == valueYsplitted[valueYsplitted.length - 1]) {
			var dependencyFound = false;
			var dependencyName = null;
			var valueXconcat = valueXsplitted.slice(0, -1).join('_');
			var valueYconcat = valueYsplitted.slice(0, -1).join('_');
			
			for(var i=0; i<$scope.statsFunctionDependencies.length; i++) {
				if(valueXconcat == $scope.statsFunctionDependencies[i].values[0] && valueYconcat == $scope.statsFunctionDependencies[i].values[1]) {
					dependencyName = $scope.statsFunctionDependencies[i].name;
					dependencyFound = true;
					break;
				}
			}
			
			if(dependencyFound) {
				return dependencyName + ' [' + $scope.capitalizeFistLetterOfWord(valueXsplitted[valueXsplitted.length - 1]) + ']';
			}
		} 
		
		return valueX.name + ' / ' + valueY.name;
	};
	
	/*
	 * Create custom chart form user input
	 */
	$scope.createCustomChart = function() {
		$scope.hideSetAllRequiredOptionsWarningAlert = true;
		
		if($scope.selectedItemChartsStatsValueX != null && $scope.selectedItemChartsStatsValueY != null && $scope.customStatsTypeFilter != null) {
			$("#calculatedDataSelect").val("");
			var chartsStatsValueX = JSON.parse($scope.selectedItemChartsStatsValueX);
			var chartsStatsValueY = JSON.parse($scope.selectedItemChartsStatsValueY);
			var itemName = $scope.formatChartName(chartsStatsValueX, chartsStatsValueY);
			
			if($scope.customStatsTypeFilter) {
				itemName += ' [Total]';
			} else {
				itemName += ' [Daily]';
			}
			
			var selectedItem = { name: itemName, value: [chartsStatsValueX.value, chartsStatsValueY.value], total: $scope.customStatsTypeFilter };
			$scope.populateChartWithData(selectedItem, false);
		} else {
			var valueXError = false;
			var valueYError = false;
			var warningMessage = "";
			
			if($scope.selectedItemChartsStatsValueX == null) {
				valueXError = true;
			} 
			
			if($scope.selectedItemChartsStatsValueY == null) {
				valueYError = true;
			}
			
			if(valueXError && valueYError) {
				warningMessage = "values: 'Value X' and 'Value Y' are";
			} else if(valueXError) {
				warningMessage = "value: 'Value X' is";
			} else {
				warningMessage = "value: 'Value Y' is";
			}
						
			$scope.replaceSetAllRequiredOptionsWarningAlert(warningMessage);
			$scope.hideSetAllRequiredOptionsWarningAlert = false;
		}
	};
	
	/*
	 * Populate table with data
	 */
	$scope.populateTableWithData = function(captionTitle, leftColTitle, rightColTitle, dataToPopulateTable) {
		$scope.tableCaptionTitle = captionTitle;
		$scope.tableLeftColTitle = leftColTitle;
		$scope.tableRightColTitle = rightColTitle;
		$scope.tableData = dataToPopulateTable;
	};
	
	/*
	 * Populate chart with data
	 */
	$scope.populateChartWithData = function(selectedItem, parseItem) {
		if(selectedItem != null) {
			if(parseItem) {
				$("#valueXSelect").val("");
				$("#valueYSelect").val("");
				$scope.selectedItemChartsStatsValueX = null;
				$scope.selectedItemChartsStatsValueY = null;
				selectedItem = JSON.parse(selectedItem);
			}
			
			var preparedData = $scope.prepareDataForChart(selectedItem);
			var point = $scope.createReadableTextFromStringOfChars(selectedItem.value[0]) + ' to ' + $scope.createReadableTextFromStringOfChars(selectedItem.value[1]);
			var title = point + ' ratio over time';		
			$scope.setChart(preparedData, title, 'datetime', selectedItem.name, point);
			$scope.populateTableWithData(title, 'DateTime', selectedItem.name, preparedData);
		}
	};
	
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
	 * Format data to readable string
	 */
	$scope.formatDateForTable = function(data) {
		var options = { weekday: 'long', year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' };
		return new Date(data).toLocaleDateString("en-GB", options);
	};
	
	/*
	 * Create readable text from String of Chars
	 */
	$scope.createReadableTextFromStringOfChars = function(stringToFix) {
		var title = stringToFix.split('_');
		
		for(var i=0; i<title.length; i++) {
			title[i] = $scope.capitalizeFistLetterOfWord(title[i]);
		}
		
		title = title.join(' ');
		
		return title;
	};
	
	/*
	 * Capitalize the first letter of word
	 */
	$scope.capitalizeFistLetterOfWord = function(wordToCapitalize) {
		return wordToCapitalize.charAt(0).toUpperCase() + wordToCapitalize.slice(1);
	}
	
	/*
	 * Load user stats from database
	 */
	$scope.loadUserStats = function() {
		$scope.hideChartsPanelLoading = false;
		$scope.hideFailStatsDownloadingError = true;
		$scope.hideFooter = true;
		
		$http.post($scope.url + '/stats/userStatsDataForCharts', $scope.steamId)
		.then(function(response) {
			if(response.data != "" && response.data != null) {
				for(var i=0; i<response.data.length; i++) {
					response.data[i].stats = JSON.parse(response.data[i].stats);
				}
				
				$scope.userStats = response.data;
				var selectedItem = { name: 'Kill Death Ratio (KDR) [Daily]', value: ['total_kills', 'total_deaths'], total: false };
				var readyDataForChart = $scope.prepareDataForChart(selectedItem);				

				if(readyDataForChart != "" && readyDataForChart != null && readyDataForChart.length > 0) {	
					$scope.hideChartsPanelLoading = true;
					$scope.hideChartsPanel = false;
					$scope.hideFooter = false;
					$('#calculatedDataSelect option[label="Kill Death Ratio (KDR) [Daily]"]').prop('selected', true);
					$scope.customStatsTypeFilter = 1;
					$scope.createListOfStats($scope.userStats[0].stats);
					var point = $scope.createReadableTextFromStringOfChars(selectedItem.value[0]) + ' to ' + $scope.createReadableTextFromStringOfChars(selectedItem.value[1]);
					var title = point + ' ratio over time';
					$scope.setChart(readyDataForChart, title, 'datetime', selectedItem.name, point);
					document.getElementById("tableContainer").style["margin-top"] = "50px";
					$scope.populateTableWithData(title, 'DateTime', selectedItem.name, readyDataForChart);
					$scope.hideDataTable = false;
				}		
			} else {				
				throw "failed downloading user stats from database.";
			}
		})
		.catch(function(error) {
			$scope.replaceFailStatsDownloadingErrorAlert();
			$scope.hideChartsPanelLoading = true;
			$scope.hideFailStatsDownloadingError = false;
			$scope.hideFooter = false;
			console.log('error: ' + error);
		});	
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
            	timezone: 'Europe/Warsaw',
            	useUTC: true
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
            	showTable: false
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
                	xDateFormat: '%A, %e/%m/%Y %H:%M',
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
	 * Load content after redirecting to charts page
	 */	
	$scope.$watch('$viewContentLoaded', function(){		
		$scope.addFooterCssProperties();	
		$scope.loadUserStats();
	});
}]);