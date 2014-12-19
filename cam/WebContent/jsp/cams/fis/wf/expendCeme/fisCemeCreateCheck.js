function init(){
	
	if(organType==13){
		act="'县级审批'";		
	}else if(organType==14){
		act="'乡镇发起' , '乡镇补齐补正'";
	}
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	daiBanDataset.setParameter("tableKey","CEME_APPLY_ID");
	daiBanDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	daiBanDataset.load();

	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	yiBanTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	yiBanTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	yiBanTaskDataset.load();
	
	endTaskDataset.setParameter("processType",procTypeId);
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	endTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	endTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	endTaskDataset.load();
	L5.QuickTips.init();			
}
//待办任务查询
function queryDB(){
	var name=document.getElementById('name').value;
	var organizer=document.getElementById('organizer').value;
	var domination=document.getElementById('domination').value;
	var applyTime=document.getElementById('applyTime').value;
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	daiBanDataset.setParameter("tableKey","CEME_APPLY_ID");
	daiBanDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	if(name!=""){
		allConditon="&E.NAME@LIKE:%"+name+"%";
	}
	if(organizer!=""){
		allConditon+="&ORGANIZER@LIKE:%"+organizer+"%";
	}
	if(domination!=""){
		allConditon+="&DOMINATION@LIKE:%"+domination+"%";
	}
	if(applyTime!=""){
		allConditon+="&E.APPLY_TIME@LIKE:%"+applyTime+"%";
	}
	if(allConditon!=""){
		daiBanDataset.setParameter("mysetwhere","E.PROP@=:"+"1"+allConditon);
	}
	daiBanDataset.load();

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
	var name=document.getElementById('nameYB').value;
	var organizer=document.getElementById('organizerYB').value;
	var domination=document.getElementById('dominationYB').value;
	var applyTime=document.getElementById('applyTimeYB').value;
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	yiBanTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	yiBanTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	if(name!=""){
		allConditon="&E.NAME@LIKE:%"+name+"%";
	}
	if(organizer!=""){
		allConditon+="&ORGANIZER@LIKE:%"+organizer+"%";
	}
	if(domination!=""){
		allConditon+="&DOMINATION@LIKE:%"+domination+"%";
	}
	if(applyTime!=""){
		allConditon+="&E.APPLY_TIME@LIKE:%"+applyTime+"%";
	}
	if(allConditon!=""){
		yiBanTaskDataset.setParameter("mysetwhere","E.PROP@=:"+"1"+allConditon);
	}
	yiBanTaskDataset.load();	
	
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
	var name=document.getElementById('nameEnd').value;
	var organizer=document.getElementById('organizerEnd').value;
	var domination=document.getElementById('dominationEnd').value;
	var applyTime=document.getElementById('applyTimeEnd').value;
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	endTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	endTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	if(name!=""){
		allConditon="&E.NAME@LIKE:%"+name+"%";
	}
	if(organizer!=""){
		allConditon+="&ORGANIZER@LIKE:%"+organizer+"%";
	}
	if(domination!=""){
		allConditon+="&DOMINATION@LIKE:%"+domination+"%";
	}
	if(applyTime!=""){
		allConditon+="&E.APPLY_TIME@LIKE:%"+applyTime+"%";
	}
	if(allConditon!=""){
		endTaskDataset.setParameter("mysetwhere","E.PROP@=:"+"1"+allConditon);
	}	
	endTaskDataset.load();	
	
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
	var taskCode = rec.get("CEME_APPLY_ID");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
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
function showCemeInfoYB(){
	var grid=L5.getCmp("yiBanTaskGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("cemeApplyId",records[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/expendCeme/fisCemeInfoDetail.jsp";
	L5.forward(url,'',data);
	
}
function showCemeInfoEND(){
	var grid=L5.getCmp("endTaskGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	//alert(records[0].get("CEME_APPLY_ID"));
	data.put("cemeApplyId",records[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/expendCeme/fisCemeInfoDetail.jsp";
	L5.forward(url,'',data);
	
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
function renderDate2(value,cellmeta,record){
	var revalue="";
	revalue+= value.substr(0,10);
	return revalue;
}
function renderDate(value,cellmeta,record) {
	var revalue="";
	revalue+= value.substr(0,4)+"-";
	revalue+= value.substr(4,2)+"-";
	revalue+= value.substr(6,2);
//	revalue+= value.substr(8,6);
	return revalue;
}
