function init() {
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01"
	var timez = times+"-12-31";
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
			L5.Msg.alert("提示","批准起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '批准截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","批准截止时间格式不正确！");
			return false;
		}
	}else{
		cxsj_q ="";
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '批准截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","批准截止时间格式不正确！");
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
	var cxsj_q ;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = _$("cxsj_qs");
		cxsj_z = _$("cxsj_zs")
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '批准起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","批准起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '批准截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","批准截止时间格式不正确！");
			return false;
		}
	}else{
		cxsj_q = ""; 
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '批准截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","批准截止时间格式不正确！");
			return false;
		}
		
	}
	/*data.put("cxsjq",cxsj_q);
	data.put("cxsjz",cxsj_z);
	data.put("timeType",type);
	
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/disability/query_disability_assdevices.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu+"&timeType="+type;
	if (cxsj_q != null) {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != null) {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/disability/query_disability_assdevices.jsp"+parm;
	window.open(url);
}
function back() {
	history.go(-1);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/disability_assdevices.fr3'; 
	var reportName="残疾人员辅助器械发放情况";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}

/**
 * 取的行政区划（采用在表格每一行的第一列隐藏保存行政区划code）
 * @param {} obj
 */
function getOrganCode(obj) {
	return obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
}

function redirectQuery_dis(obj,typeValue) {
	var timeType = document.getElementById("timeType").value;
	var endTime;
	var domicode = getOrganCode(obj);
	var url = "../bpt_people/disabilityAssDevices.jsp?autoQuery=true&timeType=" + timeType +
	"&organCode="+domicode ;
	if(timeType == "2") {
		endTime = document.getElementById("cxsj_z").value;
	} else if(timeType == "1") {
		endTime = document.getElementById("cxsj_zs").value;
		url += "&startTime=" + document.getElementById("cxsj_qs").value;
	}
	url +="&endTime=" + endTime;
	if(typeValue != "" && typeValue!= null) {
		url +="&assDevicesType=" + typeValue;	
	}
	window.open(url);
}