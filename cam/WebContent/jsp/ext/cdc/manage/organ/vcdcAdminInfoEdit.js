function init(){
	var adminReportDataSet=L5.DatasetMgr.lookup("adminReportDataSet");
	var adminInfoDataSet=L5.DatasetMgr.lookup("adminInfoDataSet");
	adminInfoDataSet.on("load",function(){
		countNum(adminInfoDataSet)
	});
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		adminReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N","organType":"2"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.setParameter("type", "2");
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		adminReportDataSet.setParameter("RECORD_ID@=",recordId);
		adminReportDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	if(method=="update"){
		L5.MessageBox.confirm("提示", "重新提取数据会是原始数据丢失，确定重新提取？",function(sta){
			if(sta=="yes"){
				var adminInfoDataSet=L5.DatasetMgr.lookup("adminInfoDataSet");
				adminInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
				adminInfoDataSet.setParameter("ORGAN_TYPE@=","2");
				adminInfoDataSet.load();
			}else{
				return false;
			}
		});
		
	}else{
		var adminInfoDataSet=L5.DatasetMgr.lookup("adminInfoDataSet");
		adminInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
		adminInfoDataSet.setParameter("ORGAN_TYPE@=","2");
		adminInfoDataSet.load();
	}
}
function countNum(dataset){
	var adminReportDataSet=L5.DatasetMgr.lookup("adminReportDataSet");
	var adminReportRecord=adminReportDataSet.getCurrent();
	var kind1=0;
	var kind2=0;
	var kind3=0;
	var kind4=0;
	var memberNum=0;
	var floorArea=0;
	var organYearNum=0;
	var dates= "";
	dataset.each(function(record,index){
		if(record.get('organKind')=='A'){
			kind1++;
		}else if(record.get('organKind')=='B'){
			kind2++;
		}else if(record.get('organKind')=='C'){
			kind3++;
		}else if(record.get('organKind')=='D'){
			kind4++;
		}
		memberNum+=record.get('memberNum');
		floorArea+=record.get('floorArea');
		dates=record.get('enterDate');
		enterYear=dates.substring(0, 4).toString();
		year=(new Date).getYear();
		if(enterYear==year){
			organYearNum++;
		}else{
			organYearNum+=0;
		}
	});
	adminReportRecord.set("organYearNum",organYearNum);
	adminReportRecord.set("organNum",dataset.getCount());
	adminReportRecord.set("morgNum",dataset.getCount());
	adminReportRecord.set("kindOneNum",kind1);
	adminReportRecord.set("kindTwoNum",kind2);
	adminReportRecord.set("kindThreeNum",kind3);
	adminReportRecord.set("kindFourNum",kind4);
	adminReportRecord.set("memberNum",memberNum);
	adminReportRecord.set("officialArea",floorArea);
}
function save(){
	var adminReportDataSet=L5.DatasetMgr.lookup("adminReportDataSet");
	var isValidate =true;
	var record=adminReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	isValidate = adminReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
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
			var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoList.jsp";
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
