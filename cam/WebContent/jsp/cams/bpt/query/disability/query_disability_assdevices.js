function init() {
	ds.setParameter("xzqu", xzqu);
	if (cxsjq != null) {
		ds.setParameter("cxsjq", cxsjq);
	}
	if (cxsjz != null) {
		ds.setParameter("cxsjz", cxsjz);
	}
	ds.load();
	ds.on("load", showDiv);
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}

function showTime() {
	var type = document.getElementById("timeType").value;
	if (type == '1') {
		document.getElementById("times").style.display = "";
		document.getElementById("time").style.display = "none";
	} else {
		document.getElementById("times").style.display = "none";
		document.getElementById("time").style.display = "";
	}
}

function test(value) {
	/*var data = new L5.Map();
	var xzqu = value.nextSibling.innerHTML;
	data.put("cxsjq", cxsjq);
	data.put("cxsjz", cxsjz);
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/disability/query_disability_assdevices.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu;
	if (cxsjq != null) {
		parm+="&cxsjq="+cxsjq;
	}
	if (cxsjz != null) {
		parm+="&cxsjz="+cxsjz;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/disability/query_disability_assdevices.jsp"+parm;
	window.open(url);
}
function back() {
	history.go(-1);
}
// 打印预览调用方法
function printBill() {
	var printDataset = L5.DatasetMgr.lookup("ds");
	var url = L5.webPath + '/jsp/cams/bpt/query/print/disablity.fr3';
	var reportName = "山东省各类优抚对象人数统计表";

	doReportPrint(reportName, currentUserName, organName, printDataset, url);
}

/**
 * 取的行政区划（采用在表格每一行的第一列隐藏保存行政区划code）
 * @param {} obj
 */
function getOrganCode(obj) {
	return obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
}

function redirectQuery_dis(obj,typeValue) {
	var domicode = getOrganCode(obj);
	var url = "../bpt_people/disabilityAssDevices.jsp?autoQuery=true&timeType=" + timeType +
	"&organCode="+domicode ;
	if(timeType == "1") {
		url += "&startTime=" + cxsjq;
	}
	url +="&endTime=" + cxsjz;
	if(typeValue != "" && typeValue!= null) {
		url +="&assDevicesType=" + typeValue;	
	}
	window.open(url);
}