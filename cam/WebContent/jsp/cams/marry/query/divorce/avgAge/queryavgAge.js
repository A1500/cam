var time = new Date();
var  time_m = time.format("m");
var time_y = time.format("Y");
function init() {
	ds.setParameter("xzqu", organCode);
	initQueryTime();
	ds.on('load', showDiv);
	ds.on("load",meger);
	if(cxsjq!='null'&&cxsjz!='null'){
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	L5.QuickTips.init();
};
	
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
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/marry/query/divorce/avgAge/avgAgeNextLevel.jsp";
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
	L5.dataset2excel(ds, "/jsp/cams/marry/query/divorce/avgAge/exportAvgAgeExcel.jsp?statisticsTime="+statisticsTime);
}