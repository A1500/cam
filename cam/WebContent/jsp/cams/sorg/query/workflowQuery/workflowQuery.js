var time = new Date();
var time_y = time.format("Y");
var time_m = time.format("m");
var time_d = time.format("d");
function init(){
	initQueryTime();
	var ds1 = L5.DatasetMgr.lookup("ds1");
	if(cxsjq!='null'&&cxsjz!='null'){
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		ds1.setParameter("qTime", timesq[0]+timesq[1]+timesq[2]);
		ds1.setParameter("zTime", timesz[0]+timesz[1]+timesz[2]);
		ds1.setParameter("organId",organId);
		ds1.load();
	}
	ds1.on("load",function(){
		document.getElementById("reDiv").style.display = "";
		document.getElementById("statisticsTime").innerText = document.getElementById("cxsjq_y").value+"年"+document.getElementById("cxsjq_m").value+"月"+document.getElementById("cxsjq_d").value+"日至"+document.getElementById("cxsjz_y").value+"年"+document.getElementById("cxsjz_m").value+"月"+document.getElementById("cxsjz_d").value+"日";
	});
	L5.QuickTips.init();
}
function initTime(){
	document.getElementById("cxsjq_y").value = time_y;
	document.getElementById("cxsjq_m").value = time_m;
	document.getElementById("cxsjq_d").value = "01";
	document.getElementById("cxsjz_y").value = time_y;
	document.getElementById("cxsjz_m").value = time_m;
	document.getElementById("cxsjz_d").value = time_d;
}
function initQueryTime(){
	//<button onclick="resetQuery()">重 置</button>
	initMonth("cxsjq_m");
	initMonth("cxsjz_m");
	if(cxsjq!='null'&&cxsjz!='null'){
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("cxsjq_y").value = timesq[0];
		document.getElementById("cxsjq_m").value = timesq[1];
		document.getElementById("cxsjq_d").value = timesq[2];
		document.getElementById("cxsjz_y").value = timesz[0];
		document.getElementById("cxsjz_m").value = timesz[1];
		document.getElementById("cxsjz_d").value = timesz[2];
	}else{
		document.getElementById("cxsjq_y").value = time_y;
		document.getElementById("cxsjq_m").value = time_m;
		document.getElementById("cxsjq_d").value = "01";
		document.getElementById("cxsjz_y").value = time_y;
		document.getElementById("cxsjz_m").value = time_m;
		document.getElementById("cxsjz_d").value = time_d;
	}
}

function initMonth(id){
	var selMonth = document.getElementById(id);
	selMonth.length=0;
	var i = 1;
	for(i;i<=12;i++){
		var k = ""+i;
		if(k.length==1){
			k="0"+k;
		}
		var option = document.createElement("OPTION");
		option.text=k;
		option.value=k;
		selMonth.add(option);
	}
}
function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}
function CheckTxt(type,ObjNum){   
	if(type=="y"){
		var regExp=/^(19|20)[0-9]{2}$/;
		var elementTxt=document.getElementById (ObjNum);
		if(regExp.test (elementTxt.value )){
			return true ;
		}else{
			L5.Msg.alert("提示","请输入正确的年份!");
			elementTxt.focus();
			elementTxt.value="";
			return false ;
		}
	}
	if(type=="d"){
		var y = document.getElementById(ObjNum.substring(0,6)+"y").value;
		var m = document.getElementById(ObjNum.substring(0,6)+"m").value;
		if(!y){
			L5.Msg.alert("提示","请先输入年份!");
			return false;
		}else{
			var d = document.getElementById(ObjNum).value;
			if(d<1||d>lastDay(y,m)||isNaN(d)){
				L5.Msg.alert("提示","请输入正确的日期!");
				document.getElementById(ObjNum).focus();
				document.getElementById(ObjNum).value="";
				return false;
			}
		}
		if(d.length==1){
			document.getElementById(ObjNum).value="0"+d;
			return true;
		}
	}
}
function query() {
	var cxsjq_y = document.getElementById("cxsjq_y").value;//查询开始时间
    var cxsjz_y = document.getElementById("cxsjz_y").value;//查询结束时间
    var cxsjq_m = document.getElementById("cxsjq_m").value;//查询开始时间
    var cxsjz_m = document.getElementById("cxsjz_m").value;//查询结束时间
	var cxsjq_d = document.getElementById("cxsjq_d").value;//查询开始时间
	var cxsjz_d = document.getElementById("cxsjz_d").value;//查询结束时间
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
	if(cxsjq_d=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(cxsjz_d=="") {
		L5.Msg.alert("提示","请选择统计截止日期！");
		return;
	}
	if(Number(cxsjq_y)>Number(cxsjz_y)){
		L5.Msg.alert("提示","起始年份应小于截止年份！");
		return;
	}else if(Number(cxsjq_y)==Number(cxsjz_y)){
		if(Number(cxsjq_m)>Number(cxsjz_m)){
			L5.Msg.alert("提示","起始月份应小于截止月份！");
			return;
		}
		if(Number(cxsjq_m)==Number(cxsjz_m)){
			if(Number(cxsjq_d)>Number(cxsjz_d)){
				L5.Msg.alert("提示","起始日期应小于截止日期！");
				return;
			}
			
		}
	}
	var ds1 = L5.DatasetMgr.lookup("ds1");
	cxsjq=cxsjq_y+"-"+cxsjq_m+"-"+cxsjq_d;
	cxsjz=cxsjz_y+"-"+cxsjz_m+"-"+cxsjz_d;
	ds1.setParameter("qTime",cxsjq_y+cxsjq_m+cxsjq_d);
	ds1.setParameter("zTime",cxsjz_y+cxsjz_m+cxsjz_d);
	ds1.setParameter("organId",organId);
	ds1.load();
	noReclick(ds1,'queryButton');
}
function queryNextLevel(obj){
	var applyType = obj.nextSibling.innerHTML;
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("applyType", applyType);
	data.put("organId",organId);
	data.put("username",encodeURIComponent(encodeURIComponent(username)));
	data.put("userId",userId);
	var url = "jsp/cams/sorg/query/workflowQuery/workflowQuerySecondLevel.jsp";
	L5.forward(url, null, data);
}
function forExcel(){
	var ds1 = L5.DatasetMgr.lookup("ds1");
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds1, "/jsp/cams/sorg/query/workflowQuery/exportYbTaskQueryExcel.jsp?statisticsTime="+statisticsTime);
}