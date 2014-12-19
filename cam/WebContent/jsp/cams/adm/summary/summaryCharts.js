//社会组织
function initSorgChart(){
chart = new Highcharts.Chart({
					chart: {
						renderTo: 'sorgDiv',
						defaultSeriesType: 'bar',
						height:172
					},
					title: {
						text: ''
					},
					subtitle: {
						text: ''
					},
					xAxis: {
						categories: [''],
						title: {
							text: null
						}
					},
					yAxis: {
						min: 0,
						title: {
							text: '',
							align: 'high'
						}
					},
					tooltip: {
						formatter: function() {
							return ''+
								 this.series.name +': '+ this.y ;
						}
					},
					legend: {
						align: 'right',
						verticalAlign: 'top',
						floating: true,
						borderWidth: 0
					},
					plotOptions: {
						bar: {
							dataLabels: {
								enabled: true
							}
						}
					},
					credits: {
						enabled: false
					},
				        series: [{
				        name:'社团',
						data: [107]
					},{
				        name:'民非',
						data: [31]
					},{
				        name:'基金会',
						data: [203]
					}]
				});
}
//婚姻
function initMarryYearChart(){
chart = new Highcharts.Chart({
					chart: {
						renderTo: 'marryDiv',
						defaultSeriesType: 'column',
						height:220
					},
					title: {
						text: ''
					},
					subtitle: {
						text: ''
					},
					xAxis: {
						categories: ['2003','2004','2005','2006','2007','2008','2009','2010','2011','20012'],
						title: {
							text: null
						}
					},
					yAxis: {
						min: 0,
						title: {
							text: '',
							align: 'high'
						}
					},
					tooltip: {
						formatter: function() {
							return ''+
								 this.series.name +': '+ (this.y/10000)+"万" ;
						}
					},
					legend: {
						align: 'right',
						verticalAlign: 'top',
						floating: true,
						borderWidth: 0
					},
					plotOptions: {
						bar: {
							dataLabels: {
								enabled: true
							}
						}
					},
					credits: {
						enabled: false
					},
				        series: [{
				        name:'结婚登记数量',
						data: [3156740000,4563440000,5436730000,5698730000,5576560000,3456730000,6578760000,4567930000,7865210000,5652370000]
					}]
				});
}
//婚姻
function initMarryChart(){
	chart = new Highcharts.Chart({
					chart: {
						renderTo: 'marryDiv',
						defaultSeriesType: 'column',
						height:272
					},
					title: {
						text: ''
					},
					subtitle: {
						text: ''
					},
					xAxis: {
						categories: [
							''
						]
					},
					yAxis: {
						min: 0,
						title: {
							text: ''
						}
					},legend: {
						align: 'right',
						verticalAlign: 'top',
						floating: true,
						borderWidth: 0
					},
					tooltip: {
						formatter: function() {
							return ''+
								this.x +': '+ this.y ;
						}
					},
					plotOptions: {
						column: {
							pointPadding: 0.2,
							borderWidth: 0
						}
					},
				        series: [{
						name: '结婚登记',
						data: [1234]
				
					},{
						name: '离婚登记',
						data: [200]
				
					},{
						name: '开具证明',
						data: [500]
				
					}]
				});
				
}
//救灾
function initJZChart(){
	chart = new Highcharts.Chart({
					chart: {
						renderTo: 'jzDiv',
						defaultSeriesType: 'line',
						height:172
					},
					title: {
						text: ''
					},
					subtitle: {
						text: ''
					},
					xAxis: {
						categories: ['2012-07', '2012-08', '2012-09', '2012-10', '2012-11','2012-10']
					},
					yAxis: {
						title: {
							text: ''
						},
						plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}]
					},
					tooltip: {
						formatter: function() {
				                return '<b>'+ this.series.name +'</b><br/>'+
								this.x +': '+ this.y;
						}
					},legend: {
						align: 'right',
						verticalAlign: 'top',
						floating: true,
						borderWidth: 0
					},
					series: [{
						name: '金额',
						data: [7.0, 6.9, 9.5, 14.5, 8.2, 9.5]
					}]
				});
				
}
//社会福利单位
function initSHFLChart(){
	var chart;
	var colors = Highcharts.getOptions().colors,
					categories = ['优抚类单位', '城市社会福利机构', '敬老院'],
					name = 'Browser brands',
					data = [{ 
							y: 55.11,
							color: colors[0],
							drilldown: {
								name: '优抚类单位',
								categories: ['荣誉军人康复医院', '复员军人疗养院', '复退军人精神病院', '光荣院'],
								data: [10.85, 7.35, 33.06, 2.81],
								color: colors[0]
							}
						}, {
						 	y: 21.63,
							color: colors[1],
							drilldown: {
								name: '城市社会福利机构',
								categories: ['社会福利院', '儿童福利机构', '社会福利医院', '城镇老年福利机构', '社区养老福利机构'],
								data: [0.20, 0.83, 1.58, 13.12, 5.43],
								color: colors[1]
							}
						}, {
							y: 11.94,
							color: colors[2],
							drilldown: {
								name: '敬老院',
								categories: ['敬老院'],
								data: [0.12],
								color: colors[2]
							}
						}];
				
				
				// Build the data arrays
				var browserData = [];
				var versionsData = [];
				for (var i = 0; i < data.length; i++) {
					
					// add browser data
					browserData.push({
						name: categories[i],
						y: data[i].y,
						color: data[i].color
					});
					
					// add version data
					for (var j = 0; j < data[i].drilldown.data.length; j++) {
						var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
						versionsData.push({
							name: data[i].drilldown.categories[j],
							y: data[i].drilldown.data[j],
							color: Highcharts.Color(data[i].color).brighten(brightness).get()
						});
					}
				}
				
				// Create the chart
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'shflDiv', 
						type: 'pie',
						height:272
					},
					title: {
						text: ''
					},
					yAxis: {
						title: {
							text: ''
						}
					},
					plotOptions: {
						pie: {
							shadow: false
						}
					},
					tooltip: {
						formatter: function() {
							return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
						}
					},
					series: [{
						name: 'Browsers',
						data: browserData,
						size: '60%',
						dataLabels: {
							formatter: function() {
								return this.y > 5 ? this.point.name : null;
							},
							color: 'white',
							distance: -30
						}
					}, {
						name: 'Versions',
						data: versionsData,
						innerSize: '60%',
						dataLabels: {
							formatter: function() {
								// display only if larger than 1
								return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ this.y +'%'  : null;
							}
						}
					}]
				});
				
}