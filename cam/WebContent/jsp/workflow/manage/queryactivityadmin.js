{
	var stateNameMap = [];
	stateNameMap["open.running"]="运行";
	stateNameMap["open.not_running.suspended"]="挂起";
	stateNameMap["closed.completed"]="结束";
	stateNameMap["closed.aborted"]="中断";
	stateNameMap["closed.terminated"]="终止";
	stateNameMap["open.not_running.not_started"]="未开始";
}


function init(){
	ds.baseParams["process_id@="]=beforeInit.proId;
	var processId=beforeInit.proId;
	ds.setParameter("processId",processId);
	ds.load();
}
function toAssignment(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	var activityId = selected[0].get("activityId");
	var actDefName = selected[0].get("actDefName");
	var url = "jsp/workflow/manage/queryassignmentadmin.jsp?actId="+activityId+"&actDefName="+actDefName;
	url = encodeURI(encodeURI(url));
	var text='委派列表';
	
	L5.forward(url,text);
}
function suspend(){
	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个环节实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="确认要挂起环节实例？";
	var okMsg="挂起操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var suspend = [];
		suspend[0] = selected[0].get("activityId");
		var cmd = new L5.Command("org.loushang.workflow.manage.activity.cmd.ActivityManageCmd");
		cmd.setParameter("suspends",suspend);
		cmd.execute("suspend");
		if(!cmd.error){
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
		alert("请至少选择一个环节实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="确认要中断环节实例？";
	var okMsg="中断操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var abort = [];
		abort[0] = selected[0].get("activityId");
		var cmd = new L5.Command("org.loushang.workflow.manage.activity.cmd.ActivityManageCmd");
		cmd.setParameter("aborts",abort);
		cmd.execute("abort");
		if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});

}
function resume(){

	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个环节实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="确认要恢复挂起环节？";
	var okMsg="恢复操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var resume = [];
		resume[0] = selected[0].get("activityId");
		var cmd = new L5.Command("org.loushang.workflow.manage.activity.cmd.ActivityManageCmd");
		cmd.setParameter("resumes",resume);
		cmd.execute("resume");
		if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}
function terminate(){

	var selected=L5.getCmp('GridPanel').getSelectionModel().getSelections();
	if(selected.length<1){
		alert("请至少选择一个环节实例进行操作！");
		return;
	}
	var confirm="确认";
	var nestconfirm="确认要终止环节实例？";
	var okMsg="终止操作成功";
	L5.MessageBox.confirm(confirm,nestconfirm,function(state){
		if(state=="yes"){
 		var terminate = [];
		terminate[0] = selected[0].get("activityId");
		var cmd = new L5.Command("org.loushang.workflow.manage.activity.cmd.ActivityManageCmd");
		cmd.setParameter("terminates",terminate);
		cmd.execute("terminate");
		if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：",okMsg);
		}else{
		L5.Msg.alert("错误：",cmd.error);
			}
		}
	});
}
function toProcess(){
	var url = "jsp/workflow/manage/queryprocessadmin.jsp";
	var text='活动流程实例';
	L5.forward(url,text);
}
function start(){
	var url="activitystarthelper.jsp?processId="+beforeInit.proId;
	var values=  showModalDialog(url,
	                             null,
	                             "center:yes;scroll:yes;status:no;dialogWidth:530px;dialogHeight:280px");
    if(values==null||values==undefined){
     	return;
     }
    var organs=values.organs.split(";");
    var organsString=organs[0]+";"+organs[1];
	var cmd = new L5.Command("org.loushang.workflow.manage.activity.cmd.ActivityManageCmd");
	cmd.setParameter("processId",beforeInit.proId);
	cmd.setParameter("actDefUniqueId",values.actDefUniqueId);
	cmd.setParameter("organs",organsString);
	cmd.execute("start");
	if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：","启动环节完成");
	}else{
		L5.Msg.alert("提示：",cmd.error);
	}
}
//流转状态图
function toStateName(value){
	var name = stateNameMap[value];
	return name?name:value;
}
function rendererProName(){
	return beforeInit.procDefName;
}
function silent(){L5.Msg.alert("未实现");}
var page;
if(!page) page={};




