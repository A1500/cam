function init() {
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ProvinceMigratDataSet.setParameter("domicileCode",getParam("domicileCode"));
	ProvinceMigratDataSet.setParameter("name",getParam("name"));
	ProvinceMigratDataSet.setParameter("idCard",getParam("idCard"));
	ProvinceMigratDataSet.setParameter("domicileType",getParam("domicileType"));	
	ProvinceMigratDataSet.setParameter("warTypeCode",getParam("warTypeCode"));	
	ProvinceMigratDataSet.setParameter("forcesNo",getParam("forcesNo"));	
	ProvinceMigratDataSet.setParameter("position",getParam("position"));	
	ProvinceMigratDataSet.setParameter("asdpNo",getParam("asdpNo"));	
	ProvinceMigratDataSet.setParameter("organCode",organCode);	
	ProvinceMigratDataSet.setParameter("warStateCode","2");	
	ProvinceMigratDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("warTypeCode").value = "";
	document.getElementById("forcesNo").value = "";
	document.getElementById("position").value = "";
	document.getElementById("asdpNo").value = "";
}


function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	
	var width = 800;
	var height = 500;
	var url=L5.webPath+'/jsp/cams/bpt/dataCollection/war/bptwarDetailMain.jsp?familyId='+familyId+'&peopleId='+peopleId;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

function  confirmValue(){
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

function closew(){
	window.returnValue="";
	window.close();
}

function clears(){
   window.returnValue=";;;;;;;"
   window.close();
}

/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog(L5.webPath+"/jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
