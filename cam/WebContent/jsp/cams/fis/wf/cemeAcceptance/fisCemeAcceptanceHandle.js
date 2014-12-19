function init(){
	if(organType==13){
		act="'县级发起','县级整顿'";		
	}if(organType==12){
		act="'市级审核'";		
	}else if(organType==11){
		act="'省级审批'";
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
	var fillOrganName=document.getElementById('fillOrganName').value;
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	daiBanDataset.setParameter("tableKey","CEME_APPLY_ID");
	daiBanDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	var allConditon1="";
	if(name!=""){
		allConditon+="&A.NAME@LIKE:%"+name+"%";
		allConditon1+="&AA.NAME@LIKE:%"+name+"%";
	}
	if(fillOrganName!=""){
		allConditon+="&T.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
		allConditon1+="&TA.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
	}
	daiBanDataset.setParameter("mysetwhere","A.PROP@=:"+"2"+allConditon);
	daiBanDataset.setParameter("mysetwhere1","AA.PROP@=:"+"2"+allConditon1);
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
	var fillOrganName=document.getElementById('fillOrganNameYB').value;
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	yiBanTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	yiBanTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	var allConditon1="";
	if(name!=""){
		allConditon+="&A.NAME@LIKE:%"+name+"%";
		allConditon1+="&AA.NAME@LIKE:%"+name+"%";
	}
	if(fillOrganName!=""){
		allConditon+="&T.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
		allConditon1+="&TA.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
	}
	yiBanTaskDataset.setParameter("mysetwhere","A.PROP@=:"+"2"+allConditon);
	yiBanTaskDataset.setParameter("mysetwhere1","AA.PROP@=:"+"2"+allConditon1);
	yiBanTaskDataset.load();	
	
}
//已办任务查看公墓信息
function handleyiban(){
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	
	var data=new L5.Map();
	//alert(records[0].get("CEME_APPLY_ID"));
	data.put("cemeApplyId",selected[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/cemeAcceptance/fisCemeAcceptanceDetail.jsp";
	L5.forward(url,'',data);
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
	var fillOrganName=document.getElementById('fillOrganNameEnd').value;
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","FIS_CEME_APPLY_INFO");
	endTaskDataset.setParameter("tableKey","CEME_APPLY_ID");
	endTaskDataset.setParameter("applyShowColum","CEME_APPLY_ID,APPLY_FLAG,CUR_ORGAN_CODE,CUR_ORGAN,REC_TIME");
	var allConditon="";
	var allConditon1="";
	if(name!=""){
		allConditon+="&A.NAME@LIKE:%"+name+"%";
		allConditon1+="&AA.NAME@LIKE:%"+name+"%";
	}
	if(fillOrganName!=""){
		allConditon+="&T.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
		allConditon1+="&TA.FILL_ORGAN_NAME@LIKE:%"+fillOrganName+"%";
	}
	endTaskDataset.setParameter("mysetwhere","A.PROP@=:"+"2"+allConditon);
	endTaskDataset.setParameter("mysetwhere1","AA.PROP@=:"+"2"+allConditon1);
	endTaskDataset.load();	
	
}
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("endTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var data=new L5.Map();
	//alert(records[0].get("CEME_APPLY_ID"));
	data.put("cemeApplyId",selected[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/cemeAcceptance/fisCemeAcceptanceDetail.jsp";
	L5.forward(url,'',data);
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
function showCemeInfo(){
	var grid=L5.getCmp("daiBanTaskGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	//alert(records[0].get("CEME_APPLY_ID"));
	data.put("cemeApplyId",records[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/createCemeOperation/fisCemeInfoDetail.jsp";
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