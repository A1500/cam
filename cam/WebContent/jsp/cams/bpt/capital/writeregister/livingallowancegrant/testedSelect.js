function init() {
	document.getElementById("warStateCode").value = "2";
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
	BaseinfoPeopleDataSet.setParameter("domicileType",getParam("domicileType"));		
	BaseinfoPeopleDataSet.setParameter("warStateCode",getParam("warStateCode"));		
	BaseinfoPeopleDataSet.setParameter("forcesNo","");		
	BaseinfoPeopleDataSet.setParameter("testedType","");		
	BaseinfoPeopleDataSet.setParameter("disabilityLevelCode",getParam("disabilityLevelCode"));
	BaseinfoPeopleDataSet.setParameter("note",getParam("note"));	
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);			
	BaseinfoPeopleDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("disabilityStateCode").value = "";
	document.getElementById("dependantTypeCode").value = "";
	document.getElementById("note").value = "";
} 

function confirmValue() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectType = '61';
	var idCard = selected[0].get('ID_CARD');
	var name = selected[0].get("NAME");
	window.returnValue=peopleId+";"+objectType+";"+idCard+";"+name;
	window.close();
}

function closew() {
	window.returnValue="";
	window.close();
}

/**
 * 属地行政区划窗口
 */
function forHelp(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
