function init(){
	var sumDataSet=L5.DatasetMgr.lookup("sumDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		sumDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
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
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.getCmp("detailWin").setVisible(true);
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