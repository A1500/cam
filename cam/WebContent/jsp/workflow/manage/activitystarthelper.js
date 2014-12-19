function init(){
  activityDefIdDst.baseParams["proDefId"]=beforeInit.proDefId;
  activityDefIdDst.baseParams["processId"]=processId;
  activityDefIdDst.load();
}

//确定
function queding(){
	var acts = document.getElementById("actDefId");
	var actValue =(acts.options[acts.selectedIndex]).value;
	if(!window.returnValue||window.returnValue.organs==";;;;;;"){
		L5.Msg.alert("提示：","参与者为空！");
		window.returnValue = null;
		return;
	}
	if(!actValue){
		L5.Msg.alert("提示：","未选中环节！");
		return;
	}
	window.returnValue.actDefUniqueId=actValue;
	window.close();
}
//取消
function quxiao(){
	window.returnValue = null;
	window.close();
}
function showOrgTree(){

	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=8&isExact=0&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		window.returnValue={};
		window.returnValue.organs=revalue;
		document.getElementById("organs").value=revalue.split(";")[1];
	}
}