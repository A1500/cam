function init(){
	menuTypeDs.load();
}
function confirmValue(){
	var grid = L5.getCmp("menuTypeGridPanel");
	var selected = grid.getSelectionModel().getSelections();
	
	if(selected.length == 0){
		L5.Msg.alert("提示","请选择菜单类型");
		return;
	}
	
	window.returnValue = selected[0].get("menuTypeId") + ";" + selected[0].get("menuTypeName");
	window.close();
}

function closew(){
	window.returnValue = "";
	window.close();
}

function clears(){
	window.returnValue = ";";
	window.close();
}