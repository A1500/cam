function init(){
	if(organType=='12'){
		act="'关闭审核','市级发起'";
	}else if(organType=='11'){
		act="'关闭审批','省级审批'";
	}else if(organType=='13'){
		act="'关闭发起'"
	}
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.load();
	var yiBanDataset = L5.DatasetMgr.lookup("yiBanDataset");
	yiBanDataset.setParameter("processType",procTypeId);	
	yiBanDataset.setParameter("actDefName",act);
	yiBanDataset.load();
	var banjieDataset = L5.DatasetMgr.lookup("banjieDataset");
	banjieDataset.setParameter("processType",procTypeId);	
	banjieDataset.setParameter("actDefName",act);
	banjieDataset.load();
	L5.QuickTips.init();			
}
//待办任务查询
function query(){
	var dbName=document.getElementById('dbName').value;
	var dbFillName=document.getElementById('dbFillName').value;
	if(dbName==''&&dbFillName==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.load();	
	}else {
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+dbName+"%&T.FILL_ORGAN_NAME@LIKE:%"+dbFillName+"%");
		daiBanDataset.load();	
	}
}
//查看待办流程图
function showState(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanGridPanel");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//已办任务查询
function queryYiban(){
	var ybName=document.getElementById('ybName').value;
	var ybFillName=document.getElementById('ybFillName').value;
	if(ybName==''&&ybFillName==''){
		yiBanDataset.setParameter("processType",procTypeId);	
		yiBanDataset.setParameter("actDefName",act);
		yiBanDataset.load();
	}else {
		yiBanDataset.setParameter("processType",procTypeId);	
		yiBanDataset.setParameter("actDefName",act);
		yiBanDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+ybName+"%&T.FILL_ORGAN_NAME@LIKE:%"+ybFillName+'%');
		yiBanDataset.load();	
	}
}
//查看已办任务
function handleyiban(){
	var userGrid=L5.getCmp('yiBanGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var taskCode = rec.get("CEME_APPLY_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&cemeApplyId="+taskCode;
	L5.forward(url+query);
}
//查看已办流程图
function showStateyiban(){
	var yiBanTaskGridPanel=L5.getCmp("yiBanGridPanel");
	var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//查询结束任务
function queryEnd(){
	var bjName=document.getElementById("bjName").value;
	var bjFillName=document.getElementById('bjFillName').value;
	if(bjName==''&&bjFillName==''){
		banjieDataset.setParameter("processType",procTypeId);	
		banjieDataset.setParameter("actDefName",act);
		banjieDataset.load();	
	}else {
		banjieDataset.setParameter("processType",procTypeId);	
		banjieDataset.setParameter("actDefName",act);
		banjieDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+bjName+"%&T.FILL_ORGAN_NAME@LIKE:%"+bjFillName+"%");
		banjieDataset.load();	
	}
}
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("banjieGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var taskCode = rec.get("CEME_APPLY_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&cemeApplyId="+taskCode;
	L5.forward(url+query);
}
//查看流程状态图
function showStateEnd(){
   var endTaskGridPanel=L5.getCmp("banjieGridPanel");
   var selecteds=endTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
      L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("ID");
   var url="jsp/workflow/monitor/flowview.jsp?assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
// 受理页面
function handle(){
	var userGrid=L5.getCmp('daiBanGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var assignmentId = rec.get("ID");
	var processId = rec.get("PROCESS_ID");
	var cemeApplyId = rec.get("CEME_APPLY_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&cemeApplyId="+cemeApplyId;
	L5.forward(url+query);
}   
function showDetail(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	var cemeApplyId = record.get("CEME_APPLY_ID");
	var data = new L5.Map();
	data.put("cemeApplyId",cemeApplyId);
	var url="jsp/cams/fis/wf/loginoff/fisCemeLogoffDetail.jsp";
	L5.forward(url,"",data);
}
function renderDate(value){
	var revalue="";
	revalue+= value.substr(0,4)+"-";
	revalue+= value.substr(4,2)+"-";
	revalue+= value.substr(6,2);
	return revalue;
}