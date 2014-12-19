var  orgCode ;
var parentCode;
var areaCode;
function init(){
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var organReportDataSet=L5.DatasetMgr.lookup("organReportDataSet");
	var organInfoDataSet=L5.DatasetMgr.lookup("organInfoDataSet");
	organInfoDataSet.on("load",function(){
		countNum(organInfoDataSet);
	});
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	
	if(method=="insert"){
		if(organLevel=='SQ'){
			OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
			OrgCodeDataset.load(true);
			organCode  = OrgCodeDataset.get("text");
			
			organReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"C","organType":"1"});
			reportWorkDataSet.setParameter("organCode", organCode);
			reportWorkDataSet.setParameter("type", "1");
			reportWorkDataSet.load();
		}else{
			OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
			OrgCodeDataset.load();
			OrgCodeDataset.on("load",function() {
				orgCode = OrgCodeDataset.get("text");
				parentCode = organCode;
				if(organLevel=="JD"){
					 parentCode = orgCode.substring(0,9)+"000";
				}
				organReportDataSet.newRecord({"organCode":orgCode,"organName":organName+"本级","parentCode":parentCode,"communityNum":"1","reportType":"C","organType":"1"});
				reportWorkDataSet.setParameter("organCode", orgCode);
				reportWorkDataSet.setParameter("type", "1");
				reportWorkDataSet.load();
			});
		}
	}else{
		$("reportDate").disabled=true;
		organReportDataSet.setParameter("RECORD_ID@=",recordId);
		organReportDataSet.load();
		reportWorkDataSet.load();
		OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
		OrgCodeDataset.load(true);
		orgCode  = OrgCodeDataset.get("text");
		if(organLevel=='SQ'){
			organCode  = orgCode;
		}else if(organLevel=='JD'){
			organCode = orgCode.substring(0,9)+"000";
		}
	}
}
function forInsert(){
	if(method=="update"){
		L5.MessageBox.confirm("提示", "重新提取数据会是原始数据丢失，确定重新提取？",function(sta){
			if(sta=="yes"){
				
				var organInfoDataSet=L5.DatasetMgr.lookup("organInfoDataSet");
				organInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
				organInfoDataSet.setParameter("ORGAN_TYPE@=","1");
				organInfoDataSet.load();
			}else{
				return false;
			}
		});
		
	}else{
		var organInfoDataSet=L5.DatasetMgr.lookup("organInfoDataSet");
		organInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
		organInfoDataSet.setParameter("ORGAN_TYPE@=","1");
		organInfoDataSet.load();
	}
}
function countNum(dataset){
	var organReportDataSet=L5.DatasetMgr.lookup("organReportDataSet");
	var organReportRecord=organReportDataSet.getCurrent();
	var kind1=0;
	var kind2=0;
	var kind3=0;
	var kind4=0;
	var memberNum=0;
	var floorArea=0;
	dataset.each(function(record,index){
		if(record.get('organKind')=='1'){
			kind1++;
		}else if(record.get('organKind')=='2'){
			kind2++;
		}else if(record.get('organKind')=='3'){
			kind3++;
		}else if(record.get('organKind')=='4'){
			kind4++;
		}
		memberNum+=record.get('memberNum');
		floorArea+=record.get('floorArea');
	});
	organReportRecord.set("organNum",dataset.getCount());
	organReportRecord.set("morgNum",dataset.getCount());
	organReportRecord.set("kindOneNum",kind1);
	organReportRecord.set("kindTwoNum",kind2);
	organReportRecord.set("kindThreeNum",kind3);
	organReportRecord.set("kindFourNum",kind4);
	organReportRecord.set("memberNum",memberNum);
	organReportRecord.set("officialNum",dataset.getCount());
	organReportRecord.set("officialArea",floorArea);
}
function save(){
	var numberReg = RegExp('^[0-9]+$');
	var numReg = RegExp('^[0-9]+([.]{1}[0-9]{1,2})?$');
	var organReportDataSet=L5.DatasetMgr.lookup("organReportDataSet");
	isValidate = organReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=organReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganReportCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/organ/cdcOrganInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	var url="jsp/ext/cdc/manage/organ/cdcOrganInfoList.jsp";
	L5.forward(url,'',null);

}
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
function pRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function aRender(val){
	if(val!=""){
		return val+" 平方米";
	}
}
