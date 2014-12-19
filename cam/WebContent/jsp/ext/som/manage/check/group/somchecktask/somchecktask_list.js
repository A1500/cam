function init() {
	taskDs.load();
	checkDs.setParameter("TASK_ID@=","不存在");
	checkDs.setParameter("FILL_PEOPLE_ID@=","不存在");
	checkDs.load();
	L5.getCmp("editGridPanel").on("rowclick",function(g,rowIndex,e){
		checkDs.removeAll();
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		checkDs.setParameter("TASK_ID",record.get("taskId"));
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
	taskDs.setParameter("SOM_CHECK_TASK.BATCH@=",getParam("batch"));		
	taskDs.setParameter("SOM_CHECK_TASK.BATCH_YEAR@=",getParam("batchYear"));		
	taskDs.setParameter("SOM_CHECK_TASK.IF_VALID@=",getParam("ifValid"));		
	taskDs.load();
}

function insert() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录填报!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("taskId",selected[0].get('taskId'));
	data.put("batch",selected[0].get('batch'));
	data.put("batchYear",selected[0].get('batchYear'));
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit1.jsp';
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
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit1.jsp';
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
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail1.jsp';
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
	if(selected[0].get('status')!='0' && selected[0].get('status')!='4'){
		L5.Msg.alert('提示',"已经提交的数据不能修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit1.jsp';
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
		L5.Msg.alert('提示',"请选择一条记录进行提交!");
		return false;
	}
	if(selected[0].get('status')=='0' || selected[0].get('status')=='4'){
		var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
		command.setParameter("taskCode", selected[0].get('taskCode'));
		command.setParameter("status", "1");
		command.execute("submit");
		if (!command.error) {
			L5.Msg.alert("提示","提交成功！",function(){
				init();
			});		
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	}else{
		L5.Msg.alert('提示',"该数据不能提交!");
		return false;
	}
}

