var currentOrganCode = organCode;// 当前机构代码

function init() {
	L5.Ajax.timeout = 300000;
	ds.on("load", showDiv);
	query();
	L5.QuickTips.init();
};
function showDiv() {
	document.getElementById("reDiv").style.display = "";
	window.parent.hideMsg();
}
// 查询
function query() {
	window.parent.showMsg();
    ds.setParameter("qOrganCode",currentOrganCode);
    ds.setParameter("qDisYear",disYear);
	ds.load();
}
// 下钻
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
//打开指定的url
function openUrls(value) {
	var organCode = value.nextSibling.innerHTML;
	var _url="../statistics/query/dcQueryList.jsp?organcode="+organCode+"&disYear=" + disYear;
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}

function exportexcel() {
	var dataset=L5.DatasetMgr.lookup("ds");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/statistics/reliefRequestSumsListSubExcel.jsp?reliefType="+reliefType);
}