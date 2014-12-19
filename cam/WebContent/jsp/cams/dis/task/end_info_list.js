var editGrid;
function init() {
	/*L5.DatasetMgr.lookup("ds").load();
	ds.baseParams["INFO_ID@="]=idField;**/
	L5.QuickTips.init();
	initPanel();
	query();
};
//根据类型显示panel
function initPanel(){
	var yjGridPanel=L5.getCmp('yjGridPanel');
	var swGridPanel=L5.getCmp('swGridPanel');
	var cjGridPanel=L5.getCmp('cjGridPanel');
	var gdGridPanel=L5.getCmp('gdGridPanel');
	var dcGridPanel=L5.getCmp('dcGridPanel');
	if(reliefType=="DC"){
		editGrid=dcGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(true);
	}else if(reliefType=="YJ"){
		editGrid=yjGridPanel;
		yjGridPanel.setVisible(true);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
	}else if(reliefType=="CJ"){
		editGrid=cjGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(true);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
	}else if(reliefType=="GD"){
		editGrid=gdGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(true);
		dcGridPanel.setVisible(false);
	}else if(reliefType=="SW"){
		editGrid=swGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(true);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
	}
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	amountds.setParameter("BATCH_DETAIL_ID@=",batchDetailId);	
	amountds.setParameter("RELIEF_TYPE@=",reliefType);
	amountds.setParameter("WORKFLOW_STATUS@!=",'4');
	amountds.load();
	
	ds.setParameter("I.BATCH_DETAIL_ID@=",batchDetailId);		
	ds.setParameter("I.RELIEF_TYPE@=",reliefType);		
	//ds.setParameter("OR@I.WORKFLOW_STATUS@=","3,4");
	ds.load();
}


function detail(){
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var url="";
	if(reliefType=="DC"){
		url="../assistance/lifeAssistanceWinterSpring/approveLifeAssistanceWinterSpringDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}else if(reliefType=="YJ"){
		url="../assistance/yj_info/approve_yj_info_detail.jsp?infoId="+selected[0].get("INFO_ID");
	}else if(reliefType=="CJ"){
		url="../assistance/disasterReconstructionSubsidy/approveDisasterReconstructionSubsidyDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}else if(reliefType=="GD"){
		url="../assistance/gd_info/approve_gd_info_detail.jsp?infoId="+selected[0].get("INFO_ID");
	}else if(reliefType=="SW"){
		url="../assistance/disasterDeathSolatium/approveDisasterDeathSolatiumDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}
	var width = 1024;
	var height = 768;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}


