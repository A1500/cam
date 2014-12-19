function init() {
document.getElementById("objectState").value = "2";
	L5.Ajax.timeout=300000;
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var belongDate = getParam("isGuarant");
	var isKoreanwar = getParam("isFiveGuarant");
	var domicileType = getParam("domicileType");
	var soldierStateCode = getParam("objectState");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);
	BaseinfoPeopleDataSet.setParameter("domicileType",domicileType);
	BaseinfoPeopleDataSet.setParameter("isGuarant",belongDate);	
	BaseinfoPeopleDataSet.setParameter("isFiveGuarant",isKoreanwar);	
	BaseinfoPeopleDataSet.setParameter("soldierStateCode",soldierStateCode);	
	BaseinfoPeopleDataSet.load();
	noReclick(BaseinfoPeopleDataSet,"queryButton");
}
function confirmValue(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectType = '81';
	var idCard = selected[0].get('ID_CARD');
	var name = selected[0].get('NAME');
	window.returnValue=peopleId+";"+objectType+";"+idCard+";"+name;
	window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("isGuarant").value = "";
	document.getElementById("isFiveGuarant").value = "";
	document.getElementById("domicileType").value = "";
}




function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var url='../../../dataCollection/bptcountretiredsoldier/bptcountretiredsoldierDetail.jsp?peopleId='+peopleId+'&familyId='+familyId;
	var width = screen.width-200;
    var height = screen.height-150;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}

/*
 * 通用帮助
 */
function forHelp(){
    var revalue=window.showModalDialog("../../../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}


