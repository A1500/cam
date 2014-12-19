function init() {
	document.getElementById("disabilityStateCode").value = "2";
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	DependantDataset.setParameter("domicileCode",getParam("domicileCode"));
	DependantDataset.setParameter("name",getParam("name"));
	DependantDataset.setParameter("idCard",getParam("idCard"));
	DependantDataset.setParameter("domicileType",getParam("domicileType"));	
	DependantDataset.setParameter("disabilityStateCode",getParam("disabilityStateCode"));	
	DependantDataset.setParameter("dependantTypeCode",getParam("dependantTypeCode"));
	DependantDataset.setParameter("organCode",organCode);
	DependantDataset.setParameter("note",getParam("note"));
	DependantDataset.load();
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
	var objectType = '21';
	var idCard = selected[0].get('ID_CARD');
	var name = selected[0].get('NAME');
	window.returnValue=peopleId+";"+objectType+";"+idCard+";"+name;
	window.close();
}

function closew() {
	window.returnValue="";
	window.close();
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	
	var width = screen.width-200;
    var height = screen.height-270;
    var url=L5.webPath+'/jsp/cams/bpt/dataCollection/dependant/dependantDetailManage.jsp?familyId='+familyId+'&peopleId='+peopleId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

/**
 * 属地行政区划窗口
 */
function forHelp(){
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
