function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("companyName",username+"%");
	daiBanDataset.setParameter("applyType","1");
	daiBanDataset.setParameter("dataSource","ONLINE");
	daiBanDataset.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt1.jsp';
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
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var taskCode=selected[0].get("TASK_CODE");
			
			//业务信息删除
			var  infoIds=[];
			for(var i=0;i<selected.length;i++){
				infoIds[i]=selected[i].get("TASK_CODE");
			}
			
			var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
			wealFitInfoDataSet.setParameter("TASK_CODE@=",taskCode);
			var infoRecord = wealFitInfoDataSet.getCurrent();
			var infoCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitInfoCommand");
			infoCommand.setParameter("delIds", infoIds);
			infoCommand.execute("delete");
			
			if (!infoCommand.error) {
			   // wealFitInfoDataSet.remove(infoRecord);
				wealFitInfoDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+infoCommand.error);
			}
			
			
			//apply表信息
			var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
			ApplyDataset.setParameter("TASK_CODE@=",taskCode);
			ApplyDataset.load
			var applyRecord = ApplyDataset.getCurrent();
			var  applyIds=[];
			for(var i=0;i<selected.length;i++){
				applyIds[i]=selected[i].get("TASK_CODE");
			}
			
			var applyCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitApplyCommand");
			applyCommand.setParameter("delIds", applyIds);
			applyCommand.execute("delete");
			
			if (!applyCommand.error) {
			    //ApplyDataset.remove(applyRecord);
				ApplyDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+applyCommand.error);
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
			var workerCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealWorkerCommand");
			workerCommand.setParameter("delIds", workerIds);
			workerCommand.execute("delete");
			if(!workerCommand.error){
				//for(var i=0;i<workerRecords.length;i++){
				//	wealWorkerDataSet.remove(workerRecords[i]);
				//}
				wealWorkerDataSet.commitChanges();
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
			var deviceCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitDeviceCommand");
			deviceCommand.setParameter("delIds",deviceIds);
			deviceCommand.execute("delete");
			if (!deviceCommand.error) {
				//for(var i=0;i<deviceRecords.length;i++){
				//	wealFitDeviceDataSet.remove(deviceRecords[i]);
				//}
				wealFitDeviceDataSet.commitChanges();
				
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
			var productCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitProductivepowerCommand");
			productCommand.setParameter("delIds",productIds);
			productCommand.execute("delete");
			if(!productCommand.error){
				//for(var i=0;i<productRecords.length;i++){
				//	productDataSet.remove(productRecords[i]);
				//}
				productDataSet.commitChanges();
			}
			
			init();
		}else{
			return false;
		}
	});
	
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
		return false;
	}else{
		var data = new L5.Map();
		data.put("method","UPDATE");
		data.put("taskCode",selected[0].get('TASK_CODE'));
		var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt1.jsp';
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
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExtDetail1.jsp';
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
		L5.Msg.alert('提示',"此记录已经受理，不能重复提交！");
		return false;
	}
	if(selected[0].get('APPLY_STAUTS')=="2"){
		L5.Msg.alert('提示',"被驳回的业务，请修改后再提交！");
		return false;
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