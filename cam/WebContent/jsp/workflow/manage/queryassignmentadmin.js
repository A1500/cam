function init(){
	ds.baseParams["activity_id@="]=beforeInit.actId;
	ds.setParameter("activityId",beforeInit.actId);
	ds.load();
}
function toActivity(){
	var text='环节实例列表';
	L5.forward("jsp/workflow/manage/queryactivityadmin.jsp",text);
}
function addName(){
	return beforeInit.actDefName;
}
function cancelAssign(){
	var checks = page.checkeIsOne("GridPanel");
	var leng = checks.value.length;//value is array
	if(leng < 1){
		L5.Msg.alert("提示：","请选择一个委派实例进行操作");
		return;
	}
	var id =null ;
		if(checks.value[0].get("status") == "TASK_CANCELLED"){
			L5.Msg.alert("提示：","当前委派已经被取消！");
			return;
		}
		id = checks.value[0].get("assignmentId");
	var cmd = new L5.Command("org.loushang.workflow.manage.assignment.cmd.AssignmentManageCmd");
	cmd.setParameter("assignmentId",id);
	cmd.execute("cancelAssign");
	if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：","取消委派操作成功");
	}else{
		L5.Msg.alert("提示：",cmd.error);
	}
}
function reAssign(){
	var values=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=8&isExact=0&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	//如果用户关闭弹出框，直接返回
	if(!values)
	{
		return;
	}
	var idCol = 0;
	var nameCol = 1;
	var vlist = values.split(";");
	//用户点击了清除按钮
	if(vlist[0]=="")
	{
		return;
	}
	var listId= vlist[idCol].split(",");
	var listName=vlist[nameCol].split(",");
	
	var leng =  listId.length;
//	if(leng < 1){ return;}
	var list = new L5.List();
	for(var i =0; i<leng; i++){
		var map = new L5.Map();
		map.put("organId",listId[i]);
		map.put("organName",listName[i]);
		list.add(map);
	}
	var cmd = new L5.Command("org.loushang.workflow.manage.assignment.cmd.AssignmentManageCmd");
	cmd.setParameter("actOrganList",list);
	cmd.setParameter("activityId",beforeInit.actId);
	cmd.execute("reAssign");
	if(!cmd.error){
		ds.reload();
		L5.Msg.alert("提示：","重新委派操作完成");
	}else{
		L5.Msg.alert("提示：",cmd.error);
	}
}
function toStateName(value){
	return stateName[value]? stateName[value]:
	                         value;
}
var stateName=[];
stateName["TASK_CANCELLED"] = "取消";
stateName["TASK_SENT"] = "发送";
stateName["TASK_COMPLETED"] = "完成";
var page;
if(!page) page={};
//检查当前选中记录情况
page.checkeIsOne=function(gridPanId){
	var checks =L5.getCmp(gridPanId).getSelectionModel().getSelections();
	var checkd={};
	if(checks.length ==1){
		checkd.isOne=true;
	}
	else {
		checkd.isOne = false;
	}
	checkd.value=checks;
	return checkd;
}

