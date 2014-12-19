function init() {
L5.Ajax.timeout=300000;
	set();
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	if(cxsjq!='null'&&cxsjz!='null'){
		document.getElementById("cxsj_q").value  = cxsjq;
		document.getElementById("cxsj_z").value  = cxsjz;
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	L5.QuickTips.init();
};
function set(){
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;
}
function showDiv() {
	document.getElementById("reDiv").style.display = "";
}


function getTime(time) {
	var times = time.split("-");
	time = times[0] + "." + times[1];
	return time;
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
		ds.setParameter("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		ds.setParameter("cxsjz",cxsj_z);
	}
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton"); 
}

function test(value) {
	var data = new L5.Map();
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	/*if (cxsj_q != '') {
		data.put("cxsjq",cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz",cxsj_z);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/bpt/query/statisticsIncrease/query_Increase.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu+"&pageflag=1";
	if (cxsj_q != null) {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != null) {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/statisticsIncrease/query_Increase.jsp"+parm;
	window.open(url);
}
function back() {
	history.go(-1);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/youFuTongJi.fr3'; 
	var reportName="新增优抚对象人数统计表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}