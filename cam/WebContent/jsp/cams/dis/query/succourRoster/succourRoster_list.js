function init() {
//	document.getElementById("reliefType").value="DC";
	//document.getElementById("succourRoster").src="../succourRoster/lifeAssistanceWinterSpringList.jsp?batchDetailId=";
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	var url;
	var reliefType=document.getElementById("reliefType").value;
	var batchId=document.getElementById("batchId").value;
	if(document.getElementById("reliefType").value==''){
		L5.Msg.alert("提示","请选择救助类别!");
		return;
	}
	if(document.getElementById("batchId").value==''){
		L5.Msg.alert("提示","请选择救助批次!");
		return;
	}
	if(reliefType=='DC'){
		url="../succourRoster/lifeAssistanceWinterSpringList.jsp?batchDetailId="+batchId;
	}else if(reliefType=='YJ'){
		url="../succourRoster/yj_info_list.jsp?batchDetailId="+batchId;
	}else if(reliefType=='CJ'){
		url="../succourRoster/disasterReconstructionSubsidyList.jsp?batchDetailId="+batchId;
	}else if(reliefType=='GD'){
		url="../succourRoster/gd_info_list.jsp?batchDetailId="+batchId;
	}else if(reliefType=='SW'){
		url="../succourRoster/disasterDeathSolatiumList.jsp?batchDetailId="+batchId;
	}
	document.getElementById("succourRoster").src=url;
}
function onTypeSelect(){
	document.getElementById("batchName").value='';
	document.getElementById("batchId").value='';
}
/**
 * 选择住址行政区划窗口
 */
function forBatchSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/query/succourRoster/batch_list.jsp?reliefType="
					+ escape(encodeURIComponent(document.getElementById("reliefType").value))
					, "",
			"dialogHeight:500px;dialogWidth:1000px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("batchId").value = list[0];
		document.getElementById("batchName").value = list[1];
	}
}
