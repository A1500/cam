var time = new Date();
var  time_m = time.format("m");
var time_y = time.format("Y");
function init() {
	ds.setParameter("xzqu", organCode);
	initQueryTime();
	var highcharts = L5.getCmp("highcharts");
	highcharts.show();
	var dataPanel = L5.getCmp("dataPanel");
	dataPanel.show();
	ds.on("load",function(){
		meger();
		showDiv();
		columnDatatable();
		picDatatable();
	});
	if(cxsjq!='null'&&cxsjz!='null'){
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	L5.QuickTips.init();
}

function initQueryTime(){
	initMonth("cxsjq_m");
	initMonth("cxsjz_m");
	if(cxsjq!='null'&&cxsjz!='null'){
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("cxsjq_y").value = timesq[0];
		document.getElementById("cxsjq_m").value = timesq[1];
		document.getElementById("cxsjz_y").value = timesz[0];
		document.getElementById("cxsjz_m").value = timesz[1];
	}else{
		if(time_m==1){
			document.getElementById("cxsjq_y").value = time_y-1;
			document.getElementById("cxsjq_m").value = 12;
			document.getElementById("cxsjz_y").value = time_y-1;
			document.getElementById("cxsjz_m").value = 12;
		}else{
			document.getElementById("cxsjq_y").value = time_y;
			document.getElementById("cxsjq_m").value = time_m-1;
			document.getElementById("cxsjz_y").value = time_y;
			document.getElementById("cxsjz_m").value = time_m-1;
		} 
	}
}

function initTime(){
	if(time_m==1){
			document.getElementById("cxsjq_y").value = time_y;
			document.getElementById("cxsjq_m").value = 12;
			document.getElementById("cxsjz_y").value = time_y-1;
			document.getElementById("cxsjz_m").value = 12;
		}else{
			document.getElementById("cxsjq_y").value = time_y;
			document.getElementById("cxsjq_m").value = time_m-1;
			document.getElementById("cxsjz_y").value = time_y;
			document.getElementById("cxsjz_m").value = time_m-1;
		} 
}
function initYear(id){
	var selYearQ = document.getElementById(id);
	var i = -10;
	for(i;i<=0;i++){
		var option = new Option(time_y+i,time_y+i);
		selYearQ.add(option);
	}
}
function initMonth(id){
	var selMonth = document.getElementById(id);
	selMonth.length=0;
	var i = 1;
	for(i;i<=12;i++){
		var option = new Option(i,i);
		selMonth.add(option);
	}
}

function meger() {
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
function replace(){
	var startRow = 2;
	var table = document.getElementById("resultsBody");
	var row = table.rows;
	for(var i=startRow;i<row.length;i++) {
		if(i%2!=0){
			var cell = table.rows[i].cells;
			var s = cell[3].childNodes[0];
			cell[3].childNodes[0].innerHTML =="-";
			cell[4].childNodes[0].innerHTML =="-";
			cell[5].childNodes[0].innerHTML =="-";
			cell[6].childNodes[0].innerHTML =="-";
		}
	}
}
	
function showDiv() {
	document.getElementById("reDiv").style.display = "";
	var cxsjq_y = document.getElementById("cxsjq_y").value;//查询开始时间
    var cxsjz_y = document.getElementById("cxsjz_y").value;//查询结束时间
    var cxsjq_m = document.getElementById("cxsjq_m").value;//查询开始时间
    var cxsjz_m= document.getElementById("cxsjz_m").value;//查询结束时间
	if((cxsjq_y==cxsjz_y)&&(cxsjq_m==cxsjz_m)){
		document.getElementById("statisticsTime").innerText = cxsjq_y+"年"+cxsjq_m+"月1日至"+cxsjq_y+"年"+cxsjq_m+"月"+lastDay(cxsjq_y,cxsjq_m)+"日";
	}else{
		document.getElementById("statisticsTime").innerText =cxsjq_y+"年"+cxsjq_m+"月1日 至 "+cxsjz_y+"年"+cxsjz_m+"月"+lastDay(cxsjz_y,cxsjz_m)+"日";
	}
}
function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}
function query() {
	var cxsjq_y = document.getElementById("cxsjq_y").value;//查询开始时间
    var cxsjz_y = document.getElementById("cxsjz_y").value;//查询结束时间
    var cxsjq_m = document.getElementById("cxsjq_m").value;//查询开始时间
    var cxsjz_m= document.getElementById("cxsjz_m").value;//查询结束时间
    if(cxsjq_y=="") {
		L5.Msg.alert("提示","请填写统计起始年份！");
		return;
	}
	if(cxsjz_y=="") {
		L5.Msg.alert("提示","请填写统计截止年份！");
		return;
	}
	if(cxsjq_m=="") {
		L5.Msg.alert("提示","请选择统计起始月份！");
		return;
	}
	if(cxsjz_m=="") {
		L5.Msg.alert("提示","请选择统计截止月份！");
		return;
	}
	if(Number(cxsjq_y)>Number(cxsjz_y)){
		if(Number(cxsjq_m)>Number(cxsjz_m)){
			L5.Msg.alert("提示","起始年月应小于截止年月！");
			return;
		}else{
			L5.Msg.alert("提示","起始年份应小于截止年份！");
			return;
		}
	}else if(Number(cxsjq_y)==Number(cxsjz_y)){
		if(Number(cxsjq_m)>Number(cxsjz_m)){
		L5.Msg.alert("提示","起始月份应小于截止月份！");
		return;
		}
	}
	ds.setParameter("xzqu", organCode);
	ds.setParameter("cxsjq",cxsjq_y+"-"+cxsjq_m);
	ds.setParameter("cxsjz",cxsjz_y+"-"+cxsjz_m);
	ds.load();
	noReclick(ds,'queryButton');
}

function back() {
	history.go(-1);
}


function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu==organCode){
		return;
	}
	var data = new L5.Map();
	var cxsjq_y = document.getElementById("cxsjq_y").value;//查询开始时间
    var cxsjz_y = document.getElementById("cxsjz_y").value;//查询结束时间
    var cxsjq_m = document.getElementById("cxsjq_m").value;//查询开始时间
    var cxsjz_m= document.getElementById("cxsjz_m").value;//查询结束时间
    if(cxsjq_y=="") {
		L5.Msg.alert("提示","请选择统计起始年份！");
		return;
	}
	if(cxsjz_y=="") {
		L5.Msg.alert("提示","请选择统计截止年份！");
		return;
	}
	if(cxsjq_m=="") {
		L5.Msg.alert("提示","请选择统计起始月份！");
		return;
	}
	if(cxsjz_m=="") {
		L5.Msg.alert("提示","请选择统计截止月份！");
		return;
	}
	if(Number(cxsjq_y)>Number(cxsjz_y)){
		if(Number(cxsjq_m)>Number(cxsjz_m)){
			L5.Msg.alert("提示","起始年月应小于截止年月！");
			return;
		}else{
			L5.Msg.alert("提示","起始年份应小于截止年份！");
			return;
		}
	}else if(Number(cxsjq_y)==Number(cxsjz_y)){
		if(Number(cxsjq_m)>Number(cxsjz_m)){
		L5.Msg.alert("提示","起始月份应小于截止月份！");
		return;
		}
	}
	data.put("cxsjq",cxsjq_y+"-"+cxsjq_m);
	data.put("cxsjz",cxsjz_y+"-"+cxsjz_m);
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/marry/query/marry/ageGroup/ageGroupNextLevel.jsp";
	L5.forward(url, null, data);
	
}
function CheckTxt(ObjNum)
 {   
 var regExp=/^(19|20)[0-9]{2}$/;
 var elementTxt=document.getElementById (ObjNum);
 	if(regExp.test (elementTxt.value ))
 	{
 	return true ;
 	}
	else
 	{
	  L5.Msg.alert("提示","请输入正确的年份!");
	  elementTxt.focus();
	  elementTxt.value="";
	  return false ;
 	}
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
