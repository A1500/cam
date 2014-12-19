var  orgCode ;
var ifInsert ;
function init(){
	myButtonControl();
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var planDataSet=L5.DatasetMgr.lookup("planDataSet");
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		if(organLevel=='JD'){
			planDataSet.setParameter("ORGANCODE",organCode);
			planDataSet.load();
		}else{
			orgCode = OrgCodeDataset.get("text");
			planDataSet.setParameter("orgCode",orgCode);
			planDataSet.setParameter("ORGANCODE",organCode);
			planDataSet.load();
		}
		
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
	var planDataSet = L5.DatasetMgr.lookup("planDataSet");
	planDataSet.setParameter("ORGANCODE",organCode);
	planDataSet.setParameter("orgCode",orgCode);
	planDataSet.setParameter("REPORTDATE",_$("reportDate"));
	planDataSet.setParameter("STATUS",_$("status"));
	planDataSet.load();	
}
function insert(){
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoEdit.jsp";
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
	data.put("recordId",records[0].get("PLANID"));
	var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("recordId",records[0].get("PLANID"));
	data.put("fileId",records[0].get("FILEID"));
	var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoDetail.jsp";
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
	if(organLevel=="JD"){
		if(records[0].get("ORGANCODE")!=organCode){
			L5.Msg.alert("提示","非本级填报数据，不允许修改!");
			return;
		}
	}
	
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPlanInfoCmd");
			command.setParameter("id", records[0].get("PLANID"));
			command.execute("report");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				if(organLevel=='JD'||organLevel=='SQ'){
					getMsg();
				}
				var planDataSet = L5.DatasetMgr.lookup("planDataSet");
				planDataSet.reload();
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
}
function sumInsert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoSum.jsp";
	L5.forward(url,'',data);
}
function sumRedo(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","已经上报，不允许重新汇总!");
		return;
	}
	if(records[0].get("ORGANCODE")!=organCode){
		L5.Msg.alert("提示","不是汇总数据!");
		return;
	}
	L5.MessageBox.confirm("提示", "重新汇总将删除原汇总数据，是否继续？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPlanInfoCmd");
			command.setParameter("id",records[0].get("PLANID"));
			command.execute("delete");
			if (!command.error){
				var data=new L5.Map();
				data.put("method","insert");
				var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoSum.jsp";
				L5.forward(url,'',data);
			}else{
				L5.Msg.alert("提示","删除原汇总数据出错！");
			}
		}
	});
}
function sumDetail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("ORGANCODE")!=organCode){
			L5.Msg.alert("提示","非本级汇总数据!");
			return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("recordId",records[0].get("PLANID"));
	var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoSum.jsp";
	L5.forward(url,'',data);
}
function myButtonControl(){
	if(organLevel=="JD"){
		$("sum1").style.display="none";
		$("sum2").style.display="none";
		$("sum3").style.display="none";
	}
	if(organLevel=="11"){
		$("detail1").style.display="none";
		$("detail2").style.display="none";
	}
}
