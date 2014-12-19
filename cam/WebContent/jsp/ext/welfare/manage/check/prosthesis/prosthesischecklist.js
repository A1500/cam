var serialNum="";
function init(){
	var fitStatusDataSet = L5.DatasetMgr.lookup("fitStatusDataSet");
	fitStatusDataSet.setParameter("COMPANY_NAME@=", username);
	fitStatusDataSet.load(true);
	serialNum=fitStatusDataSet.getAt(0).get("serialNum");
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("applyType","2");
	daiBanDataset.setParameter("dataSource","ONLINE");
	daiBanDataset.setParameter("serialNum",serialNum);
	daiBanDataset.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheckEdit1.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
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
		var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheck1.jsp';
		var text = '认定信息采集';
		L5.forward(url,text,data);
		if(selected[0].get('APPLY_STAUTS')=="2"){
			var taskCode=selected[0].get('TASK_CODE');
			var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
			ApplyDataset.setParameter("TASK_CODE@=",taskCode);
			ApplyDataset.load(true);
			var applyRecord = ApplyDataset.getCurrent();
			applyRecord.set("applyStauts","1");
			var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitApplyCommand");
			command.setParameter("record", applyRecord);
			command.execute("update");
		}
	}
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
				
				//业务信息删除
				
				//apply表信息
				var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
				ApplyDataset.setParameter("TASK_CODE@=",taskCode);
				ApplyDataset.load(true);
				var applyRecord = ApplyDataset.getCurrent();
				var  applyIds=[];
				for(var i=0;i<selected.length;i++){
					applyIds[i]=selected[i].get("TASK_CODE");
				}
				
				//人员信息记录删除
				var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
				wealWorkerDataSet.setParameter("TASK_CODE",taskCode);
				wealWorkerDataSet.load(true);
				var workerRecords = wealWorkerDataSet.getAllRecords();
				var workerIds=[];
				for(var j=0;j<workerRecords.length;j++){
					workerIds[j]=workerRecords[j].get("workerId");
				}
				
				//设施信息
				var wealFitDeviceDataSet = L5.DatasetMgr.lookup("wealFitDeviceDataSet");
				wealFitDeviceDataSet.setParameter("TASK_CODE@=",taskCode);
				wealFitDeviceDataSet.load(true)
				var deviceRecords = wealFitDeviceDataSet.getAllRecords();
				var deviceIds=[];
				for(var k=0;k<deviceRecords.length;k++){
					deviceIds[k]=deviceRecords[k].get("deviceId");
				}
				
				//假肢生产能力
				var productDataSet = L5.DatasetMgr.lookup("productDataSet");
				productDataSet.setParameter("TASK_CODE@=",taskCode);
				productDataSet.load(true)
				var productRecords = productDataSet.getAllRecords();
				var productIds=[];
				for(var t=0;t<productRecords.length;t++){
					productIds[t]=productRecords[t].get("produceId");
				}
				
				var command=new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
				command.setParameter("infoId",taskCode);
				command.setParameter("applyIds",applyIds);
				command.setParameter("productIds",productIds);
				command.setParameter("deviceIds",deviceIds);
				command.setParameter("workerIds",workerIds);
				command.execute("someDelete");
				
				if (!command.error) {
					L5.Msg.alert('提示',"删除成功");
					init();
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}else{
				return false;
			}
		});
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
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheckDetail1.jsp';
	var text = '查看年检明细';
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
			L5.Msg.alert('提示',"被驳回的业务，请修改后再提交！");
			return false;
		}
		daiBanDataset1.setParameter("applyType","2");
		daiBanDataset1.setParameter("dataSource","ONLINE");
		daiBanDataset1.setParameter("serialNum",serialNum);
		daiBanDataset1.setParameter("applyYear",selected[0].get('APPLY_YEAR'));
		daiBanDataset1.load(true);
		var records = daiBanDataset1.getAllRecords();
		var count = 0;
		for(var i=0;i<records.length;i++){
			if(records[i].get("APPLY_STAUTS")!="1"&&records[i].get("APPLY_STAUTS")!="2"){
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
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitApplyCommand");
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