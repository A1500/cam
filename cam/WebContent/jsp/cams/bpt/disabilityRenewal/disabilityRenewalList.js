function init() {
	document.getElementById("disabilityStateCode").value = "2";
	document.getElementById("haveRenewal").value = "0";
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	//BptPeopleDisabilityDataSet.setParameter("domicileCode",getParam("domicileCode"));
	BptPeopleDisabilityDataSet.setParameter("name",getParam("name"));
	BptPeopleDisabilityDataSet.setParameter("idCard",getParam("idCard"));
	BptPeopleDisabilityDataSet.setParameter("stateCode",getParam("disabilityStateCode"));	
	BptPeopleDisabilityDataSet.setParameter("organCode",getParam("domicileCode")==undefined?organCode:getParam("domicileCode"));	
	BptPeopleDisabilityDataSet.setParameter("haveRenewal",getParam("haveRenewal"));
	//BptPeopleDisabilityDataSet.setParameter("phoneticCode",getParam("phoneticCode"));
	BptPeopleDisabilityDataSet.load();
	noReclick(BptPeopleDisabilityDataSet,"queryButton"); 
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("disabilityStateCode").value = "";
	document.getElementById("haveRenewal").value = "";
	//document.getElementById("phoneticCode").value = "";
}

function print(){
	var userGrid=L5.getCmp('editGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	if(selected[0].get("ISNEWAL")=="1"){
		alert("此伤残军人已经打过证书!");
	}
	var peopleId = selected[0].get("PEOPLE_ID");
	var url="disabilityInfoWrite.jsp?peopleId="+peopleId;
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
    query();
}


/**
 * 打印
 */
/*function print(){
	var userGrid=L5.getCmp('editGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	var peopleId = selected[0].get("PEOPLE_ID");
	openPrint(peopleId,"11");
	
}*/
		

		
/*function openPrint(peopleId,objectType) {
	var docpath;
	if(objectType == 11){//残疾军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
		
	}
	
	document.getElementById("docpath").value=docpath;
	var ements = document.getElementsByName("printQuery");
	for(var i=0;i<ements.length;i++) {
		var obj = ements[i];
		if(obj.getAttribute("queryData") == "queryData") {
			var idValue = obj.getAttribute("id");
			if(idValue == "peopleId") {
				obj.value = peopleId;
			} else if(idValue == "objectType") {
				obj.value = objectType;
			}
		}
	}
	document.getElementById("bptQueryPathServiceType").value=objectType;
	
	var url="../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}*/

/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13,14&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
/**
 * 所属机构窗口
 */
function  strToUpp(){
   document.getElementById("phoneticCode").value = document.getElementById("phoneticCode").value.toUpperCase(); 
}
function  ett(){
   var url=L5.webPath+"/jsp/cams/bpt/excelToTable/disability/ErrMessage.jsp";
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	} 
	return win;
}