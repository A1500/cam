var currentOrganCode = organCode;// 当前机构代码
function init() {
	L5.Ajax.timeout=300000;
    ds.setParameter("xzqu",organCode);
    ds.setParameter("ffsjq",ffsj_q);
    ds.setParameter("ffsjz",ffsj_z);
	ds.on("load", showDiv);
	ds.load();
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	window.parent.hideMsg();
}
function setReportTitle() {
}
function getTime(time) {
	var times = time.split("-");
	time = times[0] + "." + times[1];
	return time;
}
//查询
function query() {
    ds.setParameter("xzqu",currentOrganCode);
    ds.setParameter("ffsjq",ffsj_q);
    ds.setParameter("ffsjz",ffsj_z);
	ds.load();
}
//手工返回
function back() {
//	alert(currentOrganCode+"-"+orgAreaCode)
	if (currentOrganCode.substring(0,2) == "BZ") {

	} else if(currentOrganCode == orgAreaCode) {
		currentOrganCode = organCode;
		query();
	}else if (currentOrganCode.substr(4) == "00000000") {
		currentOrganCode = organCode;
		query();
	} else if (currentOrganCode.substr(6) == "000000") {
		currentOrganCode = currentOrganCode.substring(0, 4) + "00000000";
		query();
	}
}
//下钻
function forDown(obj) {
	
	var rowIndex = obj.rowIndex - 3;// 索引位置
	var ds = L5.DatasetMgr.lookup("ds");
	var record = ds.getAt(rowIndex);
	var name = record.get("ORGAN_NAME"); // 点击的行政区划
	var code = record.get("ORGAN_CODE"); // 点击的行政区划
	if (code.substring(2) == "0000000000") {
		// 点击省级
	} else if (code.substring(4) == "00000000") {
		// 点击市级
		if (code == currentOrganCode) {
			// 如果当前显示和点击均为市级，则进入省级统计(对比登录人所属机构代码，是否可进入上级?)
			// alert(orgCode +"="+ code.substring(0,2)+"0000000000"+"="+(orgCode
			// <= code.substring(0,2)+"0000000000"))
			if (organCode <= code.substring(0, 2) + "0000000000") {
				currentOrganCode = code.substring(0, 2) + "0000000000";
				query();
			}
		} else {
			// 如果当前显示和点击不同，则进入市级统计
			currentOrganCode = code.substring(0, 4) + "00000000";
			query();
		}
	} else if (code.substring(6) == "000000") {
		// 点击县级
		if (code == currentOrganCode) {
			// 如果当前显示和点击均为县级，则进入市级统计(对比登录人所属机构代码，是否可进入上级?)
			if (organCode <= code.substring(0, 4) + "00000000") {
				currentOrganCode = code.substring(0, 4) + "00000000";
				query();
			}
		} else {
			// 如果当前显示和点击不同，则进入县级统计
			currentOrganCode = code.substring(0, 6) + "000000";
			query();
		}
	}
}

function exportexcel() {
	var dataset=L5.DatasetMgr.lookup("ds");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/statistics/reliefCaseSumsListSubExcel.jsp?reliefType="+reliefType);
}