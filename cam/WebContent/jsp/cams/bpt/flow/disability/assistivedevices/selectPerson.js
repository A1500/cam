function init() {
	document.getElementById("disabilityStateCode").value = '2';
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	BptPeopleDisabilityDataSet.setParameter("domicileCode",getParam("domicileCode"));
	BptPeopleDisabilityDataSet.setParameter("name",getParam("name"));
	BptPeopleDisabilityDataSet.setParameter("idCard",getParam("idCard"));
	BptPeopleDisabilityDataSet.setParameter("domicileType",getParam("domicileType"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityStateCode",getParam("disabilityStateCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityTypeCode",getParam("disabilityTypeCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityLevelCode",getParam("disabilityLevelCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityCaseCode",getParam("disabilityCaseCode"));
	BptPeopleDisabilityDataSet.setParameter("disabilityGenusCode",getParam("disabilityGenusCode"));	
	BptPeopleDisabilityDataSet.setParameter("disabilityWarCode",getParam("disabilityWarCode"));	
	BptPeopleDisabilityDataSet.setParameter("organCode",organCode);	
	BptPeopleDisabilityDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("disabilityStateCode").value = "";
	document.getElementById("disabilityTypeCode").value = "";
	document.getElementById("disabilityLevelCode").value = "";
	document.getElementById("disabilityCaseCode").value = "";
	document.getElementById("disabilityGenusCode").value = "";
	document.getElementById("disabilityWarCode").value = "";
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
	var url=L5.webPath+'/jsp/cams/bpt/flow/disability/common/disabilityDetailCommon.jsp?familyId='+familyId+'&peopleId='+peopleId;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

function  confirmValue(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var name = selected[0].get('NAME');
	var sex = selected[0].get('SEX');
	var idCard = selected[0].get('ID_CARD');
	var disabilityTypeCode = selected[0].get('DISABILITY_TYPE_CODE');
	var disabilityLevelCode = selected[0].get('DISABILITY_LEVEL_CODE');
	var disabilityGenusCode = selected[0].get('DISABILITY_GENUS_CODE');
	var disabilityNo = selected[0].get('DISABILITY_NO');
	var telMobile = selected[0].get('TEL_MOBILE');
	var address = selected[0].get('ADDRESS');
	var disabilityBody = selected[0].get('DISABILITY_BODY');
	window.returnValue=peopleId+";"+name+";"+sex+";"+idCard+";"+disabilityTypeCode+";"
		+disabilityLevelCode+";"+disabilityGenusCode+";"+disabilityNo+";"+familyId+";"+disabilityBody+";"+address+";"+telMobile;
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
