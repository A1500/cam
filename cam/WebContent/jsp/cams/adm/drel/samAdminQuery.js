var pieData = value = "<pieSource>";
var str = new Array();
var cityArr = new Array();
var countryArr = new Array();
var fiveArr = new Array();
var cityArr1 = new Array();
var countryArr1 = new Array();
var fiveArr1 = new Array();
function init() {
//	initCountry();
//	initChange();
	monthchangeDS.on('load',function(){
		for(var i=0 ;i<monthchangeDS.getCount();i++){
			var record = monthchangeDS.getAt(i);
			str.push(record.get("QUERY_MONTH"));
			cityArr.push(parseFloat(record.get("CITY_FAMILY_NUM")));
			countryArr.push(parseFloat(record.get("COUNTRY_FAMILY_NUM")));
			fiveArr.push(parseFloat(record.get("FIVE_FAMILY_NUM")));
			cityArr1.push(parseFloat(record.get("CITY_PEOPLE_NUM")));
			countryArr1.push(parseFloat(record.get("COUNTRY_PEOPLE_NUM")));
			fiveArr1.push(parseFloat(record.get("FIVE_PEOPLE_NUM")));
		}
		initMarryYearChart();
		initMarryYearChart1();
	});
	monthchangeDS.load();
}

function initCountry() {
	var ops = {
		height : 327,
		nowrap : true,
		autoRowHeight : false,
		striped : true,
		sortName : 'code',
		sortOrder : 'desc',
		loader : dcLoader,
		url : '/command/ajax/com.inspur.cams.drel.admin.cmd.SamAdminQueryCmd/queryBaseFamilyCaseNow',
		remoteSort : false,
		idField : 'DIM',
		frozenColumns : [[{
					field : 'DOMICILE_NAME',
					title : '地区',
					width : 100
				}]],	
		columns : [[{
					field : 'COUNT',
					title : '户数总计',
					width : 100,
					align : 'right'
				}, {
					field : 'PEOPLENUM',
					title : '人数总计',
					width : 100,
					align : 'right'
				}, {
					field : 'MONEYSUM',
					title : '保障金总计',
					width : 120,
					align : 'right'
				}, {
					field : 'CITYCOUNT',
					title : '城市低保户数',
					width : 100,
					align : 'right'
				}, {
					field : 'CITYPEOPLE',
					title : '城市低保人数',
					width : 100,
					align : 'right'
				}, {
					field : 'CITYMONEY',
					title : '城市低保保障金',
					width : 120,
					align : 'right'
				}, {
					field : 'COUNTRYCOUNT',
					title : '农村低保户数',
					width : 100,
					align : 'right'
				}, {
					field : 'COUNTRYPEOPLE',
					title : '农村低保人数',
					width : 100,
					align : 'right'
				}, {
					field : 'COUNTRYMONEY',
					title : '农村低保保障金',
					width : 120,
					align : 'right'
				}, {
					field : 'FIVECOUNT',
					title : '农村五保户数',
					width : 100,
					align : 'right'
				}, {
					field : 'FIVEPEOPLE',
					title : '农村五保人数',
					width : 100,
					align : 'right'
				}, {
					field : 'FIVEMONEY',
					title : '农村五保保障金',
					width : 120,
					align : 'right'
				}]],
		pagination : false,
		rownumbers : true
	};
	$('#nongcun').datagrid(ops);
	//$('#nongcun').datagrid('load');//Grid列表数据加载
}
function initChange() {
	var ops = {
		height : 327,
		nowrap : true,
		autoRowHeight : false,
		striped : true,
		sortName : 'code',
		sortOrder : 'desc',
		loader : dcLoader,
		url : '/command/ajax/com.inspur.cams.drel.admin.cmd.SamAdminQueryCmd/queryBaseChange',
		remoteSort : false,
		idField : 'DIM',
		frozenColumns : [[{
					field : 'DOMICILE_CODE',
					title : '地区',
					width : 90
				}]],	
		columns : [[{
					field : 'NEWSUM',
					title : '新增户数总计',
					width : 100,
					align : 'right'
				}, {
					field : 'STOPSUM',
					title : '停保户数总计',
					width : 100,
					align : 'right'
				}, {
					field : 'CITYNEW',
					title : '城市低保新增户数',
					width : 120,
					align : 'right'
				}, {
					field : 'CITYSTOP',
					title : '城市低保停保户数',
					width : 100,
					align : 'right'
				}, {
					field : 'COUNTRYNEW',
					title : '农村低保新增户数',
					width : 100,
					align : 'right'
				}, {
					field : 'COUNTRYSTOP',
					title : '农村低保停保户数',
					width : 120,
					align : 'right'
				}, {
					field : 'FIVENEW',
					title : '农村五保新增户数',
					width : 100,
					align : 'right'
				}, {
					field : 'FIVESTOP',
					title : '农村五保停保户数',
					width : 100,
					align : 'right'
				}]],
		pagination : false,
		rownumbers : true
	};
	$('#change').datagrid(ops);
	//$('#change').datagrid('load');//Grid列表数据加载
}
//获取项目根路径
function getProjectName(){
	var curWwwPath=window.document.location.href;
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	var localhostPaht=curWwwPath.substring(0,pos);
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	return projectName;
}
function initMarryYearChart(){
chart = new Highcharts.Chart({
					chart: {
						renderTo: 'MarryChart',
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
						categories: str,
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
							 return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y  +'户';
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
                name: '城市低保',
                data: cityArr
            }, {
                name: '农村低保',
                data: countryArr
            }, {
                name: '农村五保',
                data: fiveArr
					}]
				});
}
function initMarryYearChart1(){
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
						categories: str,
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
							 return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y  +'人';
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
                name: '城市低保',
                data: cityArr1
            }, {
                name: '农村低保',
                data: countryArr1
            }, {
                name: '农村五保',
                data: fiveArr1
					}]
				});
}