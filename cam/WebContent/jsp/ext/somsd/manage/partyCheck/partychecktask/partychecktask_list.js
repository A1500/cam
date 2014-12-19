function init() {
	taskDs.load();
	partyCheckDataSet.setParameter("TASK_ID@=","不存在");
	partyCheckDataSet.load();
	L5.getCmp("editGridPanel").on("rowclick",function(){
		var record = taskDs.getCurrent();
		partyCheckDataSet.setParameter("TASK_ID@=",record.get("taskId"));
		partyCheckDataSet.setParameter("YEARLY@=",record.get("batchYear"));
		partyCheckDataSet.setParameter("CREATE_PEOPLE@=",userId);
		partyCheckDataSet.load();
	});
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function insert() {
	var editGrid=L5.getCmp('editGridPanel');
	var allrecords = partyCheckDataSet.getAllRecords();
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录填报!");
		return false;
	}
	for(i=0;i<allrecords.length;i++){
		var record=allrecords[i];
		var checkY= record.get('batchYear');
		if(year == checkY){
			L5.Msg.alert('提示',"您已经填写了一条年检信息，不能继续增加年检信息!");
			return false;
		}
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("taskId",selected[0].get('taskId'));
	data.put("sorgType",selected[0].get('sorgType'));
	//data.put("batch",selected[0].get('batch'));
	data.put("batchYear",selected[0].get('batchYear'));
	var url='jsp/ext/somsd/manage/partyCheck/edit/groupPartyCheckEdit.jsp';
	var text = '修改SOM_CHECK_TASK';
	L5.forward(url,text,data);
}

function detailCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("ycheckId",selected[0].get('ycheckId'));
	var url='jsp/ext/somsd/manage/partyCheck/detail/groupPartyCheckDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function printCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("ycheckId",selected[0].get('ycheckId'));
	var url='jsp/ext/somsd/manage/partyCheck/print/groupPartyCheckPrint.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function updateCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('checkStatus')!='0' && selected[0].get('checkStatus')!='2'){
		L5.Msg.alert('提示',"已经提交的数据不能修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("ycheckId",selected[0].get('ycheckId'));
	var url='jsp/ext/somsd/manage/partyCheck/edit/groupPartyCheckEdit.jsp';
	var text = '修改年检';
	L5.forward(url,text,data);
}

function submit(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行上报!");
		return false;
	}
	var allrecords = partyCheckDataSet.getAllRecords();
	for(i=0;i<allrecords.length;i++)
	{
		var record=allrecords[i];
		var checkStatus=record.get("checkStatus");
		if(checkStatus!='0' && checkStatus!='2'){
			L5.Msg.alert('提示',"已经存在上报的数据，不能继续上报年检数据!");
			return false;
		}
	}

	if(selected[0].get('checkStatus')=='0' || selected[0].get('checkStatus')=='2'){
		var command = new L5.Command("com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckCommand");
		var date=new Date();
		selected[0].set("checkStatus","1");
		selected[0].set("checkResult","");//把核对不通过的数据，核对结果置为空
		selected[0].set("checkTime","");//把核对不通过的数据，核对时间置为空
		//selected[0].set("modTime",getCurDate()+" "+date.toLocaleTimeString());
		command.setParameter("record", selected[0]);
		command.execute("update");
		if (!command.error) {
			L5.Msg.alert('提示',"上报成功!",function (){
			});
		}else{
			L5.Msg.alert('提示',"上报时出现错误！"+command.error);
		}
	}else{
		L5.Msg.alert('提示',"该数据不能上报!");
		return false;
	}
}