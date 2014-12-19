function init() {
L5.Ajax.timeout=300000;
	 ds.setParameter("xzqu",xzqu);
	 if(cxsjq!=null){
	 	ds.setParameter("cxsj_q", cxsjq);
	 }
	  if(cxsjz!=null){
	 	ds.setParameter("cxsj_z", cxsjz);
	 }
	 ds.load();
	 ds.on("load",showDiv);
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function showDiv() {
	setReportTitle();
	var length =ds.getCount();
	if(length==0) {
		ds.newRecord({"organ_name":"无信息","count":0,"demobilized_num":0,"demobilized_mon":0,"demobilized_avg_mon":0,"demobilized_iliness_num":0,"demobilized_iliness_mon":0,"demobilized_iliness_avg_mon":0,"war_num":0,"war_town_mon":0,
		"war_town_avg_mon":0,"tested_num":0,"tested_town_mon":0,"tested_town_avg_mon":0,"soldier_num" : 0,
					"soldier_town_mon" : 0,
					"soldier_town_avg_mon" : 0,
					"martyr_num" : 0,
					"martyr_town_mon" : 0,
					"martyr_town_avg_mon" : 0});
	}
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = cxsjq.split(".")[0];
	if(year=='null'){
		reportTitleSpan.innerHTML =  "生活补助金发放情况";
	}else{
		reportTitleSpan.innerHTML ="生活补助金发放情况";
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
function test(value) {
	var xzqu = value.nextSibling.innerHTML;
  	/*var data = new L5.Map();
  	if(cxsjq!=null){
  		data.put("cxsjq",cxsjq);
	 }
	  if(cxsjq!=null){
	 	data.put("cxsjz",cxsjz);
	 }
	
  	data.put("xzqu",xzqu);
	data.put("pageflag","2");
  	var url = "/jsp/cams/bpt/query/livingSubsidyPayment/query_LivingSubsidyPayment.jsp";
  	L5.forward(url,null,data);*/
  	var sj=""
	if (cxsjq != '') {
		sj+="&cxsjq="+cxsjq;
	}
	if (cxsjz != '') {
		sj+="&cxsjz="+cxsjz;
	}
	var url = L5.webPath+"/jsp/cams/bpt/query/livingSubsidyPayment/query_LivingSubsidyPayment.jsp?xzqu="+xzqu+"&pageflag=2"+sj;
	window.open(url);
 }
 function back(){
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/bpt/query/livingSubsidyPayment/page_LivingSubsidyPayment.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
 }
  //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/page_LivingSubsidyPayment2.fr3'; 
	var reportName="生活补助金发放情况";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}


/**
 * 跳转定期抚恤金发放查询页面
 * 
 * @param {}
 *            obj(表单对象)
 * @param {}
 *            type（优抚类别）
 */
function redirect(obj, type) {
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var startTime = cxsjq;// 起始时间
	var endTime = cxsjz;// 起止时间

	if (type == "41") { // 在乡复员
		url = "../bpt_people/demobilizedQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode + "&startTime=" + startTime + "&endTime=" + endTime;
	} else if(type == "42") { // 带病回乡
		url = "../bpt_people/demobilizedIllnessQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode+"&startTime="+startTime+"&endTime="+endTime;
	}  else if(type == "81"){
		url = "../bpt_people/retiredQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode+"&startTime="+startTime+"&endTime="+endTime;
	}else if(type == "B1"){
		url = "../bpt_people/martyrOffspringQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode+"&startTime="+startTime+"&endTime="+endTime;
	}else { //参战、参试
		url = "../bpt_people/testWarQueryStatistics.jsp?autoQuery=true&query_organCode="
				+ organCode+"&startTime="+startTime+"&endTime="+endTime+"&serviceType="+type;
	}
	window.open(url);
}