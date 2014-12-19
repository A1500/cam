function init() {
    var dsNext = L5.DatasetMgr.lookup("dsNext");
    dsNext.setParameter("xzqu", xzqu);
	if (cxsjq != null) { 
		dsNext.setParameter("cxsjq", cxsjq);
		dsNext.load();
	}
	dsNext.on("load",setStatisticsTime);
	L5.QuickTips.init();
	
}

function setStatisticsTime(){
		document.getElementById("statisticsTime").innerText = cxsjq + "年";
} 

function query() {
	var cxsjq_y = document.getElementById("cxsjq_y").value;//查询时间
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

function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
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
    var url = "jsp/cams/marry/query/marry/marryPeopleType/marryPeopleTypeNextLevel.jsp";
	L5.forward(url, null, data);
}
function back() {
	debugger;
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		var url = "jsp/cams/marry/query/marry/marryPeopleMonth/marryPeopleMonth.jsp";
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
	L5.dataset2excel(dsNext, "/jsp/cams/marry/query/marry/marryPeopleMonth/exportMarryPeopleMonthExcel.jsp?statisticsTime="+statisticsTime);
}