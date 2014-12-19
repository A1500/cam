function init(){
	var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
	ensureToClientDataSet.load();
}
function query(){
	var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
	ensureToClientDataSet.load();
}

function importEnsureInfo(){
	var importWin = L5.getCmp("importWin");
	importWin.show();
}
function importXml(){
	var filePath = document.getElementById("xmlFilePath").value; 
	var command = new L5.Command("com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientCmd");
	command.setParameter("filePath",filePath);
	command.execute("importXML");
	if(!command.error){
		L5.Msg.alert("提示","导入成功！");
		closeWin();
		init();
	}else{
		L5.Msg.alert("提示","导入失败！"+command.error);
	}
}
function closeWin(){
	var importWin = L5.getCmp("importWin");
	importWin.hide();
}

//function importEnsureInfo(){
//	var grid=L5.getCmp("grid");
//	var records=grid.getSelectionModel().getSelections();
//	if(records.length==0){
//		L5.Msg.alert("提示","请至少先选中一行!");
//		return;
//	}
//	
//	var command = new L5.Command("com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientCmd");
//	command.setParameter("record",records[0]);
//	command.execute("createXML");
//	if(!command.error){
//		L5.Msg.alert("提示","导入成功！");
//	}else{
//		L5.Msg.alert("提示","导入失败！"+command.error);
//	}
//}
//链接明细
function editHref(value,cellmeta,record,rowindex,colindex,dataset){
		return 	'<a href="javascript:detail(\''+record.get("AREA_NAME")+','+record.get("FEEDBACK_TIME")+'\')">'+value+'</a>';
}
function detail(value){
	var  str = value.split(",");
	var url='commPeopleInfoDetail.jsp?&areaName='+encodeURIComponent(encodeURIComponent(str[0]))+'&feedbackTime='+str[1];
//	var width = screen.availWidth;
//    var height = screen.availHeight;
	var width = 1000;
    var height = 400;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}

function feedBackDetail(){
	var url='feedBackInfoDetail.jsp';
	var width = screen.availWidth;
    var height = screen.availHeight;
//	var width = 1000;
//    var height = 400;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}