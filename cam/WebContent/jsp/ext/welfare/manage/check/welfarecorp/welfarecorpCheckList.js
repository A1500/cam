var serialNum = "";
function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var unitStatusDataSet1 = L5.DatasetMgr.lookup("unitStatusDataSet1");
	unitStatusDataSet1.setParameter("COMPANY_NAME@=", username);
	unitStatusDataSet1.load(true);
	serialNum=unitStatusDataSet1.getAt(0).get("serialNum");
	daiBanDataset.setParameter("dataSource","ONLINE");
	daiBanDataset.setParameter("applyType","2");
	daiBanDataset.setParameter("serialNum",serialNum);
	daiBanDataset.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheckEdit.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
	
}
function del(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	if(selected[0].get('APPLY_STAUTS')!="1"&&selected[0].get('APPLY_STAUTS')!="2"){
		L5.Msg.alert('提示',"此记录已经受理，不能删除！");
	}else{
		L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
			if(state=="yes"){
				var taskCode=selected[0].get("TASK_CODE");
				var command=new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
				command.setParameter("taskCode",taskCode);
				command.execute("someDelete");
				if(!command.error){
					L5.Msg.alert('提示',"删除成功");
					init();
				}else{
					L5.Msg.alert('提示',"删除时出现错误！"+command.error);
				}
				
			}else{
				return false;
			}
		});
	}
}
function edit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get('APPLY_STAUTS')!="1"&&selected[0].get('APPLY_STAUTS')!="2"){
		L5.Msg.alert('提示',"此记录已经受理，不能修改！");
	}else{
		var data = new L5.Map();
		data.put("method","UPDATE");
		data.put("taskCode",selected[0].get('TASK_CODE'));
		var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheck1.jsp';
		var text = '认定信息采集';
		L5.forward(url,text,data);
		if(selected[0].get('APPLY_STAUTS')=="2"){
			var taskCode=selected[0].get('TASK_CODE');
			var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
			ApplyDataset.setParameter("TASK_CODE@=",taskCode);
			ApplyDataset.load(true);
			var applyRecord = ApplyDataset.getCurrent();
			applyRecord.set("applyStauts","1");
			var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealUnitApplyCommand");
			command.setParameter("record", applyRecord);
			command.execute("update");
		}
	}
}
function detailDaiban(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheckDetail1.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
}
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get('APPLY_STAUTS')!="1"&&selected[0].get('APPLY_STAUTS')!="2"){
		L5.Msg.alert('提示',"此记录已经受理，不能提交！");
	}else{
		if(selected[0].get('APPLY_STAUTS')=="2"){
			L5.Msg.alert('提示',"被驳回的业务，请修改后再提交! ");
			return false;
		}
		var daiBanDataset1 = L5.DatasetMgr.lookup("daiBanDataset1");
		daiBanDataset1.setParameter("dataSource","ONLINE");
		daiBanDataset1.setParameter("applyType","2");
		daiBanDataset1.setParameter("serialNum",serialNum);
		daiBanDataset1.setParameter("applyYear",selected[0].get('APPLY_YEAR'));
		daiBanDataset1.load(true);
		var records = daiBanDataset1.getAllRecords();
		var count=0;
		for(var i=0;i<records.length;i++){
			if(records[i].get('APPLY_STAUTS')!="1"&&records[i].get('APPLY_STAUTS')!="2"){
				count++;
			}
		}
		if(count>=1){
			L5.Msg.alert('提示',"同一年度业务，正在受理，不能重复提交");
			return false;
		}
	}
	var taskCode=selected[0].get('TASK_CODE');
	var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
	ApplyDataset.setParameter("TASK_CODE@=",taskCode);
	ApplyDataset.load(true);
	var applyRecord = ApplyDataset.getCurrent();
	applyRecord.set("applyStauts","0");
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealUnitApplyCommand");
	command.setParameter("record", applyRecord);
	command.execute("update");
	if(!command.error){
		init();
		L5.Msg.alert('提示','成功提交至民政部门！');
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
function statusRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	if(record.get("APPLY_STAUTS")== "1") {
		return "保存";
	} else if(record.get("APPLY_STAUTS")== "0") {
		return "提交";
	}else if(record.get("APPLY_STAUTS")== "2") {
		return "驳回";
	}else if(record.get("APPLY_STAUTS")== "3") {
		return "已受理";
	}else if(record.get("APPLY_STAUTS")== "4") {
		return "审批通过";
	}else if(record.get("APPLY_STAUTS")== "5") {
		return "审批不通过";
	}
	return '';
}