function init() {
L5.Ajax.timeout=300000;
var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;
    ds.setParameter("xzqu",organCode);
	ds.on("load", showDiv);
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
	if (cxsj_q != '') {
		ds.setParameter("cxsj_q", cxsj_q);
	}
	if (cxsj_z != '') {
		ds.setParameter("cxsj_z", cxsj_z);
	}
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton");
}
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
	var year = document.getElementById("cxsj_q").value.split("-")[0];
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
	if (cxsj_q != '') {
		data.put("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz", cxsj_z);
	}
	
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "/jsp/cams/bpt/query/compulsory/query_compulsory.jsp";
	L5.forward(url, null, data);*/
	var parm="?xzqu="+xzqu+"&pageflag=1"
	if (cxsj_q != null) {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != null) {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/compulsory/query_compulsory.jsp"+parm;
	window.open(url);
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
	var startTime = document.getElementById("cxsj_q").value;// 起始时间
	var endTime = document.getElementById("cxsj_z").value;// 起止时间

	 
	var	url = L5.webPath+"/jsp/cams/bpt/query/bpt_people/compulsoryQuery.jsp?autoQuery=true&query_organCode="
				+ organCode + "&startTime=" + startTime + "&endTime=" + endTime + "&type="+type;
	 
	window.open(url);
}