function init() {
	ds.setParameter("xzqu", xzqu);
	if (cxsjq != null&&cxsjz != null) {
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	ds.on("load",function(){
		meger();
	});
	var highcharts = L5.getCmp("highcharts");
	highcharts.on("activate",function(){
		columnDatatable();
		picDatatable();
	});
	L5.QuickTips.init();
	
};

function setStatisticsTime(){
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月1日至 "+times[0]+"年"+times[1]+"月"+lastDay(times[0],times[1])+"日";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月1日 至 "+ timesz[0]+"年"+timesz[1]+"月"+lastDay(timesz[0],timesz[1])+"日";
	}
}

function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/marry/query/divorce/sustainTime/querysustainTime.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
}

function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}

function meger() {
	setStatisticsTime();
	document.getElementById("reDiv").style.display = "";
	var startRow = 2;
	var megerCell = 0;
	var megerRow;
	var index = 0;
	var megObject;
	var megerValue = "";
	var table = document.getElementById("resultsBody");
	var row = table.rows;
	
	megerValue = row[startRow].cells[megerCell].childNodes[0].childNodes[0].innerHTML;
	megerRow = startRow;
	megObject	= row[startRow].cells[megerCell];
	for(var i=startRow+1;i<row.length;i++) {
			var cell = table.rows[i].cells;
			if(cell[megerCell].childNodes[0].childNodes[0].innerHTML == megerValue) {
					index++;
			} else {
				if(index >0) {
					megObject.rowSpan=index+1;
					for(var j=1;j<=index;j++) {
						table.rows[j+megerRow].cells[megerCell].style.display="none";
					}
				}
				megerValue = cell[megerCell].childNodes[0].childNodes[0].innerHTML;
				megObject	= row[i].cells[megerCell];
				megerRow = i;
				index=0;
			}
			
			if(i == row.length-1) {
				if(index >0) {
					megObject.rowSpan=index+1;
					for(var j=1;j<=index;j++) {
						table.rows[j+megerRow].cells[megerCell].style.display="none";
					}
				}
			}
	}
}

function queryNextLevel(value){
	var xzqh = value.nextSibling.innerHTML;
	if(xzqh==xzqu){
		return;
	}
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("xzqu", xzqh);
	data.put("pageflag","2");
	var url = "jsp/cams/marry/query/divorce/sustainTime/sustainTimeNextLevel.jsp";
	L5.forward(url, null, data);
}

function forExcel(){
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/marry/query/divorce/sustainTime/exportsustainExcel.jsp?statisticsTime="+statisticsTime);
}
function columnDatatable(){
	//var titleText=document.getElementById('title').value;
	var titleText;
	if(titleText==null)
		titleText="婚姻维系时间统计分析图";
	var rows = document.getElementById('sourceTable').rows;
	if(rows.length<4){
		document.getElementById("showTable").style.display = "none";
		return;
	}else{
		document.getElementById("showTable").style.display = "";
	}
	var colCounts = rows[2].cells.length;
	options = {
		   chart: {
		      renderTo: 'charLine',
		      defaultSeriesType: 'column'
		   },
		   title: {
			   text:'婚姻维系时间统计分析图'
		   },
		   credits:{
			   href:'',
			   text:''
		   },
		   xAxis: {
		   },
		   yAxis: {title: {text: '对数'},
		   		plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}]
		   },
		   legend: {
						layout: 'vertical',
						backgroundColor: '#FFFFFF',
						align: 'left',
						verticalAlign: 'top',
						x: 100,
						y: 70,
						floating: true,
						shadow: true
					},

	 		tooltip: {
		      formatter: function() {
		         return this.x + ' '+ this.series.name +': '+ this.y +' 对';
		      }
		   },
			plotOptions: {
				column: {
					pointPadding: 0.2,
					borderWidth: 0
				}
			}


		};
	options.xAxis.categories = [];
	options.series = [];
	name = (rows[3].cells[0].childNodes[0].childNodes[0].innerText).replace(',','');
	options.xAxis.categories.push(name);
	for(var i=2;i<=10;i++){
		name = (rows[0].cells[i].innerText).replace(',','');
		options.series[i-2] = {
			name: name,
			data: []
		};
	}

	for(var j=2;j<colCounts;j+=2){
		column =(rows[3].cells[j].childNodes[0].innerText).replace(',','');
		var value = column=='-- '?0:column;
		if(parseInt(value)>0){
			isChart = true;
		}
		options.series[j/2-1].data.push(parseInt(value));
	}
	var chart = new Highcharts.Chart(options);
}

function picDatatable(){
	var titleText;
	if(titleText==null)
		titleText="婚姻维系时间统计分析图";
	var rows = document.getElementById('sourceTable').rows;
	if(rows.length<4){
		document.getElementById("showTable").style.display = "none";
		return;
	}else{
		document.getElementById("showTable").style.display = "";
	}
	options = {
		   chart: {
		      renderTo: 'charPie',
		      plotBackgroundColor: null,
	          plotBorderWidth: null,
	          plotShadow: false

		   },
		   title: {
			   text:titleText
		   },
		   tooltip: {
		      formatter: function() {
		         return '<b>'+  this.point.name+'     '+ this.y+' %'
		      }
		   },
		  	legend: {
		        align: 'center',
		        verticalAlign: 'center',
		        x: 40,
		        y: 320
		    },
		   plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						color: '#000000',
						connectorColor: '#000000',
						formatter: function() {
							if( this.point.name =="" || this.point.name.length<1){
								return '<b>'+this.y +' %'
							}else{
								return '<b>'+this.point.name+'    '+ this.y +' %'
							}
						}

					}
				}
            },
            series: [{
						type: 'pie',
						name: (rows[3].cells[0].childNodes[0].childNodes[0].innerText).replace(',',''),
						data: [],
						center: [580, 140],
						showInLegend: true,
						size: 200
					}]

	};
	var i = 0 ;
	for(var j=3;j<20;j+=2){
		column = (rows[3].cells[j].childNodes[0].innerText).replace(',','');
		var value = column=='-- '?0:column;
		options.series[0].data[i]={name:(rows[0].cells[i+2].innerText).replace(',',''),y:Number(value)};
		i++;
	}

	var chart = new Highcharts.Chart(options);
}