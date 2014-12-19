function init() {
L5.Ajax.timeout=300000;
ds.setParameter("xzqu",xzqu);
	 if(cxsjq!=null){
	 	ds.setParameter("cxsj_q", cxsjq);
	 }
	  if(cxsjq!=null){
	 	ds.setParameter("cxsj_z", cxsjz);
	 }
	 ds.load();
	 ds.on("load",showDiv);
    L5.QuickTips.init();
};

 
function showDiv() {
	setReportTitle();
	var length = ds.getCount();
	if (length == 0) {
		ds.newRecord({
					"organ_name" : "无信息",
					"mon_count" : 0,
					"disablity_num" : 0,
					"disablity_mon" : 0,
					"disablity_avg_mon" : 0,
					"dependant_num" : 0,
					"dependant_mon" : 0,
					"dependant_avg_mon" : 0,
					"demobilized_num" : 0,
					"demobilized_mon" : 0,
					"demobilized_avg_mon" : 0,
					"demobilized_illness_num" : 0,
					"demobilized_illness_mon" : 0,
					"demobilized_illness_avg_mon" : 0
				});
	}
	document.getElementById("reDiv").style.display = "";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = cxsjq.split(".")[0];
	if (year == '') {
		reportTitleSpan.innerHTML = "优待金发放情况";
	} else {
		reportTitleSpan.innerHTML ="优待金发放情况";
	}

}

function getTime(time) {
	var times = time.split("-");
	time = times[0] + "." + times[1];
	return time;
}

function test(value) {
	var xzqu = value.nextSibling.innerHTML;
	/*var cxsj_q = cxsjq;
	var cxsj_z = cxsjz;
	
	var data = new L5.Map();
	if (cxsj_q != '') {
		data.put("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz", cxsj_z);
	}
	
	data.put("xzqu", xzqu);
	data.put("pageflag","2");
	var url = "/jsp/cams/bpt/query/compulsory/query_compulsory.jsp";
	L5.forward(url, null, data);*/
	var parm="?xzqu="+xzqu+"&pageflag=2"
	if (cxsjq != null) {
		parm+="&cxsjq="+cxsjq;
	}
	if (cxsjz != null) {
		parm+="&cxsjz="+cxsjz;
	}
	var url = L5.webPath+"/jsp/cams/bpt/query/compulsory/query_compulsory.jsp"+parm;
	window.open(url);
}
 function back(){
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/bpt/query/compulsory/page_compulsory.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
 }
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/page_compulsory1.fr3'; 
	var reportName="优待金发放情况";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}

/**
 * 跳转优待金发放查询页面
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

	 
	var	url = L5.webPath+"/jsp/cams/bpt/query/bpt_people/compulsoryQuery.jsp?autoQuery=true&query_organCode="
				+ organCode + "&startTime=" + startTime + "&endTime=" + endTime + "&type="+type;
	 
	window.open(url);
}