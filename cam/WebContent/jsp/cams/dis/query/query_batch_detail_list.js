function init() {
	ds.setParameter("batchId",batchId);
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}


function query() {
	ds.setParameter("batchId",batchId);
	ds.setParameter("organCode",getParam("organcode"));
	ds.on("load", function() {
		var size = ds.getCount();
		if(size == 0) {
			L5.Msg.alert("提示", "暂无记录！");
		}
	})
	ds.load();
}

function detail() {
	var editGrid = L5.getCmp("editGridPanel");
	var selections = editGrid.getSelectionModel().getSelections();
	if(selections.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录");
		return;
	}
	
	var url = "jsp/cams/dis/assistance";
	var reliefType = selections[0].get("reliefType");
	var batchDetailId = selections[0].get("batchDetailId");
	switch(reliefType) {
	case "GD":
		url = url + "/gd_info/gd_info_list.jsp";
		break;
	case "YJ": 
		url = url + "/yj_info/yj_info_list.jsp";
		break;
	case "DC":
		url = url + "/lifeAssistanceWinterSpring/lifeAssistanceWinterSpringList.jsp"
		break;
	case "CJ":
		url = url + "/disasterReconstructionSubsidy/disasterReconstructionSubsidyList.jsp"
		break;
	case "SW":
		url = url + "/disasterDeathSolatium/disasterDeathSolatiumList.jsp";
		break;
	}
	
	var data = new L5.Map();
	data.put("batchDetailId",batchDetailId);
	data.put("isupdate", false);
	
	var text = "救灾明细信息";
	L5.forward(url,text,data);
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organcode").value = list[0];
		document.getElementById("organname").value = list[4];
	}
}

function back() {
	history.go(-1);
}




