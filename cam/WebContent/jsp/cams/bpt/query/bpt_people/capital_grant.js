var orgName;
function init() {
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
		document.getElementById("cxsj_q").value = startTime;
		document.getElementById("cxsj_z").value = endTime;
		query();

	} else {
		var time = new Date();
		var times = time.format("Y");
		var timeq = times+"-01-01";
		var timez = times+"-12-31";
		document.getElementById("cxsj_q").value=timeq;
		document.getElementById("cxsj_z").value=timez;
		L5.QuickTips.init();
	}
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	return value;
}
function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if (cxsj_q != '' && !validateDateFormat(cxsj_q)) {
		L5.Msg.alert("提示", "查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if (cxsj_z != '' && !validateDateFormat(cxsj_z)) {
		L5.Msg.alert("提示", "查询结束时间格式不正确！");
		return false;
	}
	var ds = L5.DatasetMgr.lookup("BptCompulsoryDataSet");
	var domicileCode = getParam("domicileCode");
	if(domicileCode == null || domicileCode == "") {
		domicileCode = organCode;
	}
	ds.setParameter("organCode", domicileCode);
	ds.setParameter("name", getParam("name"));
	ds.setParameter("idCard", getParam("idCard"));
	ds.setParameter("startTime", getParam("cxsj_q"));
	ds.setParameter("endTime", getParam("cxsj_z"));
	ds.load();
	noReclick(ds,"queryButton"); 
}

/**
 * 导出excel
 */
function excel_export() {
	if(BptCompulsoryDataSet.getCount() == 0) {
		L5.Msg.alert("提示","没有要导出的数据");
		return false;
	}
	L5.dataset2excel(BptCompulsoryDataSet,"/jsp/cams/bpt/query/excel_export/capitalGrantExcel.jsp");
}

