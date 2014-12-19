function init() {
	taskDs.load();
	checkDs.setParameter("TASK_ID@=","不存在");
	checkDs.setParameter("FILL_PEOPLE_ID@=","不存在");
	checkDs.load();
	L5.getCmp("editGridPanel").on("rowclick",function(){
		var record = taskDs.getCurrent();
		checkDs.setParameter("TASK_ID",record.get("taskId"));
		checkDs.setParameter("BATCH_YEAR",record.get("batchYear"));
		checkDs.setParameter("FILL_PEOPLE_ID",userId);
		checkDs.load();
	});
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){

	taskDs.setParameter("SOM_CHECK_TASK.TASK_NAME@LIKE","%"+getParam("taskName")+"%");
	//taskDs.setParameter("SOM_CHECK_TASK.BATCH@=",getParam("batch"));
	taskDs.setParameter("SOM_CHECK_TASK.BATCH_YEAR@=",getParam("batchYear"));
	taskDs.setParameter("SOM_CHECK_TASK.IF_VALID@=",getParam("ifValid"));
	taskDs.load();
}

function insert() {
	var editGrid=L5.getCmp('editGridPanel');
	var allrecords = checkDs.getAllRecords();
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录填报!");
		return false;
	}
	for(i=0;i<allrecords.length;i++){
		var record=allrecords[i];
		var checkY= record.get('batchYear');
		//if(year == checkY){
			L5.Msg.alert('提示',"您已经填写了一条年检信息，不能继续增加年检信息!");
			return false;
		//}
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("taskId",selected[0].get('taskId'));
	//data.put("batch",selected[0].get('batch'));
	data.put("batchYear",selected[0].get('batchYear'));
	var url='jsp/ext/somsd/manage/check/ungov/edit/ungovCheckEdit1.jsp';
	var text = '修改SOM_CHECK_TASK';
	L5.forward(url,text,data);
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('taskId'));
	var url='jsp/ext/somsd/manage/check/ungov/edit/ungovCheckEdit1.jsp';
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
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/ext/somsd/manage/check/ungov/detail/ungovCheckDetail1.jsp';
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
	L5.getCmp('winPrint').show();
}
function confirmPrint(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	//var printPart=document.getElementById('printPart').value;
	var url='';
	//if(printPart==1){
		url='jsp/ext/somsd/manage/check/ungov/print/ungovCheckPrint1.jsp';
	//}else{
	//	url='jsp/ext/somsd/manage/check/ungov/print/ungovCheckPrint6.jsp';
	//}
	var text = '年检明细';
	L5.forward(url,text,data);
}
function closePrint(){
	L5.getCmp('winPrint').hide();
}
function updateCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('status')!='0' && selected[0].get('status')!='4'){
		L5.Msg.alert('提示',"已经提交的数据不能修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/ext/somsd/manage/check/ungov/edit/ungovCheckEdit1.jsp';
	var text = '修改年检';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("taskId");
			}
			var command=new L5.Command("com.inspur.cams.sorg.check.checktask.cmd.SomCheckTaskCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	taskDs.remove(selected[i]);
				}
				taskDs.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function submit(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行上报!");
		return false;
	}
	var allrecords = checkDs.getAllRecords();
	for(i=0;i<allrecords.length;i++)
	{
		var record=allrecords[i];
		var status=record.get("status");
		if(status!='0' && status!='4'){
			L5.Msg.alert('提示',"已经存在上报的数据，不能继续上报年检数据!");
			return false;
		}
	}

	if(selected[0].get('status')=='0' || selected[0].get('status')=='4'){
		var cmd = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
		cmd.setParameter("sorgType", "ungov_");
		cmd.setParameter("taskCode", selected[0].get('taskCode'));
		cmd.afterExecute = function(){
			var flag =cmd.getReturn('flag');
			if(flag == 'true'){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				partyCheckDataSet.setParameter("TASK_ID@=", selected[0].get('taskId'));
				partyCheckDataSet.setParameter("YEARLY@=",selected[0].get("batchYear"));
				partyCheckDataSet.setParameter("CHECK_STATUS@<>","0");
				partyCheckDataSet.load();
				partyCheckDataSet.on("load",function(ds){
					if(ds.getCount()>0){
						var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
						command.setParameter("taskCode", selected[0].get('taskCode'));
						command.setParameter("status", "1");
						command.execute("submit");
						if (!command.error) {
							L5.Msg.alert("提示","上报后，请及时注意校对结果。\n如果校对通过，请打印纸制年检报告书一式两份，\n报业务主管单位初审盖章后，携财务审计报告到省民政厅盖章！\n如果校对不通过，请电话联系省民管局工作人员。",function(){
								L5.Msg.alert('提示',"上报成功!",function (){
									init();
								});
							});
						}else{
							L5.Msg.alert('提示',"上报时出现错误！"+command.error);
						}
					}else{
						L5.Msg.alert('提示',"请先提交该年份的党建年检情况，再进行上报！");
					}
				});
			}else{
				L5.Msg.alert('提示',flag+"无法上报！");
			}
		};
		cmd.execute("queryForReport");
	}else{
		L5.Msg.alert('提示',"该数据不能上报!");
		return false;
	}
}
function clickShowHref(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("status")=="4"){
		return '<a href="javascript:clickShow(\'' + dataset.indexOf(record) + '\')">' + '点击查看' + '</a>';
	}else{
		return '';
	}
}
function clickShow(index){
    var record= checkDs.getAt(index);
	var correctNotReason = record.get("correctNotReason");
	var win = L5.getCmp("correctNotPassReasonWin");
	win.show();
	document.getElementById("correctNotReason").value=correctNotReason;
}
function closeCorrectNotPassReasonWin(){
	var win = L5.getCmp("correctNotPassReasonWin");
	win.hide();
}
function changeColor(value,cellmeta,record,rowindex,colindex,dataset){
	var returnText = "";
	somCheckStatus.each(function(record){
		if(value && value==record.get("value")){
			returnText = record.get("text");
			return false;
		}
	});
	//状态为已经接收的给予提醒
	if(value=="3"){
		L5.Msg.alert('提示',"年检材料已通过审查成功接收，请打印年检材料一式两份并提交到民政相关部门！");
	}
	if(value=="4"){
		return "<label style='color:red'>"+returnText+"</label>";
	}else{
		return returnText;
	}
}
