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

function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/marry/query/marry/ageGroup/ageGroupQuery.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
}

function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}
function queryNextLevel(value){
	var xzqh = value.nextSibling.innerHTML;
	if(xzqh ==xzqu ){
		return ;
	}
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("xzqu", xzqh);
	data.put("pageflag", "2");
	var url = "jsp/cams/marry/query/marry/ageGroup/ageGroupNextLevel.jsp";
	L5.forward(url, null, data);
}

function forExcel(){
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/marry/query/marry/ageGroup/exportageGroupExcel.jsp?statisticsTime="+statisticsTime);
}

function columnDatatable(){
	var titleText;
	if(titleText==null)
		titleText="结婚登记分年龄段统计表";
	var rows = document.getElementById('sourceTable').rows;
	if(rows.length<4){
		document.getElementById("showTable").style.display = "none";
		return;
	}else{
		document.getElementById("showTable").style.display = "";
	}
	options = {
				   chart: {
				      renderTo: 'container',
				      defaultSeriesType: 'column'
				   },
				   title: {
				      text: titleText
				   },
				   xAxis: {
				   },
				    yAxis: {
				    	title: {text: '人数'},
				    	plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}]
				   },
				   tooltip: {
				      formatter: function() {
				         return '<b>'+ this.x+' '+this.series.name +'</b><br/>'+this.y ;
				      }
				   }
				};
	options.xAxis.categories = [];
	for(var i=3;i<=13;i++){
		name = (rows[0].cells[i].innerText);
		options.xAxis.categories.push(name);
	}
	options.series = [];
	options.series[0] = {name: '男',data: []};
	options.series[1] = {name: '女',data: []};
	for(var j=0;j<=10;j++){
		var columnMan =replaceAll((rows[3].cells[2*j+3].childNodes[0].innerText),',','');
		var valueMan = columnMan=='-- '?0:columnMan;
		options.series[0].data.push(parseInt(valueMan));
		var columnWoman =replaceAll((rows[4].cells[2*j+3].childNodes[0].innerText),',','');
		var valueWoman = columnWoman=='-- '?0:columnWoman;
		options.series[1].data.push(parseInt(valueWoman));
	}
	var chart = new Highcharts.Chart(options);
	
}

function picDatatable(){
	var titleText;
	if(titleText==null)
		titleText="结婚登记分年龄段统计表";
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
		         return '<b>'+  this.point.name+'     '+this.y+' %'
		      }
		   },
		  	legend: {
		        align: 'center',
		        floating: true,
		        verticalAlign: 'center',
		        x: 20,
		        y: 340
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
								return '<b>'+ this.y+' %'
							}else{
								return '<b>'+this.point.name+'  '+ this.y+' %'
							}
						}

					}
				}
            },
            series: [{
						type: 'pie',
						name: '男',
						data: [],
						center: [240, 180],
						showInLegend: true,
						size: 160
					},{
						type: 'pie',
						name: '女',
						data: [],
						showInLegend: true,
						center: [720, 180],
						size: 160
					}]

	};
	var i = 0 ;
	for(var j=4;j<=24;j+=2){
		var columnMan = (rows[3].cells[j].childNodes[0].innerText);
		options.series[0].data[i]={name:(rows[0].cells[i+3].innerText).replace(',',''),y:Number(columnMan)};
		var columnWoman = (rows[4].cells[j].childNodes[0].innerText);
		options.series[1].data[i]={name:(rows[0].cells[i+3].innerText).replace(',',''),y:Number(columnWoman)};
		i++;
	}
	var chart = new Highcharts.Chart(options);
}
function replaceAll(str,oldstr,newstr){
	while( str.indexOf(oldstr) != -1 ) {
     		str=str.replace(oldstr,newstr); 
		}
	return str;
}