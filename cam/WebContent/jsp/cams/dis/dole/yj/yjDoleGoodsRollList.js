var num1;
var num2;
var charges1=[];
var charges2=[];
function init() {
	if (batchDetailId != "" && batchDetailId != null) {
		infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		infoDs.load();
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				for(var i=0;i<infoDs.getCount();i++){
					doleDetailDs.setParameter("DOLE_ID", doleId);
					doleDetailDs.setParameter("INFO_ID", infoDs.getAt(i).get("infoId"));
					doleDetailDs.load();
				}
			}
		});
	}
}
window.onbeforeunload=function(){ 
         var parent=window.dialogArguments;
          var reliefDoleds=parent.reliefDoleds;
          reliefDoleds.reload();
}
function query() {
	infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	//infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ACCEPT_AREA_CODE", getParam("qAcceptAreaCode"));
	infoDs.load();
}
//确认
function confirm() {
	var editGrid = L5.getCmp('yjGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录发放!");
		return false;
	}
	var url = 'yjDoleGoodsRollEdit.jsp?batchId=' + batchId + '&batchDetailId='
			+ batchDetailId+'&infoId='+selected[0].get('infoId');
	var width = 900;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
function detail() {
	var editGrid = L5.getCmp('yjGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录发放!");
		return false;
	}
	var url = 'yjDoleGoodsRollEdit.jsp?ifDetail=1&batchId=' + batchId + '&batchDetailId='
			+ batchDetailId+'&infoId='+selected[0].get('infoId');
	var width = 900;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
function forExcel(){
	
}