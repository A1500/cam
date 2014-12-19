{var stateNameMap=[];
	stateNameMap["open.running"]="运行";
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
function delProcess(){
	var checkd = page.checkeIsOne("GridPanel")
	var leng = checkd.value.length;
	if(leng < 1){
		L5.Msg.alert("提示：","请至少选择一个流程归档实例");
		return;
	}
	L5.MessageBox.confirm('确定','确定要删除选中的记录吗?',function(state){
	if(state=="yes"){
	var ids = [];
	for(var i=0; i<leng; i++){
		ids[i] = checkd.value[i].get("processId");
	}
	var cmd = new L5.Command("org.loushang.workflow.manage.processend.cmd.ProcessEndManageCmd");
	cmd.setParameter("ids",ids);
	cmd.execute("delete");
	if(!cmd.error){
		for(var i=0; i<leng; i++){
			ds.remove(checkd.value[i]);
		}
		L5.Msg.alert("提示：","删除操作完成");
		ds.reload();
	}else{
		L5.Msg.alert("提示：",cmd.error);
		return;
		}
	}else{
	return false;
		}
	});

}
function toActivity(){
	var checkd = page.checkeIsOne("GridPanel");
	if(!checkd.isOne){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	var proId = checkd.value[0].get("processId")
	var text='环节归档实例列表';
	L5.forward("jsp/workflow/manage/queryactivityendadmin.jsp?proId="+proId,text);
}

function toStateName(value){
	var name = stateNameMap[value];
	return name?name:value;
}
function toState(){

	var selected = page.checkeIsOne("GridPanel");
	if(!selected.isOne){
		L5.Msg.alert("提示：","请选择一条记录");
		return;
	}
	var param ="processId="+selected.value[0].get("processId");
	var url="jsp/workflow/monitor/flowview.jsp?"+param+"&backUrl=jsp/workflow/manage/queryprocessend.jsp[procDefUniqueId:"+beforeInit.id;
	L5.forward(url);
}
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
