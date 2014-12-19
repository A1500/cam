function init(){
	var sumDataSet=L5.DatasetMgr.lookup("sumDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		sumDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		$("sumButton").style.display="none";
		$("auditButton").style.display="none";
		reportWorkDataSet.load();
		reportWorkDataSet.on('load',function(){
			sumDataSet.setParameter("RECORD_ID@=",recordId);
			sumDataSet.load();
		});
		sumDataSet.on('load', function(){
			getUnder(organCode);
		});
	}
	childDataSet="detailDataSet";
	regMethod();
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var recordId = records[0].get("recordId");
	L5.getCmp("detailWin").setVisible(true);
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	//infoDataSet.setParameter("ORGAN_CODE@=", organCode);
	infoDataSet.setParameter("RECORD_ID@=", recordId);
	infoDataSet.load();
	getPer();
}
function winClose(){
	L5.getCmp("detailWin").setVisible(false);
}
function audit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")!="1"){
		L5.Msg.alert("提示","该单位未上报，无法驳回!");
		return;
	}
	L5.getCmp("rejectWin").setVisible(true);
	document.getElementById("reason").value="";
}
function confirmReject(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	L5.MessageBox.confirm("提示", "确定驳回该单位数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcDecisionReportCmd");
			records[0].set("status","2");
			records[0].set("rejectReason",document.getElementById("reason").value);
			command.setParameter("record",records[0]);
			command.execute("update");
			if(!command.error){
				L5.Msg.alert("提示","驳回成功！",function(){
					var detailDataSet=L5.DatasetMgr.lookup("detailDataSet");
					var cityDataSet=L5.DatasetMgr.lookup("cityDataSet");
					detailDataSet.reload();
					cityDataSet.reload();
					closeWin();
				});
			}else{
				L5.Msg.alert("提示","驳回出错！");
			}
		}
	});
	
}
function closeWin(){
	L5.getCmp("rejectWin").setVisible(false);
}
function save(){
	if($("reportDate").value==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(!reportFlag){
		L5.Msg.alert("提示","有未上报单位，不能汇总！");
		return;
	}
	var sumDataSet=L5.DatasetMgr.lookup("sumDataSet");
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcDecisionReportCmd");
	command.setParameter("record",sumDataSet.getCurrent());
	command.execute("sum");
	if(!command.error){
		L5.Msg.alert("提示","汇总成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","汇总出错！");
	}
}
function returnBack(){
	history.go(-1);
}
function getPer(){
	var detailDataSet=L5.DatasetMgr.lookup("detailDataSet");
	var rec=detailDataSet.getCurrent();
	rec.set("meetingRealPer", Math.round((rec.get("meetingRealNum")/rec.get("meetingShouldNum"))*10000)/100);
	rec.set("meetingAgreePer", Math.round((rec.get("meetingAgreeNum")/rec.get("meetingRealNum"))*10000)/100);
	rec.set("meetingUnagreePer", Math.round((rec.get("meetingUnagreeNum")/rec.get("meetingRealNum"))*10000)/100);
	rec.set("meetingGiveupPer", Math.round((rec.get("meetingGiveupNum")/rec.get("meetingRealNum"))*10000)/100);
	rec.set("sovietRealPer", Math.round((rec.get("sovietRealNum")/rec.get("sovietShouldNum"))*10000)/100);
	rec.set("sovietAgreePer",Math.round((rec.get("sovietAgreeNum")/rec.get("sovietRealNum"))*10000)/100);
	rec.set("sovietUnagreePer",Math.round((rec.get("sovietUnagreeNum")/rec.get("sovietRealNum"))*10000)/100);
	rec.set("sovietGiveupPer",Math.round((rec.get("sovietGiveupNum")/rec.get("sovietRealNum"))*10000)/100);
	rec.set("sovietFemalePer",Math.round((rec.get("sovietFemaleNum")/rec.get("sovietRealNum"))*10000)/100);
	rec.set("refRealPer",Math.round((rec.get("refRealNum")/rec.get("refShouldNum"))*10000)/100);
	rec.set("refAgreePer",Math.round((rec.get("refAgreeNum")/rec.get("refRealNum"))*10000)/100);
	rec.set("refUnagreePer",Math.round((rec.get("refUnagreeNum")/rec.get("refRealNum"))*10000)/100);
	rec.set("refGiveupPer",Math.round((rec.get("refGiveupNum")/rec.get("refRealNum"))*10000)/100);
}
function cRender(val){
	if(val!=""){
		return val+" 次";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function hRender(val){
	if(val!=""){
		return val+" 户";
	}
}
function bRender(val){
	if(val!=""){
		return val+" %";
	}
}