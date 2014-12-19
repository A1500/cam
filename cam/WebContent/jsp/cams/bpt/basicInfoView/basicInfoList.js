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

function detail(){
	var basicInfoGrid=L5.getCmp('basicInfoGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE')
	var objectType = selected[0].get('OBJECT_TYPE');
	var url='basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-200;
	var height = screen.height-200;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

//点击姓名打开明细页面
function bptDetailHref(defaultValue,cell,record){
	var width = screen.width-200;
	var height = screen.height-200;
	if(defaultValue=="")
		defaultValue="---";
	var url = "basicInfoDetail.jsp?peopleId="+record.get("PEOPLE_ID")+"&familyId="+record.get("FAMILY_ID")+"&objectState="+record.get("OBJECT_STATE")+"&objectType="+record.get("OBJECT_TYPE");
	
	return "<a href='#' style='color:blue' onclick='openWindow(\""+url+"\")'>"+defaultValue+"</a>";
}

function openWindow(url){
        var width = screen.width-200;
		var height = screen.height-200;

		var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");

		if (win == null) {
			return;
		}
}
