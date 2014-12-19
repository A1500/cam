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
		document.getElementById("cxsj").value = cxsj;
		//document.getElementById("cxsj_z").value = endTime;
		
	ds.setParameter("domicileCode", query_organCode);
	ds.setParameter("cxsj", cxsj);
	ds.setParameter("buildState", buildState);
	ds.setParameter("buildingapproach", buildingapproach);
	ds.setParameter("approval", approval);
	ds.setParameter("prepareNum", prepareNum);
	ds.setParameter("bedNum", bedNum);
	ds.setParameter("totalFunds", totalFunds);
	ds.setParameter("countyfunds", countyfunds);
	ds.setParameter("cityfunds", cityfunds);
	ds.setParameter("aboveCityfunds", aboveCityfunds);
	ds.setParameter("specialassistance", specialassistance);
	ds.setParameter("otherNum", otherNum);
	ds.setParameter("careRotation", careRotation);
	ds.setParameter("gloryroom", gloryroom);
	ds.setParameter("carePeople", carePeople);
	ds.load();
	noReclick(ds,"queryButton"); 

	} else {
		var time = new Date();
		var times = time.format("Y");
		document.getElementById("cxsj").value=times;
		//document.getElementById("cxsj_z").value=timez;
	}
	L5.QuickTips.init();
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	return value;
}
function query() {
	var cxsj = _$("cxsj");
	if (cxsj == '') {
		L5.Msg.alert('提示', '查询时间不能为空！');
		return false;
	}
	var ds = L5.DatasetMgr.lookup("ds");
	var domicileCode = getParam("domicileCode");
	if(domicileCode == null || domicileCode == "") {
		domicileCode = organCode;
	}
	ds.setParameter("domicileCode", domicileCode);
	ds.setParameter("cxsj", getParam("cxsj"));
	ds.setParameter("unitFullname", getParam("unitFullname"));
	ds.setParameter("buildState", getParam("buildState"));
	ds.setParameter("buildingapproach", getParam("buildingapproach"));
	ds.setParameter("approval", getParam("approval"));
	ds.load();
	noReclick(ds,"queryButton"); 
}

/**
 * 导出excel
 */
function excel_export() {
	var ds=L5.DatasetMgr.lookup("ds");	
	if(ds.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(ds,"/jsp/cams/bpt/query/institution/gloriousQueryExcel.jsp?statisticsTime="+ds.get("years"));
	ds.baseParams["excelType"]="reset"; //重置导出类型
}

