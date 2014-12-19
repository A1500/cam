function init(){
	if(organType=="13"){
		act="'县级整改','县级检查'";
	}else if(organType=="12"){
		act="'市级审批'";
	}
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	//daiBanDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	//daiBanDataset.setParameter("tableKey","CEME_APPLY_ID");
	//daiBanDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID,CHECK_YEAR");
	daiBanDataset.load();
	
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	//yiBanTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	//yiBanTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	//yiBanTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID,CHECK_YEAR");
	yiBanTaskDataset.load();
	
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	//endTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	//endTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	//endTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID,CHECK_YEAR");
	endTaskDataset.load();
	L5.QuickTips.init();
}
Date.prototype.pattern=function(fmt) {        
    var o = {        
    "M+" : this.getMonth()+1, //月份        
    "d+" : this.getDate(), //日        
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时        
    "H+" : this.getHours(), //小时        
    "m+" : this.getMinutes(), //分        
    "s+" : this.getSeconds(), //秒        
    "q+" : Math.floor((this.getMonth()+3)/3), //季度        
    "S" : this.getMilliseconds() //毫秒        
    };        
    var week = {        
    "0" : "/u65e5",        
    "1" : "/u4e00",        
    "2" : "/u4e8c",        
    "3" : "/u4e09",        
    "4" : "/u56db",        
    "5" : "/u4e94",        
    "6" : "/u516d"       
    };        
    if(/(y+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));        
    }        
    if(/(E+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);        
    }        
    for(var k in o){        
        if(new RegExp("("+ k +")").test(fmt)){        
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));        
        }        
    }        
    return fmt;        
}
function renderDate(value,cellmeta,record) {
	var revalue="";
	revalue+= value.substr(0,4)+"-";
	revalue+= value.substr(4,2)+"-";
	revalue+= value.substr(6,2);
	//revalue+= value.substr(8,6);
	return revalue;
			
}
//查看已办任务
function handleyiban(){
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
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
	var query="?assignmentId="+assignmentId+"&processId="+processId;
	L5.forward(url+query);
}
//查看已办流程图
function showStateyiban(){
	var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
	var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//查看办结流程状态图
function showStateEnd(){
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
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
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("endTaskGridPanel");
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
	var query="?assignmentId="+assignmentId+"&processId="+processId;
	L5.forward(url+query);
}
//办理
function submit(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var assignmentId = rec.get("ID");
	var processId = rec.get("PROCESS_ID");
	var taskCode = rec.get("CEME_APPLY_ID");
	var recordId = rec.get("RECORD_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId;
	L5.forward(url+query);
}
function showDaibanState(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	//var url=;
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//已办重置
function reset() {
	document.getElementById("queryCemeY").value = '';
	document.getElementById("queryTimeY").value = '';
	document.getElementById("checkResultY").value = '';
	
	document.getElementById("queryCemeW").value = '';
	document.getElementById("queryTimeW").value = '';
	document.getElementById("checkResultW").value = '';
}
//待办重置
function resetClick() {
	document.getElementById("queryCemeName").value = '';
	document.getElementById("queryTime").value = '';
	document.getElementById("checkResult").value = '';
}
function queryDaiban(){
	/*if(actId=="1"){
		act="县级检查";
	}else if(actId=="2"){
		act="市级审批";
	}else if(actId=="4"){
		act='县级整改';
	}*/
	if(organType=="13"){
		act="'县级整改','县级检查'";
	}else if(organType=="12"){
		act="'市级审批'";
	}
	var queryCemeName=document.getElementById('queryCemeName').value;
	var queryTime=document.getElementById('queryTime').value;
	var checkResult=document.getElementById('checkResult').value;
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("queryCemeName",'%'+queryCemeName+'%');
	daiBanDataset.setParameter("queryTime",queryTime);
	daiBanDataset.setParameter("checkResult",checkResult);
	daiBanDataset.load();
	
}
function queryYiban(){
	/*if(actId=="1"){
		act="县级检查";
	}else if(actId=="2"){
		act="市级审批";
	}else if(actId=="4"){
		act='县级整改';
	}*/
	if(organType=="13"){
		act="'县级整改','县级检查'";
	}else if(organType=="12"){
		act="'市级审批'";
	}
	var queryCemeName=document.getElementById('queryCemeY').value;
	var queryTime=document.getElementById('queryTimeY').value;
	var checkResult=document.getElementById('checkResultY').value;
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("queryCemeName",'%'+queryCemeName+'%');
	yiBanTaskDataset.setParameter("queryTime",queryTime);
	yiBanTaskDataset.setParameter("checkResult",checkResult);
	yiBanTaskDataset.load();
	
}
function queryEnd(){
	/*if(actId=="1"){
		act="县级检查";
	}else if(actId=="2"){
		act="市级审批";
	}else if(actId=="4"){
		act='县级整改';
	}*/
	if(organType=="13"){
		act="'县级整改','县级检查'";
	}else if(organType=="12"){
		act="'市级审批'";
	}
	var queryCemeName=document.getElementById('queryCemeW').value;
	var queryTime=document.getElementById('queryTimeW').value;
	var checkResult=document.getElementById('checkResultW').value;
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("queryCemeName",'%'+queryCemeName+'%');
	endTaskDataset.setParameter("queryTime",queryTime);
	endTaskDataset.setParameter("checkResult",checkResult);
	endTaskDataset.load();
	
}
//打印年检报告
function printReport(){
	var userGrid=L5.getCmp("endTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var taskCode = rec.get("CEME_APPLY_ID");
	//alert(taskCode);
	var url="../../comm/print/fisCemeCheckReportPrint.jsp?cemeApplyId="+taskCode;
	window.open(url);
}