function init() {
};

function  detail(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var serviceType = selected[0].get('SERVICE_TYPE');
	var url='contentPeopleDetail_list.jsp?peopleId='+peopleId+'&serviceType='+serviceType;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function query() {
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	ContentPeopleDataset.setParameter("name",name);
	ContentPeopleDataset.setParameter("idCard",idCard);
	if(domicileCode==undefined){
		ContentPeopleDataset.setParameter("organCode",organCode);
	}else{
		ContentPeopleDataset.setParameter("organCode",domicileCode);
	}
	ContentPeopleDataset.setParameter("query","query");//根据此参数判定是否要 分页
	ContentPeopleDataset.load();
	noReclick(ContentPeopleDataset,"queryButton"); 
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
}
function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];

	}
}
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ContentPeopleDataset");
	var url = L5.webPath+'/jsp/cams/bpt/edoc/print/content_list.fr3'; 
	var reportName="";
	
	doReportPrint(reportName,"fdfd","dfa",printDataset ,url);
}
 //打印预览调用方法
function printFront(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var contentNumName = selected[0].get('contentNumName');
	var printDataset=L5.DatasetMgr.lookup("dsProInfo");
	printDataset.setParameter("DOMICILE_CODE@=",organCode);
	printDataset.load();
	var url = L5.webPath+'/jsp/cams/bpt/peopleBasicInfo/table/dcover.fr3'; 
	
	doReportPrint("","","",dsProPrint ,url);
}

