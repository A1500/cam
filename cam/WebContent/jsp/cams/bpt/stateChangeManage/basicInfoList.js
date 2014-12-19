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
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var ageBegin = getParam("ageBegin");
	var ageEnd = getParam("ageEnd");
	var objectState = getParam("objectState");
	var objectType = getParam("objectType");
	
	BPTObjectInfoDataSet.setParameter("domicileCode",domicileCode);
	BPTObjectInfoDataSet.setParameter("name",name);
	BPTObjectInfoDataSet.setParameter("idCard",idCard);
	BPTObjectInfoDataSet.setParameter("ageBegin",ageBegin);
	BPTObjectInfoDataSet.setParameter("ageEnd",ageEnd);
	BPTObjectInfoDataSet.setParameter("objectState",objectState);
	BPTObjectInfoDataSet.setParameter("objectType",objectType);
	BPTObjectInfoDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
}

function changeState(){
	var basicInfoGrid=L5.getCmp('basicInfoGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectState = selected[0].get('OBJECT_STATE')
	var objectType = selected[0].get('OBJECT_TYPE');
	
	var data = new L5.Map();
	data.put("peopleId",peopleId);
	data.put("objectState",objectState);
	data.put("objectType",objectType);
	
	var url='jsp/cams/bpt/stateChangeManage/stateChangeInsert.jsp';
	var text = '修改优抚对象状态';
	L5.forward(url,text,data);

}

function disabilityDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看！");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	alert(peopleId);
	var familyId = selected[0].get('FAMILY_ID');
	/*var name = selected[0].get('name');
	alert(name);
	var idCard = selected[0].get('idCard');
	alert(idCard);
	var url='disabilityDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&name='+name+'&idCard='+idCard;
	var width = screen.width-500;
	var height = screen.height-250;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}*/
}

