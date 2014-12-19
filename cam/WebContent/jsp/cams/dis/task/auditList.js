function init() {
	/*L5.DatasetMgr.lookup("ds").load();
	ds.baseParams["INFO_ID@="]=idField;**/
	
	document.getElementById("requiredOrganCode").value=organCode;
	document.getElementById("requiredOrganName").value=organName;
	query();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function resetClick() {
	document.getElementById("requiredOrganCode").value=organCode;
	document.getElementById("requiredOrganName").value=organName;
	document.getElementById("reliefType").value='';
}
function query(){
	var fillState='';
	batchDetailds.setParameter("requiredOrganCode",getParam("requiredOrganCode"));	
	batchDetailds.setParameter("organCode",organCode);		
	batchDetailds.setParameter("T.RELIEF_TYPE@=",getParam("reliefType"));	
	if(getParam("fillState")){
		fillState=getParam("fillState");
		batchDetailds.setParameter("OR@FILL_STATE@=",fillState);	
		batchDetailds.load();
	}else {
		if(organType == 13){
			batchDetailds.setParameter("OR@FILL_STATE@=",'2,3');	
			batchDetailds.load();
		}else if(organType == 14){
			batchDetailds.setParameter("OR@FILL_STATE@=",'0,1,4,3,2');	
			batchDetailds.load();
		}
	}
	
}

function deal(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var url="";
	if(organType == 13){
		if(selected[0].get("FILL_STATE")=='2'){//1:正在填报,
			url="db_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID")+"&batchState="+selected[0].get("FILL_STATE");
		}else if(selected[0].get("FILL_STATE")=='3'){
			var url="end_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
		}
	}else if(organType == 14){
		if(selected[0].get("FILL_STATE")=='0'||selected[0].get("FILL_STATE")=='1'){//0:未填报,1:正在填报,
			if(selected[0].get("RELIEF_TYPE")=='DC'){
				url="../assistance/lifeAssistanceWinterSpring/lifeAssistanceWinterSpringList.jsp?batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
			}else if(selected[0].get("RELIEF_TYPE")=='YJ'){
				url="../assistance/yj_info/yj_info_list.jsp?batchDetailId="+selected[0].get("BATCH_DETAIL_ID")+"&isupdate=true&method=DETAIL";
			}else if(selected[0].get("RELIEF_TYPE")=='GD'){
				url="../assistance/gd_info/gd_info_list.jsp?batchDetailId="+selected[0].get("BATCH_DETAIL_ID")+"&isupdate=true&method=DETAIL";
			}else if(selected[0].get("RELIEF_TYPE")=='CJ'){
				url="../assistance/disasterReconstructionSubsidy/disasterReconstructionSubsidyList.jsp?batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
			}else if(selected[0].get("RELIEF_TYPE")=='SW'){
				url="../assistance/disasterDeathSolatium/disasterDeathSolatiumList.jsp?batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
			}
		}else if(selected[0].get("FILL_STATE")=='2'){//2:填报完成,
			var url="yb_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
		}else if(selected[0].get("FILL_STATE")=='3'){//3:已审批,
			var url="end_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
		}else {//,4:补齐补正,
			url="db_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID")+"&batchState="+selected[0].get("FILL_STATE");
		}
	}
	var width = 1024;
	var height = 768;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
   	query();
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			"../assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value=list[4];
		document.getElementById("requiredOrganCode").value=list[0];
	}
}


