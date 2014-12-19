function init() {
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	BaseinfoPeopleDataSet.setParameter("domicileCode",getParam("domicileCode"));
	BaseinfoPeopleDataSet.setParameter("name",getParam("name"));		
	BaseinfoPeopleDataSet.setParameter("idCard",getParam("idCard"));		
	BaseinfoPeopleDataSet.setParameter("forcesName",getParam("forcesName"));		
	BaseinfoPeopleDataSet.setParameter("soldierStartDate",getParam("soldierStartDate"));		
	BaseinfoPeopleDataSet.setParameter("soldierEndDate",getParam("soldierEndDate"));		
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);			
	BaseinfoPeopleDataSet.load();
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("forcesName").value = "";
	document.getElementById("soldierStartDate").value = "";
	document.getElementById("soldierEndDate").value = "";
} 

function confirmValue() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var idCard = selected[0].get('ID_CARD');
	var peopleId = selected[0].get('PEOPLE_ID');
	window.returnValue=idCard+":"+peopleId;
	window.close();
}

function closew() {
	window.returnValue="";
	window.close();
}

function clears() {
	window.returnValue=";;;;;;;"
    window.close();
}


/**
 * 属地行政区划窗口
 */
function forHelp(){
		var revalue=window.showModalDialog("../../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
function detail() {
 	var width = screen.width-100;
 	var height = screen.height-140;
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	
	var url = '../countRetiredSoldierDetail.jsp?familyId=' + familyId + '&peopleId='+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}