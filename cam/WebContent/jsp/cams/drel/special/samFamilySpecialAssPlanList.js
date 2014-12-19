var organFlg='02';
function init() {
	specialAssistanceItemDs.setParameter("filterSql"," IN_USE='1' AND AREA_CODE='"+organArea+"' ");
	specialAssistanceItemDs.load();
	document.getElementById("releaseAreaName").value=organName;
	document.getElementById("releaseAreaCode").value=organArea;
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function detailRender(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get('releaseId')+'\',\''+ record.get('releaseDate')+'\',\''+ record.get('assistanceType') + '\')">'
			+ value + '</a>';
}
function query(){	
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.IS_SPECIAL@=","1");		
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_AREA_CODE@=",getParam("releaseAreaCode"));		
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_DATE@=",getParam("releaseDate"));	
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.REG_ID@=",organId);
	releaseSummaryListDs.setParameter("dir", "ASC");
	releaseSummaryListDs.setParameter("sort", "RELEASE_AREA_CODE");
	releaseSummaryListDs.load();
}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("releaseAreaName").value=organName;
	document.getElementById("releaseAreaCode").value=organArea;
}
//新增救助计划
function openReleaseSummaryWin(){
	var releaseSummaryDs = L5.DatasetMgr.lookup("releaseSummaryDs");
	releaseSummaryDs.removeAll();
	releaseSummaryDs.newRecord({"releaseStatus":"00","regAreaCode":organArea,releaseWay:"01","regAreaCode":organArea,"releaseAreaCode":organArea,"releaseAreaName":organName});//默认状态为名册生成中
	var win = L5.getCmp("releaseSummaryWin");
	win.show();
}
//保存救助计划
function saveReleaseSummary(){
	var valid=releaseSummaryDs.isValidate(true);
	if(valid!=true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	var releaseSummaryRecord = releaseSummaryDs.getCurrent();
	releaseSummaryRecord.set("releaseType","1");
	releaseSummaryRecord.set("feedbackStatus","01");
	releaseSummaryRecord.set("isSpecial","1");
//	releaseSummaryRecord.set("releaseAreaCode","370103000000");
	var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
	command.setParameter("SamReleaseSummaryRecord", releaseSummaryRecord);
	command.execute("insertSpecialPlan");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功！",function(){
			closeReleaseSummaryWin();
			L5.MessageBox.confirm('提示', '是否维护名册？',function(state){
				if(state=="yes"){
					releaseSummaryRecord.set("releaseId",command.getReturn("releaseId"));
					openChoosePeoWin(releaseSummaryRecord);
				}else{
					return false;
				}
			});
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//关闭增加窗口
function closeReleaseSummaryWin(){
	var win = L5.getCmp("releaseSummaryWin");
	win.setVisible(false);
	query();
}
//选择救助对象按钮方法
function chooseAssPeople(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("releaseStatus")==organFlg){
		L5.Msg.alert('提示',"名册已确认，不能继续维护!");
		return false;
	}
	openChoosePeoWin(selected[0]);
}
function openChoosePeoWin(rec){
var width = screen.width-200;
    var height = 492;
	var url = "samReleaseDetailEdit.jsp?releaseId="+rec.get('releaseId')+"&assistanceType="+rec.get("assistanceType")+"&releaseDate="+rec.get('releaseDate')+"&hrefFlg="+(new Date()).getTime();;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");

}
//驳回
function turnDown(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("releaseStatus")!="02"){
		L5.Msg.alert('提示',"请选择街道（乡镇）确定计划驳回!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要驳回？',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
			command.setParameter("releaseId", selected[0].get('releaseId'));
			command.setParameter("releaseStatus", organFlg);
			command.execute("executeSpecialPlan");
			if (!command.error) {
				L5.Msg.alert('提示',"保存成功！");
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
// 查看明细
function detail(releaseId,releaseDate,assistanceType) {
	var width = screen.width - 200;
	var height = 492;
	var url = "samReleaseDetail.jsp?releaseId=" + releaseId+"&releaseDate="+releaseDate+"&assistanceType="+assistanceType;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
//实施计划
function executeReleaseSummary(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(organFlg==selected[0].get("releaseStatus")){
		L5.Msg.alert('提示',"名册已确认，请不需要重复确认!");
		return false;
	}
	if(selected[0].get("releaseStatus")!="01"){
		L5.Msg.alert('提示',"请选择已生成名册的记录确认!");
		return false;
	}
	L5.MessageBox.confirm('确定', '名册确认后不能修改，确定要确认名册吗？', function(state) {
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
			command.setParameter("releaseId", selected[0].get('releaseId'));
			command.setParameter("releaseStatus", organFlg);
			command.execute("executeSpecialPlan");
			if (!command.error) {
				L5.Msg.alert('提示',"保存成功！");
				releaseSummaryListDs.reload();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
//	var width = screen.width-200;
//    var height = 400;
//	var url = "samReleaseDetaiConfirm.jsp?releaseId="+selected[0].get('releaseId');
//	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//删除专项补贴
function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	//校验，已实施的救助不能删除
	if(selected[0].get("releaseStatus")==organFlg){
		L5.Msg.alert('提示',"名册已确认，不能删除!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds="";
			for(var i=0;i<selected.length;i++){
				delIds=delIds+","+selected[i].get("releaseId");
			}
			var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
			command.setParameter("delIds", delIds);
			command.execute("deleteSpecialPlan");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	releaseSummaryListDs.remove(selected[i]);
				}
				releaseSummaryListDs.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//导出Excel
function exportSummaryRelease(){
	var dataset=L5.DatasetMgr.lookup("releaseSummaryExcelDs");
	if(releaseSummaryListDs.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	dataset.setParameter("SAM_RELEASE_SUMMARY.IS_SPECIAL@=","1");		
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_WAY@=",getParam("releaseWay"));		
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_AREA_CODE@=",getParam("releaseAreaCode"));		
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_DATE@=",getParam("releaseDate"));		
	dataset.setParameter("SAM_RELEASE_SUMMARY.REG_ID@=",organId);
	dataset.load();
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	L5.dataset2excel(dataset,"/jsp/cams/drel/special/samFamilySpecialAssPlanExcel.jsp");
}
function areaSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("releaseAreaName").value = list[1];
		document.getElementById("releaseAreaCode").value = list[0];
	}
}
function releaseAreaSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		releaseSummaryDs.set("releaseAreaName",list[1]);
		releaseSummaryDs.set("releaseAreaCode",list[0]);
	}
}
//查询发放标准
function countReleaseStandard( itemCode ){
	samAssistanceItemDS.removeAll();
	samAssistanceItemDS.setParameter("item_Code",itemCode);
	samAssistanceItemDS.setParameter("AREA_CODE",organArea);
	samAssistanceItemDS.load();
	samAssistanceItemDS.on('load',loadAssMon);
}
function loadAssMon(ds){
	ds.un('load',loadAssMon);
	if(ds.getCount() > 0 ){
		releaseSummaryDs.set('releaseTarget',ds.get('target'));
		releaseSummaryDs.set('releaseStandard',ds.get('assistanceMoney'));
	}else{
		releaseSummaryDs.set('releaseTarget','');
		releaseSummaryDs.set('releaseStandard','');
	}
}