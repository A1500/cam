{var stateNameMap=[];
	stateNameMap["open.running"]="运行";
	stateNameMap["open.not_running.suspended"]="挂起";
}
function init(){
	ds.baseParams["PROC_DEF_UNIQUE_ID@="]=beforeInit.id;
	var id=beforeInit.id;
	ds.setParameter("procDefUniqueId",id);
	ds.load();
}
function query(){
	var subject = document.getElementById("subjectName").value;
	if(subject.indexOf("'")!=-1){
	  L5.Msg.alert("提示","查询条件不接受单引号输入!");
	  return;
	}
	ds.setParameter("procDefUniqueId",beforeInit.id);
	ds.setParameter("subjectName@like",subject);
	ds.load();
}
function suspend(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();

	if(selected.length<1){
		alert("请至少选择一个流程实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="确认要挂起流程吗？";
	var okMsg="挂起操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var suspends = [];
 		for(i=0;i<selected.length;i++)
 		{
 			suspends[i] = selected[i].get("processId");
 		}
		var cmd = new L5.Command("org.loushang.workflow.manage.process.cmd.ProcessManageCmd");
		cmd.setParameter("suspends",suspends);
		cmd.execute("suspend");
		if(!cmd.error){
		L5.getCmp('GridPanel').getSelectionModel().clearSelections();
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}

function abort(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个流程实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="该操作将结束流程实例，确认执行此操作吗？";
	var okMsg="中断操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var aborts = [];
 		for(var i=0;i<selected.length;i++)
 		{
 			aborts[i] = selected[i].get("processId");
 		}
		var cmd = new L5.Command("org.loushang.workflow.manage.process.cmd.ProcessManageCmd");
		cmd.setParameter("aborts",aborts);
		cmd.execute("abort");
		if(!cmd.error){
		L5.getCmp('GridPanel').getSelectionModel().clearSelections();
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}


function terminate(){
//	page.commonOpr("terminate","'确定'","'此操作将结束流程实例，确认要终止吗？'","终止操作成功");
		var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个流程实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="此操作将结束流程实例，确认要终止吗？";
	var okMsg="终止操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var terminates = [];
 		for(var i=0;i<selected.length;i++)
 		{
 			terminates[i] = selected[i].get("processId");
 		}
		var cmd = new L5.Command("org.loushang.workflow.manage.process.cmd.ProcessManageCmd");
		cmd.setParameter("terminates",terminates);
		cmd.execute("terminate");
		if(!cmd.error){
		L5.getCmp('GridPanel').getSelectionModel().clearSelections();
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}

function dele(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个流程实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="此操作将删除流程实例，确认要删除吗？";
	var okMsg="删除操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var deletes = [];
 		for(var i=0;i<selected.length;i++)
 		{
 			deletes[i] = selected[i].get("processId");
 		}
		var cmd = new L5.Command("org.loushang.workflow.manage.process.cmd.ProcessManageCmd");
		cmd.setParameter("processIds",deletes);
		cmd.execute("directDelete");
		if(!cmd.error){
		L5.getCmp('GridPanel').getSelectionModel().clearSelections();
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}

function toActivity(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	var proId = selected[0].get("processId")
	var procDefName = selected[0].get("procDefName");
	var url = "jsp/workflow/manage/queryactivityadmin.jsp?proId="+proId+"&procDefName="+procDefName;
	url = encodeURI(encodeURI(url));
	var text='环节实例列表';
	L5.forward(url,text);
}

function toStateName(value){
	var name = stateNameMap[value];
	return name?name:value;
}
function toState(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	if(!ds.getCurrent()){
		return;
	}
		var param ="processId="+ds.getCurrent().get("processId");
		var url="jsp/workflow/monitor/flowview.jsp?"+param+"&backUrl=jsp/workflow/manage/queryprocessadmin.jsp[procDefUniqueId:"+beforeInit.id;
	L5.forward(url);
}
var page;
if(!page) page={};

function resume(){

	var selected=L5.getCmp("GridPanel").getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("系统提示","请选择流程实例进行操作！");
     return false;
	}
	for(i=0;i<selected.length;i++)
	{
		if(selected[i].get("currentState")=="open.running")
		{
			L5.Msg.alert("系统提示","正在运行流程不能执行恢复操作，请选择挂起流程实例！");
			return;
		}
	}
	
	var confirm="确认";
	var nestconfirm="确认恢复流程？";
	var okMsg="恢复操作成功";

	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var resumes = [];
 		for(i=0;i<selected.length;i++)
 		{
 			resumes[i] = selected[i].get("processId");
 		}
		var cmd = new L5.Command("org.loushang.workflow.manage.process.cmd.ProcessManageCmd");
		cmd.setParameter("resumes",resumes);
		cmd.execute("resume");
		if(!cmd.error){
		L5.getCmp('GridPanel').getSelectionModel().clearSelections();
			ds.reload();
			L5.Msg.alert("提示：",okMsg);
		}else{
			L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}
