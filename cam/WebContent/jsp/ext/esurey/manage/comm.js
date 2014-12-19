//当前command
var command;
//年月区分标志
var MONTH_FLAG="2";
//当前dataset
var dataset;
//填写前校验
var modifyDataset;
//纳税类型
var TAX_TYPE;
//国税
var GUO_SHUI="国税";
var GUO_CODE='0';
//地税
var DI_SHUI="地税";
var DI_CODE="1";
//人员姓名
var CURRENT_NAME;
//当前页面
var currentJsp;
//页面初始化方法
function init(){
	FeedbackDataset.setParameter("check_Flg",0);
	FeedbackDataset.setParameter("CHECK_ORG_ID",organId);
	//得到当前路径
	var parths=document.location.pathname.split("/");
	currentJsp=parths[parths.length-1];
	//根据当前路径中的jsp文件名判断使用哪个Command和dataset
	if(currentJsp=="esureySocialDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySocialCmd");
		dataset=socialDataset;
	}else if(currentJsp=="esureyHouseDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyHouseCmd");
		dataset=houseDataset;
	}else if(currentJsp=="esureyBusinessDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessCmd");
		dataset=businessDataset;
	}else if(currentJsp=="esureyCarDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyCarCmd");
		dataset=carDataset;
	}else if(currentJsp=="esureyTaxDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyTaxCmd");
		dataset=taxDataset;
	}else if(currentJsp=="esureyBankDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBankCmd");
		dataset=bankDataset;
	}else if(currentJsp=="esureySecuritiesDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesCmd");
		dataset=securitiesDataset;
	}else if(currentJsp=="esureyInsuranceDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceCmd");
		dataset=insuranceDataset;
	}else if(currentJsp=="esureyFundDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundCmd");
		dataset=housingFundDataset;
	}
	FeedbackDataset.load();
}
//查询按钮方法
function query(){
	FeedbackDataset.setParameter("name",getParam("name"));
	FeedbackDataset.setParameter("id_Card",getParam("idCard"));
	FeedbackDataset.setParameter("check_Time",getParam("checkTime"));
	FeedbackDataset.setParameter("check_Flg",getParam("checkFlg"));
	FeedbackDataset.setParameter("CHECK_ORG_ID",organId);
	FeedbackDataset.load();
}
//选中的记录
var selected;
//核对信息填写方法
function fillCheckMsg(){
	method="INSERT";
	var editGrid=L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	CURRENT_NAME=selected[0].get("name");
	if(currentJsp=="esureyTaxDetail.jsp"){
		if(selected[0].get("checkOrg")==GUO_SHUI){
			TAX_TYPE=GUO_CODE;
		}else if(selected[0].get("checkOrg")==DI_SHUI){
			TAX_TYPE=DI_CODE;
		}
	}
	//是否提交校验
	checkCheckFlg(selected[0].get("feedbackId"));
}
//修改已填写核对信息
function Evt_modify_onclick(){
	var editGrid=L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	method="UPDATE";
	//是否提交校验
	checkCheckFlg(selected[0].get("feedbackId"));
}
var checkInFlg;
//提交方法
function Evt_butcheckin_onclick(){
	checkInFlg="checkIn";
	Evt_butsave_onclick();
}
//保存方法
function Evt_butsave_onclick(){
	if(currentJsp=="esureySocialDetail.jsp"){
		if(dataset.getCount()!=0){
		 dataset.set("yearMonth",MONTH_FLAG);
		}
	}
	var record=dataset.getCurrent();
	if(!record&&checkInFlg){
		L5.Msg.alert('提示',"信息未录入，请先录入!");
		return;
	}else if(record&&checkInFlg){
		updateFeedback(selected[0].get("feedbackId"));
	}
	record.set("type",2);
	record.set("peopleId",selected[0].get("peopleId"));
	record.set("feedbackId",selected[0].get("feedbackId"));
	//根据当前JSP向estateRecord中放值
	if(currentJsp=="esureySocialDetail.jsp"){
		var estateRecord=estateDataset.newRecord();
		estateRecord.set("type",2);
		estateRecord.set("familyId",selected[0].get("familyId"));
		estateRecord.set("surveyId",selected[0].get("surveyId"));
		estateRecord.set("feedbackId",selected[0].get("feedbackId"));
		estateRecord.set("peopleId",selected[0].get("peopleId"));
		estateRecord.set("item",8);
		estateRecord.set("period",MONTH_FLAG);
		estateRecord.set("num",record.get("pension")*1+record.get("salary")*1+record.get("pensionBalance")*1);
		command.setParameter("estateRecord",estateRecord);
	}else if(currentJsp=="esureyBankDetail.jsp"){
		var estateRecord=estateDataset.newRecord();
		estateRecord.set("familyId",selected[0].get("familyId"));
		estateRecord.set("type",2);
		estateRecord.set("surveyId",selected[0].get("surveyId"));
		estateRecord.set("feedbackId",selected[0].get("feedbackId"));
		estateRecord.set("peopleId",selected[0].get("peopleId"));
		estateRecord.set("item",4);
		estateRecord.set("num",record.get("totalSavings")*1+record.get("totalBond")*1);
		command.setParameter("estateRecord",estateRecord);
	}else if(currentJsp=="esureySecuritiesDetail.jsp"){
		var estateRecord=estateDataset.newRecord();
		estateRecord.set("familyId",selected[0].get("familyId"));
		estateRecord.set("type",2);
		estateRecord.set("surveyId",selected[0].get("surveyId"));
		estateRecord.set("feedbackId",selected[0].get("feedbackId"));
		estateRecord.set("peopleId",selected[0].get("peopleId"));
		estateRecord.set("item",6);
		estateRecord.set("num",record.get("stock")*1+record.get("fund")*1+record.get("money")*1);
		command.setParameter("estateRecord",estateRecord);
	}
	//var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySocialCmd");
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("insert");	
	}else{
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		Evt_butreturn_onclick();
		FeedbackDataset.setParameter("check_Flg",0);
		FeedbackDataset.setParameter("CHECK_ORG_ID",organId);
		FeedbackDataset.load();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		command.error=undefined;
	}
}
//更新提交标志
function updateFeedback(feedbackId){
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackCmd");
	command.setParameter("feedbackId",feedbackId);
	command.setParameter("checkOrg",checkOrg);
	command.setParameter("checkId",checkId);
	command.setParameter("checkPeople",checkPeople);
	command.execute("updateCheckFlg");	
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!");
		var url='jsp/ext/esurey/manage/'+currentJsp;
		L5.forward(url);
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		command.error=undefined;
	}
}
//填写核对信息前校验提交状态方法
function checkCheckFlg(feedbackId){
	CheckFlagDataset.setParameter("feedback_Id",feedbackId);
	CheckFlagDataset.load();
	CheckFlagDataset.on('load',checkFLG);
	
}
function checkFLG(CheckFlagDataset){
	if(CheckFlagDataset.get("checkFlg")==1){
		L5.Msg.alert('提示',"核对信息已提交");
		return;
	}else{
			dataset.setParameter("feedback_Id",selected[0].get("feedbackId"));
			dataset.load();
			//校验是否已录入信息
			dataset.on('load',checkInput);
	}
}
function checkInput(dataset){
	if(dataset.getCount()==0){
		if(method=="INSERT"){
			//显示社保信息录入窗口
			if(win==undefined){
				var win=L5.getCmp("socialWin");
			}
			win=L5.getCmp("socialWin");
			win.show();
			if(currentJsp=="esureySecuritiesDetail.jsp"){
				dataset.newRecord({
					name:CURRENT_NAME
				});
			}else if(currentJsp=="esureyBankDetail.jsp"){
				dataset.newRecord({
					accountName:CURRENT_NAME
				});
			}else if(currentJsp=="esureyTaxDetail.jsp"){
				dataset.newRecord({
					taxesPeople:CURRENT_NAME,
					taxesType:TAX_TYPE
				});
			}else if(currentJsp=="esureyFundDetail.jsp"){
				dataset.newRecord({
					name:CURRENT_NAME
				});
			}else{
				dataset.newRecord();
			}
		}else{
			L5.Msg.alert('提示',"信息未录入，请先录入");
		}
	}else{
		if (method=="INSERT"){
			L5.Msg.alert('提示',"已经录入此人信息，请点击修改");
			return;
		}else{
			//显示信息修改窗口
			if(win==undefined){
				var win=L5.getCmp("socialWin");
			}
			win=L5.getCmp("socialWin");
			win.show();
		}
		
	}
}
//关闭社保信息录入窗口
function Evt_butreturn_onclick(){
	if(win==undefined){
		var win=L5.getCmp("socialWin");
	}
	win=L5.getCmp("socialWin");
	win.hide();
}
//根据组件的ID得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//金额数字校验并处理
function  checkMoney(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value){
		if(!_isNum(value)){
			L5.Msg.alert('提示',"请输入数字");
			document.getElementById(ElementId).value="";
			return;
		}
		document.getElementById(ElementId).value=formatNum(value);
	}
}