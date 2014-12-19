function init() {
	L5.Ajax.timeout=300000;
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("ffsj_q").value=timeq;
	document.getElementById("ffsj_z").value=timez;
    ds.setParameter("xzqu",organCode);
	ds.on("load", showDiv);
	if (ffsjq!='null'&&ffsjz!='null'){
		document.getElementById("ffsj_q").value  = ffsjq;
		document.getElementById("ffsj_z").value  = ffsjz;
		ds.setParameter("ffsjq", ffsjq);
		ds.setParameter("ffsjz", ffsjz);
		ds.load();
	}
	L5.QuickTips.init();
};
function pageReset(){
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("ffsj_q").value=timeq;
	document.getElementById("ffsj_z").value=timez;
	document.getElementById("reDiv").style.display = "none";
}
function query() { 
	var ffsj_q = _$("ffsj_q");
	if (ffsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(ffsj_q!=''&&!validateDateFormat(ffsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var ffsj_z = _$("ffsj_z");
	if (ffsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(ffsj_z!=''&&!validateDateFormat(ffsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	if (ffsj_q != '') {
		ds.setParameter("ffsjq", ffsj_q);
	}
	if (ffsj_z != '') {
		ds.setParameter("ffsjz", ffsj_z);
	}
	ds.setParameter("xzqu", organCode);
//	alert(ffsj_q+" "+ffsj_z+" "+organCode)
	ds.load();
	noReclick(ds,"queryButton"); 
}
function showDiv() {
//	alert(ds.getCount())
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
	var year = document.getElementById("ffsj_q").value.split("-")[0];
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
	var ffsj_q = _$("ffsj_q");
	var ffsj_z = _$("ffsj_z");
	var data = new L5.Map();
	if (ffsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(ffsj_q!=''&&!validateDateFormat(ffsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	if (ffsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(ffsj_z!=''&&!validateDateFormat(ffsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	
	if (ffsj_q != '') {
		data.put("ffsjq", ffsj_q);
	}
	if (ffsj_z != '') {
		data.put("ffsjz", ffsj_z);
	}
	
	var xzqu = value.nextSibling.innerHTML;
	
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "/jsp/cams/dis/statistics/condition_query_total.jsp";
	L5.forward(url, null, data);
}
 //打印预览调用方法
function printBill(){
	/*var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/page_total1.fr3'; 
	var reportName="资金情况统计总表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);*/
}

