 
function init() {
    var dsNext = L5.DatasetMgr.lookup("dsNext");
    dsNext.setParameter("xzqu", xzqu);
	if (cxsjq != null&&cxsjz != null) { 
		dsNext.setParameter("cxsjq", cxsjq);
		dsNext.setParameter("cxsjz", cxsjz);
		dsNext.load();
	}
	dsNext.on("load",setStatisticsTime);
	L5.QuickTips.init();
	
};

function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}

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
	dsNext.setParameter("xzqu", organCode);
	dsNext.setParameter("cxsjq",cxsjq_y+"-"+cxsjq_m);
	dsNext.setParameter("cxsjz",cxsjz_y+"-"+cxsjz_m);
	dsNext.load();
}
function queryNextLevel(value){
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
    var url = "jsp/cams/marry/query/divorce/divorcePeopleType/dicorcePeopleTypeNextLevel.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/marry/query/divorce/divorcePeopleType/divorcePeopleTypeQuery.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
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
	L5.dataset2excel(dsNext, "/jsp/cams/marry/query/divorce/divorcePeopleType/exportPeopleTypeExcel.jsp?statisticsTime="+statisticsTime);
}