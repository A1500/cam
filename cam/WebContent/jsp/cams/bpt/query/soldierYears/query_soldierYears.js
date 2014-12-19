function init() {
L5.Ajax.timeout=300000;
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

function test(value) {
	/*var data = new L5.Map();
	if (cxsjq != null) {
		data.put("cxsjq", cxsjq);
	}
	if (cxsjq != null) {
		data.put("cxsjz", cxsjz);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/statistics/query_YouFuTongJi.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu;
	if (cxsjq != null) {
		parm+="&cxsjq="+cxsjq;
	}
	if (cxsjz != null) {
		parm+="&cxsjz="+cxsjz;
	}
	var url = L5.webPath+"/jsp/cams/bpt/query/soldierYears/query_soldierYears.jsp"+parm;
	window.open(url);
}
function back() {
	history.go(-1);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/soldierYearTongJi.fr3'; 
	var reportName="山东省60岁老兵服役年限统计表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}

function redirectQuery(obj,year) {
	var  urlPage="query_soldierYearList.jsp";
	var timeType="2";
	
	if(cxsjq != "") {
		timeType="1";
	} 
	var domicode = obj.parentNode.cells[0].firstChild.innerHTML;
	var url = urlPage+"?autoQuery=true"+
	"&year=" + year + 
	"&timeType=" + timeType + "&cxsjz="+cxsjz+
	"&xzqh="+domicode;
	if(timeType == "1") {
		url += "&cxsjq=" + cxsjq;
	}
	window.open(url);
}