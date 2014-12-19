function init(){
	if(organType=='14'){
		act="'乡镇发起','乡镇补齐补正'";
	}else if(organType=='13'){
		act="'县级审批'";
	}
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	daiBanDataset.setParameter("tableKey","CEME_APPLY_ID");
	daiBanDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID");
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	yiBanTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	yiBanTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID");
	yiBanTaskDataset.load();
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	endTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	endTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,RECORD_ID");
	endTaskDataset.load();
	L5.QuickTips.init();			
}
//查看代办任务
function handledaiban(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var data = new L5.Map();
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("cemeApplyId",selected[0].get('CEME_APPLY_ID'));
	data.put("changeId",selected[0].get('CHANGE_ID'));
	if(actId=="1"){
		data.put("actDefName","sj");
	}else{
		data.put("actDefName","shj");		
	}
	var url='jsp/cams/fis/wf/change/publicChange/publicCemeApproveDetail.jsp';
	var text = '明细查看';
	L5.forward(url,text,data);
}
//查看已办任务
function handleyiban(){
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var data = new L5.Map();
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("cemeApplyId",selected[0].get('CEME_APPLY_ID'));
	data.put("changeId",selected[0].get('CHANGE_ID'));
	var url='jsp/cams/fis/wf/change/publicChange/publicCemeApproveDetail.jsp';
	var text = '明细查看';
	L5.forward(url,text,data);
}
//待办任务查询
function query(){
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.load();
	}else{
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+subjectDaiban+"%");
		daiBanDataset.load();
	}
	
}
//查看待办流程图
function showState(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
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
function queryyiban(){
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.load();
	}else {
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+yibanSubject+"%");
		yiBanTaskDataset.load();	
	}
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
//查询结束任务
function queryEnd(){
	var endSubject=document.getElementById("endSubject").value;
	if(endSubject==''){
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
		endTaskDataset.load();	
	}else {
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
		endTaskDataset.setParameter("mysetwhere","A.NAME@LIKE:%"+endSubject+"%");
		endTaskDataset.load();	
	}
}
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("endTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var data = new L5.Map();
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("cemeApplyId",selected[0].get('CEME_APPLY_ID'));
	data.put("changeId",selected[0].get('CHANGE_ID'));
	data.put("actDefName","shj");		
	var url='jsp/cams/fis/wf/change/fisCemeApproveDetail.jsp';
	var text = '明细查看';
	L5.forward(url,text,data);
}
//查看流程状态图
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
// 受理页面
function forAccept(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
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
	//var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/applytask/qualificationApprove.jsp?taskCode='+selected[0].get("CEME_APPLY_ID");
	L5.forward(url+query);
}
// 修改页面
function forUpdate(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selecteds=userGrid.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var rec=selecteds[0];
	var assignmentId = rec.get("ID");
	var processId = rec.get("PROCESS_ID");
	var taskCode = rec.get("CEME_APPLY_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/newTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
	L5.forward(url);
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
	revalue+= value.substr(0,10);
	return revalue;
}

