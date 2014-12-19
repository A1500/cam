function init() {
L5.Ajax.timeout=300000;
	var time = new Date();
	var times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("timeType").value ='2';
	document.getElementById("cxsj_qs").value=timeq;
	document.getElementById("cxsj_zs").value=timez;
	document.getElementById("cxsj_z").value=timez;
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	L5.QuickTips.init();
};
function set(){
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01"
	document.getElementById("cxsj_qs").value=timeq;
	document.getElementById("cxsj_zs").value=time;
	document.getElementById("cxsj_z").value=time;
	document.getElementById("timeType").value ='2';
	document.getElementById("times").style.display = "none";
	document.getElementById("time").style.display = "";
}

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year1 = document.getElementById("cxsj_q").value.split("-")[0];
	var year2 = document.getElementById("cxsj_z").value.split("-")[0];
	if (year1 ==year2) {
		reportTitleSpan.innerHTML = getChnNumber(year1) + "年山东省各类优抚对象人数统计表";
	}else{
		reportTitleSpan.innerHTML =getChnNumber(year1)+"--"+getChnNumber(year2)+ "山东省各类优抚对象人数统计表";
	}
}

function getChnNumber(code) {
	if (code == undefined || code == "")
		return;
	var codeArr = code.split("");
	var reStr = "";
	for (var i = 0; i < codeArr.length; i++) {
		switch (codeArr[i]) {
			case '0' :
				reStr += "零";
				break;
			case '1' :
				reStr += "一";
				break;
			case '2' :
				reStr += "二";
				break;
			case '3' :
				reStr += "三";
				break;
			case '4' :
				reStr += "四";
				break;
			case '5' :
				reStr += "五";
				break;
			case '6' :
				reStr += "六";
				break;
			case '7' :
				reStr += "七";
				break;
			case '8' :
				reStr += "八";
				break;
			case '9' :
				reStr += "九";
				break;
			default :
				reStr += codeArr[i];
		}
	}
	return reStr;
}

function showTime() {
	var type = document.getElementById("timeType").value;
	if(type == '1'){
		document.getElementById("times").style.display ="";
		document.getElementById("time").style.display ="none";
	}else{
		document.getElementById("times").style.display ="none";
		document.getElementById("time").style.display ="";
	}
}

function query() {
	var type = document.getElementById("timeType").value;
	timeType = type;
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = _$("cxsj_qs");
		cxsj_z = _$("cxsj_zs")
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
	}else{
		cxsj_q ="";
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	ds.setParameter("cxsjq", cxsj_q);
	ds.setParameter("cxsjz",cxsj_z);
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton"); 
}

function test(value) {
	var data = new L5.Map();
var type = document.getElementById("timeType").value;
	var cxsj_q;
	var cxsj_z;
	
	if(type=='1'){
		cxsj_q = _$("cxsj_qs");
		cxsj_z = _$("cxsj_zs")
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
	}else{
		cxsj_q ="";
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	/*data.put("cxsjq",cxsj_q);
	data.put("cxsjz",cxsj_z);
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/statistics/query_YouFuTongJi.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu;
	if (cxsj_q != null) {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != null) {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/statistics/query_YouFuTongJi.jsp"+parm;
	window.open(url);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/youFuTongJi.fr3'; 
	var reportName="各类优抚对象人数统计表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}