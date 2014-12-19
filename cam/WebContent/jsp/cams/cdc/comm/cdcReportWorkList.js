function init(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	
	L5.QuickTips.init();
}
function query(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.setParameter("REPORT_DESC@LIKE",_$("reportDesc"));
	reportWorkDataSet.setParameter("REPORT_ID@=",_$("reportId"));
	reportWorkDataSet.setParameter("REPORT_DATE@LIKE",_$("reportDate"));
	reportWorkDataSet.setParameter("STATUS@=",_$("status"));
	reportWorkDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/cdc/comm/cdcReportWorkEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("workId",records[0].get("workId"));
	var url="jsp/cams/cdc/comm/cdcReportWorkEdit.jsp";
	L5.forward(url,'',data);
}
function start(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","该工作已经开展!");
		return;
	}
	if(records[0].get("status")=="2"){
		L5.Msg.alert("提示","该工作已经结束!");
		return;
	}
	L5.MessageBox.confirm("提示", "确定开展该工作？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcReportWorkCmd");
			records[0].set("status","1");
			command.setParameter("record",records[0]);
			command.execute("update");
			if (!command.error){
				L5.Msg.alert("提示","成功开展该工作！",function(){
					var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
					reportWorkDataSet.reload();
				});
			}else{
				L5.Msg.alert("提示","保存出错！");
			}
		}
	});
}
function stop(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="2"){
		L5.Msg.alert("提示","该工作已经结束!");
		return;
	}
	L5.MessageBox.confirm("提示", "确定结束该工作？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcReportWorkCmd");
			records[0].set("status","2");
			command.setParameter("record",records[0]);
			command.execute("update");
			if (!command.error){
				L5.Msg.alert("提示","成功结束该工作！",function(){
					var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
					reportWorkDataSet.reload();
				});
			}else{
				L5.Msg.alert("提示","保存出错！");
			}
		}
	});
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("workId",records[0].get("workId"));
	var url="jsp/cams/cdc/comm/cdcReportWorkDetail.jsp";
	L5.forward(url,'',data);
}