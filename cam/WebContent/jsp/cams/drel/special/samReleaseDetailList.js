function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("qReleaseDate").value=getCurDate().substring(0,7);
	//救助项目加载
	samAssistanceItemDataset.setParameter("filterSql", "ITEM_TYPE='02' AND STATUS='1'  and area_code in "+" ( "+filterAreaCode+" )");//专项救助
	samAssistanceItemDataset.load();
}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("qReleaseDate").value=getCurDate().substring(0,7);

}
function query(){
	var releaseDetailListDs = L5.DatasetMgr.lookup("releaseDetailListDs");
	releaseDetailListDs.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	releaseDetailListDs.setParameter("name", document
					.getElementById("familyName").value);
	releaseDetailListDs.setParameter("idCard", document
					.getElementById("familyCardNo").value);
	var releaseDate=document.getElementById("qReleaseDate").value;
	releaseDetailListDs.setParameter("releaseDate", releaseDate);
	if(assistanceType=='null'||assistanceType==null){
		assistanceType=document.getElementById("assistanceType").value;
	
	}
	releaseDetailListDs.setParameter("assistanceType", document.getElementById("assistanceType").value);
	var domicileCode = document.getElementById("domicileCode").value;
	if (domicileCode) {
		
	} //不考虑省市
	if(domicileCode.indexOf('00000')>-1){
		releaseDetailListDs.setParameter("domicileCode",domicileCode.substring(0, 6));
	} else if(domicileCode.indexOf('000')>-1){
		releaseDetailListDs.setParameter("domicileCode",domicileCode.substring(0, 9));
	}else{
		releaseDetailListDs.setParameter("domicileCode",domicileCode);
	}
	
	releaseDetailListDs.setParameter("itemCode",document.getElementById('itemCodeQuery').value);
	releaseDetailListDs.setParameter("ifSpecial",ifSpecial);
	releaseDetailListDs.load();
}
function exportDetail(){
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDs");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	assistanceType=document.getElementById("assistanceType").value;	
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
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "合计总金额: "+formatMoney(value)+" 元";

}