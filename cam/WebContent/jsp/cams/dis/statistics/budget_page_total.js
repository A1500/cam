function init() {
L5.Ajax.timeout=300000;
/*var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;*/
    ds.setParameter("xzqu",organCode);
	ds.on("load", showDiv);
	//if(cxsjq!='null'&&cxsjz!='null'){
		/*document.getElementById("cxsj_q").value  = cxsjq;
		document.getElementById("cxsj_z").value  = cxsjz;
		ds.setParameter("cxsj_q", cxsjq);
		ds.setParameter("cxsj_z", cxsjz);*/
		ds.load();
	//}
	L5.QuickTips.init();
};
function pageReset(){
	/*var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;*/
	//document.getElementById("reDiv").style.display = "none";
}
/*function query() { 
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
}*/
function showDiv() {
	//setReportTitle();
	/*var length = ds.getCount();
	if (length == 0) {
		ds.newRecord({
					"organ_name" : "无信息",
					"mon_count" : 0,
					"capital_num" : 0,
					"capital_mon" : 0,
					"capital_mon" : 0,
					"compulsory_num" : 0,
					"compulsory_mon" : 0,
					"compulsory_avg_mon" : 0,
					"help_num" : 0,
					"help_mon" : 0,
					"help_avg_mon" : 0,
					"grant_num" : 0,
					"grant_mon" : 0,
					"grant_avg_mon" : 0
				});
	}*/
	document.getElementById("reDiv").style.display = "";
}
function setReportTitle() {
	/*var reportTitleSpan = document.getElementById("reportTitle");
	var year = document.getElementById("cxsj_q").value.split("-")[0];
	if (year == '') {
		reportTitleSpan.innerHTML = "资金情况统计总表";
	} else {
		reportTitleSpan.innerHTML ="资金情况统计总表";
	}*/

}

function getTime(time) {
	var times = time.split("-");
	time = times[0] + "." + times[1];
	return time;
}

function test(value) {
	/*var cxsj_q = _$("cxsj_q");
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
	
	if (cxsj_q != '') {
		data.put("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz", cxsj_z);
	}*/
	
	var xzqu = value.nextSibling.innerHTML;
	var data = new L5.Map();
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "/jsp/cams/dis/statistics/budget_query_total.jsp";
	L5.forward(url, null, data);
}
 //打印预览调用方法
function printBill(){
	/*var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/page_total1.fr3'; 
	var reportName="优抚资金情况统计总表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);*/
}

