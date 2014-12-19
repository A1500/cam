function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("qReleaseDate").value=getCurDate().substring(0,7);
};

function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("qReleaseDate").value=getCurDate().substring(0,7);

}
function query() {
	var releaseDetailListDs = L5.DatasetMgr.lookup("releaseDetailListDs");
	releaseDetailListDs.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	releaseDetailListDs.setParameter("name", document
					.getElementById("familyName").value);
	releaseDetailListDs.setParameter("idCard", document
					.getElementById("familyCardNo").value);
	var releaseDate=document.getElementById("qReleaseDate").value;
	releaseDetailListDs.setParameter("releaseDate", releaseDate);
	releaseDetailListDs.setParameter("assistanceType", assistanceType);
	var domicileCode = document.getElementById("domicileCode").value;
	if(!domicileCode){
		domicileCode=organArea;
	}
	/*
	if (domicileCode.indexOf('000')>0) {
		releaseDetailListDs.setParameter("domicileCode",domicileCode.substring(0, domicileCode.indexOf('000')));
	} else {
		releaseDetailListDs.setParameter("domicileCode", domicileCode);
	}
	*/
	releaseDetailListDs.setParameter("domicileCode", domicileCode);
	releaseDetailListDs.setParameter("ifSpecial",ifSpecial);
	releaseDetailListDs.setParameter("releaseType","01");
	releaseDetailListDs.load();
	
    noReclick(releaseDetailListDs,"queryBtn");
}
function exportAllDetail(){
	var dataset = L5.DatasetMgr.lookup("releaseAllDetailDs");
	dataset.setParameter("name", document.getElementById("familyName").value);
	dataset.setParameter("idCard", document.getElementById("familyCardNo").value);
	var releaseDate=document.getElementById("qReleaseDate").value;
	if(!releaseDate){
		releaseDate=getCurDate().substring(0,7);
	    document.getElementById("qReleaseDate").value=releaseDate;
	}
	dataset.setParameter("releaseDate", releaseDate);
	dataset.setParameter("assistanceType", assistanceType);
	var domicileCode = document.getElementById("domicileCode").value;
	if(!domicileCode){
		domicileCode=organArea;
	}
	if (domicileCode.indexOf('000')>0) {
		dataset.setParameter("domicileCode",domicileCode.substring(0, domicileCode.indexOf('000')));
	} else {
		dataset.setParameter("domicileCode", domicileCode);
	}
	dataset.setParameter("ifSpecial",ifSpecial);
	dataset.load();
	if (releaseDetailListDs.getCount() < 1) {
		L5.Msg.alert("提示", "没有要导出的信息！");
		return;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1"; //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor; //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.getCmp("exportAllDetail").setDisabled(true);
	dataset.on("load",enableExportAllBtn);
	// //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(dataset,
			"/jsp/cams/drel/funds/release/samReleaseAllDetailExcel.jsp?releaseDate="+releaseDate+"&assistanceType="+assistanceType+"&domicileCode="+domicileCode);
	 dataset.baseParams["excelType"]="reset"; //重置导出类型
	 
}
//查看家庭成员明细-弹出列表网页对话框
function viewPeopleDetail(){
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDs");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要查看的家庭成员的信息！");
		return;
	}
	var name=document.getElementById("familyName").value;
	var idCard=document.getElementById("familyCardNo").value;
	var qReleaseDate=document.getElementById("qReleaseDate").value;
	var domicileCode = document.getElementById("domicileCode").value;
	if(!domicileCode){
		domicileCode=organArea;
	}
	if (domicileCode.indexOf('000')>0) {
		domicileCode=domicileCode.substring(0, domicileCode.indexOf('000'));
	} 
	var width = screen.width-100;
		    var height = 400;
	 var url="samReleasePeopleDetail.jsp?name="+name+"&idCard="+idCard+"&qReleaseDate="+qReleaseDate+"&domicileCode="+domicileCode+"&assistanceType="+assistanceType;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function enableExportAllBtn(ds){	
	ds.un("load",enableExportAllBtn);
	L5.getCmp("exportAllDetail").setDisabled(false);
}
function exportDetail() {
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDs");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	releaseDate=document.getElementById("qReleaseDate").value;
	if("01"==assistanceType){
		assitanceTypeText="城市低保";
	}else if("02"==assistanceType){
		assitanceTypeText="农村低保";	
	}else if("03"==assistanceType){
		assitanceTypeText="五保";	
	}else{
		assitanceTypeText="";	
	}
	var filename=releaseDate+assitanceTypeText+"发放明细";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
	
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
// 确认实施
function confirmReleaseSummary() {
	L5.MessageBox.confirm('确定', '确定要实施？', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
			command.setParameter("releaseId", releaseId);
			command.execute("executeSpecialPlan");
			if (!command.error) {
				colseWin();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function colseWin() {
	var parent = window.dialogArguments;
	parent.releaseSummaryListDs.reload();
	window.close();
}

function areaSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[1];
		document.getElementById("domicileCode").value = list[0];
	}
}