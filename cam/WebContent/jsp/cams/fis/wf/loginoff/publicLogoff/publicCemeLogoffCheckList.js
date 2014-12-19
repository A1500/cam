function init(){
	if(organType=='13'){
		act="'县级审批'";
	}else if(organType=='14'){
		act="'乡镇发起','补齐补正'";
	}
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("processType",procTypeId);	
	daiBanDataSet.setParameter("actDefName",act);
	daiBanDataSet.load();
	var yiBanDataSet = L5.DatasetMgr.lookup("yiBanDataSet");
	yiBanDataSet.setParameter("processType",procTypeId);	
	yiBanDataSet.setParameter("actDefName",act);
	yiBanDataSet.load();
	var endDataSet = L5.DatasetMgr.lookup("endDataSet");
	endDataSet.setParameter("processType",procTypeId);	
	endDataSet.setParameter("actDefName",act);
	endDataSet.load();
	L5.QuickTips.init();
}
//待办任务查询
function query(){
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	var dbName=document.getElementById('dbName').value;
	var dbFillName=document.getElementById('dbFillName').value;
	if(dbName==''&&dbFillName==''){
		daiBanDataSet.setParameter("processType",procTypeId);	
		daiBanDataSet.setParameter("actDefName",act);
		daiBanDataSet.load();	
	}else {
		daiBanDataSet.setParameter("processType",procTypeId);	
		daiBanDataSet.setParameter("actDefName",act);
		daiBanDataSet.setParameter("mysetwhere","A.NAME@LIKE:%"+dbName+"%&T.FILL_ORGAN_NAME@LIKE:%"+dbFillName+"%");
		daiBanDataSet.load();	
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
	var yiBanDataSet = L5.DatasetMgr.lookup("yiBanDataSet");
	var ybName=document.getElementById('ybName').value;
	var ybFillName=document.getElementById('ybFillName').value;
	if(ybName==''&&ybFillName==''){
		yiBanDataSet.setParameter("processType",procTypeId);	
		yiBanDataSet.setParameter("actDefName",act);
		yiBanDataSet.load();
	}else {
		yiBanDataSet.setParameter("processType",procTypeId);	
		yiBanDataSet.setParameter("actDefName",act);
		yiBanDataSet.setParameter("mysetwhere","A.NAME@LIKE:%"+ybName+"%&T.FILL_ORGAN_NAME@LIKE:%"+ybFillName+'%');
		yiBanDataSet.load();	
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
	var endDataSet = L5.DatasetMgr.lookup("endDataSet");
	var bjName=document.getElementById("bjName").value;
	var bjFillName=document.getElementById('bjFillName').value;
	if(bjName==''&&bjFillName==''){
		endDataSet.setParameter("processType",procTypeId);	
		endDataSet.setParameter("actDefName",act);
		endDataSet.load();	
	}else {
		endDataSet.setParameter("processType",procTypeId);	
		endDataSet.setParameter("actDefName",act);
		endDataSet.setParameter("mysetwhere","A.NAME@LIKE:%"+bjName+"%&T.FILL_ORGAN_NAME@LIKE:%"+bjFillName+"%");
		endDataSet.load();	
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
	var cemeApplyId = records[0].get("CEME_APPLY_ID");
	var recordId= records[0].get("RECORD_ID");
	var data = new L5.Map();
	data.put("cemeApplyId",cemeApplyId);
	data.put("recordId",recordId);
	var url="jsp/cams/fis/wf/loginoff/publicLogoff/publicCemeLogoffDetail.jsp";
	L5.forward(url,"",data);
}
function renderDate(value){
	var revalue="";
	revalue+= value.substr(0,4)+"-";
	revalue+= value.substr(4,2)+"-";
	revalue+= value.substr(6,2);
	return revalue;
}