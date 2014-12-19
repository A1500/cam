function init() {
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;
    ds.setParameter("xzqu",organCode);
	ds.on("load",showDiv);
	if(cxsjq!='null'&&cxsjz!='null'){
		document.getElementById("cxsj_q").value  = cxsjq;
		document.getElementById("cxsj_z").value  = cxsjz;
		ds.setParameter("cxsj_q", cxsjq);
		ds.setParameter("cxsj_z", cxsjz);
		ds.load();
	}
    L5.QuickTips.init();
};

function pageReset(){
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;
	//document.getElementById("reDiv").style.display = "none";
}

function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	if(cxsj_q!=''){
		ds.setParameter("cxsj_q", cxsj_q);
	}
	if(cxsj_z!=''){
	    ds.setParameter("cxsj_z", cxsj_z);
	}
    ds.setParameter("xzqu",organCode);
    ds.load();
    noReclick(ds,"queryButton"); 
}
function showDiv() {
	setReportTitle();
	var length =ds.getCount();
	if(length==0) {
		ds.newRecord({"organ_name":"无信息","disability_num":0,"disability_mon":0,"disability_avg_mon":0,"dependant_country_num":0,"dependant_country_mon":0,"dependant_country_avg_mon":0,"dependant_town_num":0,"dependant_town_mon":0,"dependant_town_avg_mon":0});
	}
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = document.getElementById("cxsj_q").value.split("-")[0];
	if(year==''){
		reportTitleSpan.innerHTML =  "定期抚恤金发放情况";
	}else{
		reportTitleSpan.innerHTML = "定期抚恤金发放情况";
	}

}
function getChnNumber(code) {
	if(code==undefined||code=="") return;
	var codeArr = code.split("");
	var reStr = "";
	for(var i=0;i<codeArr.length;i++) {
		switch(codeArr[i]) {
			case '0': reStr += "零"; break;
			case '1': reStr += "一"; break;
			case '2': reStr += "二"; break;
			case '3': reStr += "三"; break;
			case '4': reStr += "四"; break;
			case '5': reStr += "五"; break;
			case '6': reStr += "六"; break;
			case '7': reStr += "七"; break;
			case '8': reStr += "八"; break;
			case '9': reStr += "九"; break;
			default: reStr += codeArr[i];
		}
	}
	return reStr;
}

function getTime(time){
	var  times = time.split("-");
	time = times[0]+"."+times[1];
	return time;
}

  function test(value) {
  	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	var xzqu = value.nextSibling.innerHTML;
  	/*var data = new L5.Map();
  	if(cxsj_q!=''){
		data.put("cxsjq", cxsj_q);
	}
	if(cxsj_z!=''){
	   	data.put("cxsjz",cxsj_z);
	}
	
  	data.put("xzqu",xzqu);
	data.put("pageflag","1");
  	var url = "/jsp/cams/bpt/query/QueryCapitalPension/QueryCapitalPension_detail.jsp";
  	L5.forward(url,null,data);*/
	var parm="?xzqu="+xzqu+"&pageflag=1"
	if (cxsj_q != '') {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != '') {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/QueryCapitalPension/QueryCapitalPension_detail.jsp"+parm;
	window.open(url);
 }
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/capitalPension1.fr3'; 
	var reportName="定期抚恤金发放情况";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}

/**
 * 跳转定期抚恤金发放查询页面
 * 
 * @param {}
 *            obj(表单对象)
 * @param {}
 *            type（伤残类别以及三属类别）
 */
function redirect(obj, type) {
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var startTime = document.getElementById("cxsj_q").value;// 起始时间
	var endTime = document.getElementById("cxsj_z").value;// 起止时间

	if (type == "11") { // 伤残
		url = "../bpt_people/disabilityQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode + "&startTime=" + startTime + "&endTime=" + endTime;
	} else { // 三属
		url = "../bpt_people/dependentQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode+"&startTime="+startTime+"&endTime="+endTime+"&domicileType="+type;
	}
	window.open(url);
}