var orgName;
function init() {
	
	/*sipTime('');
	ifquery();*/
	if (autoQuery == "true") {
		if (query_organCode != null && query_organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", query_organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				document.getElementById("domicileName").value = fullName;
			}
		}
		document.getElementById("domicileCode").value = query_organCode;
		 
		sipSelect("timeType", query_timeType);
		sipSelect("assDevicesType", assDevicesType);
		sipSelect("configuration", configuration);
		document.getElementById("cxsj_qs").value = startTime;
		document.getElementById("cxsj_zs").value = endTime;
		document.getElementById("cxsj_z").value = endTime;
		showTime();

		query();

	} else {
		var time = new Date();
		var times = time.format("Y");
		var timeq = times + "-01-01";
		var timez = times + "-12-31";
		document.getElementById("cxsj_qs").value = timeq;
		document.getElementById("cxsj_zs").value = timez;
		document.getElementById("cxsj_z").value = timez;
		
		L5.QuickTips.init();
	}
	
}
/**
 * 时间查询条件赋值以及初始化
 * @param {} id
 */
/*function sipTime(id) {
	var selects = document.getElementById(id+"timeType");
	for(var i=0;i<selects.length;i++) {
		if(selects[i].value == query_timeType) {
			selects[i].selected = true;
			break;
		}
	}
	document.getElementById(id+"cxsj_qs").value=query_startTime;
	document.getElementById(id+"cxsj_zs").value=query_endTime;
	document.getElementById(id+"cxsj_z").value=query_endTime;
	
	showTime(id);
}*/

/**
 * 是否自动查询
 */
/*function ifquery() {
	if (autoQuery != null && autoQuery == "true") {
		document.getElementById("soldierYear").value=query_year;
		document.getElementById("domicileCode").value = query_organCode;
		document.getElementById("domicileName").value = queryOrganName();
		sipTime('');
		query();
	}
}*/
function sipSelect(eId, typeValue) {
	var selected = document.getElementById(eId);
	for (var i = 0; i < selected.length; i++) {
		if (selected[i].value == typeValue) {
			selected[i].selected = true;
		}
	}
}
function export_excel() {
	if (BptPeopleDisabilityDataSet.getCount() < 1) {
		alert("没有数据导出");
		return;
	}
	L5.dataset2excel(BptPeopleDisabilityDataSet,"/jsp/cams/bpt/query/excel_export/disabilityAssExportExcel.jsp");

}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	return value;
}
function query() {
	var domicileCode = _$("domicileCode");
	if (domicileCode == '' || domicileCode == null) {
		domicileCode = organCode;
	}
	var cxsj_q;
	var cxsj_z;

	var type = document.getElementById("timeType").value;
	if (type == '1') {
		cxsj_q = document.getElementById("cxsj_qs").value;
		cxsj_z = document.getElementById("cxsj_zs").value;
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if (cxsj_q != '' && !validateDateFormat(cxsj_q)) {
			L5.Msg.alert("提示", "查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if (cxsj_z != '' && !validateDateFormat(cxsj_z)) {
			L5.Msg.alert("提示", "查询结束时间格式不正确！");
			return false;
		}
	} else if (type == '2') {
		cxsj_q = "";
		cxsj_z = document.getElementById("cxsj_z").value;
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if (cxsj_z != '' && !validateDateFormat(cxsj_z)) {
			L5.Msg.alert("提示", "审批截止时间格式不正确！");
			return false;
		}
	}
	var ds = L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	ds.setParameter("organCode", domicileCode);
	ds.setParameter("name", getParam("name"));
	ds.setParameter("idCard", getParam("idCard"));
	ds.setParameter("startTime", cxsj_q);
	ds.setParameter("endTime", cxsj_z);
	ds.setParameter("configuration", getParam("configuration"));
	ds.setParameter("assDevicesType", getParam("assDevicesType"));
	ds.load();
	noReclick(ds,"queryButton");  
}

function emport() {

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
