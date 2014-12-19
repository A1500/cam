function init() {
	if(batchDetailId!=""&&batchDetailId!=null){
		ds.setParameter("batchDetailId",batchDetailId);
		ds.load();
	}//初始化查询
	
};
/**
 * 明细按钮
 */
function detail(){
	var editGrid=L5.getCmp('disasterReconstructionSubsidyGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录明细!");
		return false;
	}
	var cx_infoId = selected[0].get('INFO_ID');
	var cx_recordId = selected[0].get('RECORD_ID');
	var url='../../assistance/disasterReconstructionSubsidy/disasterReconstructionSubsidyDetail.jsp?cx_infoId='+cx_infoId+'&cx_recordId='+cx_recordId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}
/**
 * 返回按钮
 */
function undo(){
	history.go(-1);
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("cx_villiageCode").value=list[0];
		document.getElementById("areaName").value=list[4];
	}
}

function printPeople(){
	var editGrid = L5.getCmp('disasterReconstructionSubsidyGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length<1) {
		L5.Msg.alert('提示', "请选择所要打印的记录!");
		return false;
	}
	var url = "peoplePrint.jsp?docPath=peoplePrint.doc";
	var text = '名册打印';
	var width = 1024;
	var height = 768;
	var ifPrint = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}
function exportExcel(){
}
function getPrintDataByDataSet(reportName,printDataset){
		var dqsj=new Date();
		var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
		xmlStr+="<Report ReportName='灾区民房恢复重建补助' Creater='" +dqsj+"' >";
		var records=printDataset.getAllRecords();
		var n=records.length;
		if(records.length==0){return;}
		for(i=0;i<n;i++){
			xmlStr +="<Info>";
			L5.each(records[i].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";});
			xmlStr +="</Info>";
		}
		xmlStr +="</Report>";
		return xmlStr;
}











