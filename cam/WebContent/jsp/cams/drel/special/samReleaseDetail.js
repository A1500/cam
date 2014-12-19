function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceType").value=assistanceType;
	query();
};
function query(){
	var releaseDetailListDs = L5.DatasetMgr.lookup("releaseDetailListDs");
	releaseDetailListDs.setParameter("NAME", document.getElementById("familyName").value);
	releaseDetailListDs.setParameter("ID_CARD", document.getElementById("familyCardNo").value);
	releaseDetailListDs.setParameter("ASSISTANCE_TYPE", document.getElementById("assistanceType").value);
	var domicileCode = document.getElementById("domicileCode").value;
	if (domicileCode) {
		domicileCode=organArea;
	}
	//不考虑省市
	if(domicileCode.indexOf('00000')>-1){
		releaseDetailListDs.setParameter("DOMICILE_CODE@like",domicileCode.substring(0, 6));
	} else if(domicileCode.indexOf('000')>-1){
		releaseDetailListDs.setParameter("DOMICILE_CODE@like",domicileCode.substring(0, 9));
	}else{
		releaseDetailListDs.setParameter("DOMICILE_CODE",domicileCode);
	}
	releaseDetailListDs.setParameter("RELEASE_ID",releaseId);
	releaseDetailListDs.setParameter("dir", "ASC");
	releaseDetailListDs.setParameter("sort", "DOMICILE_CODE");
	releaseDetailListDs.load();
}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
}
function exportDetail(){
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDs");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var assistanceType=document.getElementById("assistanceType").value;	
	if("01"==assistanceType){
		assitanceTypeText="城市低保";
	}else if("02"==assistanceType){
		assitanceTypeText="农村低保";	
	}else if("03"==assistanceType){
		assitanceTypeText="五保";	
	}else{
		assitanceTypeText="";	
	}
	var filename=releaseDate+assitanceTypeText+"专项补贴明细";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//确认实施
function confirmReleaseSummary(){
	L5.MessageBox.confirm('确定', '确定要实施？',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
			command.setParameter("releaseId", releaseId);
			command.execute("executeSpecialPlan");
			if (!command.error) {
				colseWin();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function colseWin(){
	var parent=window.dialogArguments;
	parent.releaseSummaryListDs.reload();
	window.close();
}

// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}