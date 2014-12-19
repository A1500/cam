//当前command
var command;
//当前dataset
var dataset;
//当前页面
var currentJsp;
//当前页面
var nextJsp;
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
		nextJsp="esureyHouseList.jsp";
	}else if(currentJsp=="esureyBusinessDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessCmd");
		dataset=businessDataset;
		nextJsp="esureyBusinessList.jsp";
	}else if(currentJsp=="esureyCarDetail.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyCarCmd");
		dataset=carDataset;
		nextJsp="esureyCarList.jsp";
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
		nextJsp="esureyInsuranceList.jsp";
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
	var editGrid=L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	//是否提交校验
	checkCheckFlg(selected[0].get("feedbackId"));
}
//更新提交标志
function updateFeedback(feedbackId){
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEnsureyFeedbackCmd");
	command.setParameter("feedbackId",feedbackId);
	command.execute("updateCheckFlg");	
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!");
		var url='jsp/ext/esurey/manage/'+currentJsp;
		L5.forward(url);
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
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
		var data=new L5.Map();
		data.put("peopleId",selected[0].get("peopleId"));
		data.put("familyId",selected[0].get("familyId"));
		data.put("feedbackId",selected[0].get("feedbackId"));
		data.put("surveyId",selected[0].get("surveyId"));
		if(currentJsp=="esureyHouseDetail.jsp"){
			var name=escape(encodeURIComponent(selected[0].get("name")));
			data.put("owerName",name);
			data.put("idCard",selected[0].get("idCard"));
		}else if(currentJsp=="esureyCarDetail.jsp"){
			var name=escape(encodeURIComponent(selected[0].get("name")));
			data.put("owerName",name);
		}
		data.put("frontJsp",currentJsp);
		var url='jsp/ext/esurey/manage/'+nextJsp;
		var text = '核对信息添加';
		L5.forward(url,text,data);
	}
}
//根据组件的ID得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function forExcel() {
	var ds=L5.DatasetMgr.lookup("FeedbackDataset");
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="0";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,"/jsp/ext/esurey/manage/assistance/forExcel.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
}

