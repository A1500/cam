function init(){
	L5.QuickTips.init();
}
function queryItem(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("m_cnName",_$("m_cnName"));
	somOrganDataSet.setParameter("m_sorgCode",_$("m_sorgCode"));
	somOrganDataSet.setParameter("sorgStatus",_$("sorgStatus"));
	somOrganDataSet.setParameter("cnName",_$("cnName"));
	somOrganDataSet.setParameter("sorgCode",_$("sorgCode"));
	somOrganDataSet.setParameter("morgName",_$("morgName"));
	somOrganDataSet.setParameter("sorgType","S");
	somOrganDataSet.load();
}
function detail(){
	var url ;
	var text = "分支（代表）明细";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var sorgId = record.get("SORG_ID");
	var sorgStatus = record.get("SORG_STATUS");
	var width = 800;
	var height = 500;
	url = "groupBranchQuery.jsp?sorgId="+sorgId+"&sorgStatus="+sorgStatus;
	var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog(rootPath+"jsp/bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=11,12,13&isExact=1&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("morgArea").value = list[0];
		document.getElementById("morgName").value = list[1];
	}
}