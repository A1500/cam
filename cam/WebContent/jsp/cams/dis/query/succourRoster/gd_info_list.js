function init() {
	ds.load();
	L5.QuickTips.init();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value == undefined || value=="") {
		value = "";
	}
	return value;
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
//	var data = new L5.Map();
//	data.put("method","DETAIL");
//	data.put("infoId",selected[0].get('infoId'));
//	var url='jsp/cams/dis/assistance/gd_info/gd_info_detail.jsp';
//	var text = '过渡性生活救助明细';
//	L5.forward(url,text,data);
	var pid = selected[0].get('infoId');
	var url='../../assistance/gd_info/gd_info_detail.jsp?method=DETAIL&infoId='+pid;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
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
		document.getElementById("acceptareacode").value = list[0];
		document.getElementById("acceptareaname").value = list[4];
	}
}
function exportExcel(){
}
function back(){
	
}



