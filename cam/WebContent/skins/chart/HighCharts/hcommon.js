var options ={
		chart: {
			renderTo: 'container',
			defaultSeriesType: 'line',
			height: 200 //图框高(默认500)
		},
		title: {
			text: ''
		},
		xAxis: {},
		yAxis: {
			min: 0,
			title: {
				text: ''
			}
		},
		legend: {
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
		}
	        
	};
	
/**
 * 饼状图展现
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 * @author luguosui
 */
function showPieChart(ds,chartDivID,yKeys){
	options.chart.defaultSeriesType='pie';
	if(chartDivID){//指定渲染哪个div
		options.chart.renderTo=chartDivID;
	}
	revl= getPieDataFromJSON(ds,yKeys);
	options.series=revl.series;
	options.plotOptions=revl.plotOptions;
	options.tooltip=revl.tooltip;
	chart = new Highcharts.Chart(options);
}
function getPieDataFromJSON(ds,yKeys){
	options.chart.defaultSeriesType='pie';
	var revl={series:"",categories:"",plotOptions:"",tooltip:""};
	revl.plotOptions={
			pie : {
				allowPointSelect : true,
				cursor : 'pointer',
				dataLabels: {
								enabled: true,
								color: '#000000',
								connectorColor: '#000000',
								formatter: function() {
									return '<b>'+ this.point.name +'</b>: '+ this.y +' ';
								}
				},
				showInLegend : false
			}
		};
	revl.tooltip ={
			formatter : function() {
				return '<b>' + this.point.name + '</b>: ' + this.percentage.toFixed(2)
						+ ' %';
			}
		};
	var series=[{
					type : 'pie',
					name : '饼状图',
					data : []
				}];
	if(ds.getCount()>0){
		var record=ds.getAllRecords()[0];
		for(j=0;j<yKeys.length;j++){
			var data=[];
			if(record.get(yKeys[j].key)){
				data.push(yKeys[j].name,record.get(yKeys[j].key));
			}else{
				data.push(yKeys[j].name,0);
			}
			series[0].data.push(data);
		}
	}
	revl.series=series;
	return revl;
}

/**
 * 柱状图展现
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 * @author luguosui
 */
function showColumnChartDS(ds,chartDivID,yKeys){
	options.chart.defaultSeriesType='column';
	if(chartDivID){//指定渲染哪个div
		options.chart.renderTo=chartDivID;
	}
	revl= getColumnDataFromDS(ds,yKeys);
	options.series=revl.series;
	options.plotOptions=revl.plotOptions;
	options.tooltip=revl.tooltip;
	options.xAxis=revl.xAxis;
	chart = new Highcharts.Chart(options);
}
/**
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 */
function getColumnDataFromDS(ds,yKeys){
	var revl={series:"",categories:"",plotOptions:"",tooltip:"",xAxis:""};
	
	revl.plotOptions={
			bar : {
						dataLabels : {
							enabled : true
						}
					}
		};
	revl.tooltip ={
			formatter : function() {
						return this.x+"_"+this.series.name+ ":" + this.y;
					}
		};
					
 var series= [{
						
						type: 'pie',
						name: '数量',
						data: [
							['伤残人员',   22558],
							['三属',       6774],
							['在乡复员',    24923],
							['带病回乡',     25025],
							['参战',     21130],
							['参核',     4207],
							['老兵',     42897],
							['老烈子',     39836]
						]
					}]
//	revl.xAxis=xAxis;
	revl.series=series;
	return revl;
}
/**
 * 柱状图展现
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 * @author luguosui
 */
function showColumnChart(ds,chartDivID,xKey,yKeys){
	options.chart.defaultSeriesType='column';
	if(chartDivID){//指定渲染哪个div
		options.chart.renderTo=chartDivID;
	}
	revl= getColumnDataFromJSON(ds,xKey,yKeys);
	options.series=revl.series;
	options.plotOptions=revl.plotOptions;
	options.tooltip=revl.tooltip;
	options.xAxis=revl.xAxis;
	chart = new Highcharts.Chart(options);
}
/**
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 */
function getColumnDataFromJSON(ds,xKey,yKeys){
	var revl={series:"",categories:"",plotOptions:"",tooltip:"",xAxis:""};
	revl.plotOptions={
			bar : {
						dataLabels : {
							enabled : true
						}
					}
		};
	revl.tooltip ={
			formatter : function() {
						return this.x+"_"+this.series.name+ ":" + this.y;
					}
		};
		
	revl.xAxis ={
					categories : [],
					title : {
						text : ''
					}
				};
	var series=[];
	var categories=[];
	
	
	for(j=0;j<yKeys.length;j++){
		var seriesContent={name:yKeys[j].name,data:[]};
		if(ds.getCount()>0){
			var records=ds.getAllRecords();
			for(i=0;i<records.length;i++){
				var data={type : 'column',name : '',data : []};
				if(records[i].get(yKeys[j].key)){
					seriesContent.data.push(records[i].get(yKeys[j].key));
				}else{
					seriesContent.data.push("0");
				}
				if(j==0){
					categories.push(records[i].get(xKey));
				}
			}
			revl.xAxis.categories=categories;
		}
		series.push(seriesContent);
	}
	revl.series=series;
	return revl;
}
/**
 * 折线图展现
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 * @author zhangdongdong
 */
function showLineChart(ds,chartDivID,xKey,yKeys){
	options.chart.defaultSeriesType='line';
	if(chartDivID){//指定渲染哪个div
		options.chart.renderTo=chartDivID;
	}
	revl= getLineDataFromJSON(ds,xKey,yKeys);
	options.series=revl.series;
	options.plotOptions=revl.plotOptions;
	options.tooltip=revl.tooltip;
	options.xAxis=revl.xAxis;
	chart = new Highcharts.Chart(options);
}
/**
 * @param {} ds
 * @param {} xKey 柱状图x轴显示的内容在ds中对应的key
 * @param {} yKeys 柱状图x轴显示的内容在ds中对应的key的数组
 * @return {}
 */
function getLineDataFromJSON(ds,xKey,yKeys){
	var revl={series:"",categories:"",plotOptions:"",tooltip:"",xAxis:""};
	revl.plotOptions={
			bar : {
						dataLabels : {
							enabled : true
						}
					}
		};
	revl.tooltip ={
			formatter : function() {
						return this.x + ":" + this.y;
					}
		};
		
	revl.xAxis ={
					categories : [],
					title : {
						text : ''
					}
				};
	var series=[];
	var categories=[];
	
	
	for(j=0;j<yKeys.length;j++){
		var seriesContent={name:yKeys[j].name,data:[]};
		if(ds.getCount()>0){
			var records=ds.getAllRecords();
			for(i=0;i<records.length;i++){
				var data={type : 'column',name : '',data : []};
				if(records[i].get(yKeys[j].key)){
					seriesContent.data.push(records[i].get(yKeys[j].key));
				}else{
					seriesContent.data.push("0");
				}
				if(j==0){
					categories.push(records[i].get(xKey));
				}
			}
			revl.xAxis.categories=categories;
		}
		series.push(seriesContent);
	}
	revl.series=series;
	return revl;
}

// 格式化日期
function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}