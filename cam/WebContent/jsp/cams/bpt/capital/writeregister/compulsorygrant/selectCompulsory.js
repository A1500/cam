function init() {
	L5.QuickTips.init();
}

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){	
	ds.setParameter("domicileCode",getParam("domicileCode"));
	ds.setParameter("name",getParam("name"));		
	ds.setParameter("sex",getParam("sex"));		
	ds.setParameter("idCard",getParam("idCard"));		
	ds.setParameter("nation",getParam("nation"));
	ds.setParameter("organCode",organCode);
	ds.load();
}

/**
 * 重置
 */
function reset(){
	document.getElementById("name").value = "";
	document.getElementById("sex").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("domicileCode").value = "";
}

function  confirmValue(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('ID');
	var idCard = selected[0].get('ID_CARD');
	window.returnValue=idCard+";"+peopleId;
	window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}

function clears(){
   window.returnValue=";;;;;;;"
   window.close();
}

/*
 * 通用帮助--行政区划
 */
function forHelp(){
//	var struId = document.getElementById("struId").value;
	var revalue=window.showModalDialog("../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}

