var  orgCode ;
var ifInsert ;
function init(){
	if(organLevel=="11"){
		$("detail1").style.display="none";
		$("detail2").style.display="none";
		$("report").style.display="none";
	}
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		if(organLevel=='JD'){
			coordinateDataSet.setParameter("ORGANCODE",organCode);
			L5.getCmp("rejectButton").hide();
		}else{
			orgCode = OrgCodeDataset.get("text");
			coordinateDataSet.setParameter("orgCode",orgCode);
			coordinateDataSet.setParameter("ORGANCODE",organCode);
		}
		coordinateDataSet.load();
	});
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	insertDataSet.on("load",function(){
		ifInsert = false;
		if(insertDataSet.getCount()>=1){
			ifInsert = true;
		}else{
			ifInsert = false;
		}
	});
}
function query(){
	var coordinateDataSet = L5.DatasetMgr.lookup("coordinateDataSet");
	coordinateDataSet.setParameter("ORGANCODE",organCode);
	coordinateDataSet.setParameter("orgCode",orgCode);
	coordinateDataSet.setParameter("REPORTDATE",_$("reportDate"));
	coordinateDataSet.setParameter("STATUS",_$("status"));
	coordinateDataSet.load();	
}
function insert(){
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/coordinate/vcdcCoordinateInfoEdit.jsp";
		L5.forward(url,'',data);
	}else{
		L5.Msg.alert("提示","暂无本项填报任务!");
	}
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","已经上报，不允许修改!");
		return;
	}
	if(organLevel!="JD"){
		if(records[0].get("ORGANCODE")==organCode){
			L5.Msg.alert("提示","汇总数据，不允许修改!");
			return;
		}
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("recordId",records[0].get("COORDINATEID"));
	var url="jsp/ext/cdc/manage/coordinate/vcdcCoordinateInfoEdit.jsp";
	L5.forward(url,'',data);
}
function report(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","该数据已经上报!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoCmd");
			command.setParameter("id",records[0].get("COORDINATEID"));
			command.execute("report");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				if(organLevel=='JD'||organLevel=='SQ'){
					getMsg();
				}
				var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
				coordinateDataSet.reload();
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
}
function audit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")==0){
		L5.Msg.alert("提示","未上报,不能驳回!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否驳回该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoCmd");
			command.setParameter("id",records[0].get("COORDINATEID"));
			command.execute("audit");
			if (!command.error){
				L5.Msg.alert("提示","驳回成功！");
				var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
				coordinateDataSet.reload();
			}else{
				L5.Msg.alert("提示","上报出错！");
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
	data.put("method","detail");
	data.put("recordId",records[0].get("COORDINATEID"));
	var url="jsp/ext/cdc/manage/coordinate/vcdcCoordinateInfoDetail.jsp";
	L5.forward(url,'',data);
}
