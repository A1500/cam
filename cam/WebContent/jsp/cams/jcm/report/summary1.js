var str = new Array();
var cityArr = new Array();
var pieData = value = "<pieSource>";
function init(){ 
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.setParameter("year",year);
	analysisDs.setParameter("organCode",organCode);
	analysisDs.setParameter("companyType",companyType);
	analysisDs.load();
	analysisDs.on('load',function(){
		for(var i=0 ;i<analysisDs.getCount();i++){
			var record = analysisDs.getAt(i);
			str.push(record.get("NAME"));
			cityArr.push(parseFloat(record.get("MONEY_COST")));
		}
		initSorgNumChart();
	});
}
function initSorgNumChart(){
chart = new Highcharts.Chart({
					chart: {
						renderTo: 'MarryChart',
						defaultSeriesType: 'column',
						height:230
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
                        this.series.name +': '+ this.y  +'元';
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
					 series: [{name: '工作经费(元)',data: cityArr}]
            });
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