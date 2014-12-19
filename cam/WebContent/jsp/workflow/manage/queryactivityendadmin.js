{
	var stateNameMap = [];
	stateNameMap["open.running"]="运行";
	stateNameMap["closed.completed"]="结束";
	stateNameMap["closed.aborted"]="终止";
	stateNameMap["open.not_running.not_started"]="未开始";
}
function init(){
	ds.baseParams["process_id@="]=beforeInit.proId;
	var processId=beforeInit.proId;
	ds.setParameter("processId",processId);
	ds.load();
}

function toAssignment(){
	var checkd = page.checkeIsOne("GridPanel");
	if(!checkd.isOne){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	var activityId = checkd.value.get("activityId");
	var text='委派归档列表';
	L5.forward("jsp/workflow/manage/queryassignmentendadmin.jsp?actId="+activityId,text);
}
function toProcess(){
	var url = "jsp/workflow/manage/queryprocessend.jsp";
	var text='归档流程实例';
	L5.forward(url,text);
}
function toStateName(value){
	var name = stateNameMap[value];
	return name?name:value;
}
var page;
if(!page) page={};
//检查当前选中记录情况
page.checkeIsOne=function(gridPanId){
	var checks =L5.getCmp(gridPanId).getSelectionModel().getSelections();
	var checkd={};
	if(checks.length ==1){
		checkd.isOne=true;
		checkd.value=checks[0];
	}
	else {
		checkd.isOne = false;
		checkd.value=checks;
	}
	return checkd;
}