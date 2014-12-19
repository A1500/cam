function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("applyStauts","0");
	daiBanDataset.setParameter("applyType","1");
	daiBanDataset.setParameter("morgArea",organCode+"%");
	daiBanDataset.load();
	var yiBanDataset = L5.DatasetMgr.lookup("yiBanDataset");
	yiBanDataset.setParameter("applyStauts","3");
	yiBanDataset.setParameter("applyType","1");
	yiBanDataset.setParameter("morgArea",organCode+"%");
	yiBanDataset.load();
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName").value;
	daiBanDataset.setParameter("applyStauts","0");
	daiBanDataset.setParameter("applyType","1");
	daiBanDataset.setParameter("morgArea",organCode+"%");
	daiBanDataset.setParameter("companyName",'%'+queryCompanyName+'%');
	daiBanDataset.load();
}
function queryYiban(){
	var yiBanDataset = L5.DatasetMgr.lookup("yiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName1").value;
	yiBanDataset.setParameter("applyStauts","3");
	yiBanDataset.setParameter("applyType","1");
	yiBanDataset.setParameter("morgArea",organCode+"%");
	yiBanDataset.setParameter("companyName",'%'+queryCompanyName+'%');
	yiBanDataset.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/welfareapply1.jsp';
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
	if(selected[0].get("DATA_SOURCE")=="ONLINE"){
		L5.Msg.alert('提示',"外网提交的数据，不能删除!");
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
			var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
			wealUnitInfoDataSet.setParameter("TASK_CODE@=",taskCode);
			var infoRecord = wealUnitInfoDataSet.getCurrent();
			var infoCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealUnitInfoCommand");
			infoCommand.setParameter("delIds", infoIds);
			infoCommand.execute("delete");
			if (!infoCommand.error) {
				wealUnitInfoDataSet.commitChanges();
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
			var applyCommand=new L5.Command("com.inspur.cams.welfare.base.cmd.WealUnitApplyCommand");
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
				wealWorkerDataSet.commitChanges();
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
	if(selected[0].get("DATA_SOURCE")=="ONLINE"){
		L5.Msg.alert('提示',"外网提交的数据，不能修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/welfareapply1.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
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
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/detail/welfareapply1Detail.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
}
function detailYiban(){
	var editGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/detail/welfareapply1Detail.jsp';
	var text = '认定信息采集';
	L5.forward(url,text,data);
}
function reject(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("DATA_SOURCE")!="ONLINE"){
		L5.Msg.alert('提示',"内网填写的数据，不能够被驳回!");
	}else{
		var taskCode=selected[0].get('TASK_CODE');
		var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
		ApplyDataset.setParameter("TASK_CODE@=",taskCode);
		ApplyDataset.load(true);
		var applyRecord = ApplyDataset.getCurrent();
		applyRecord.set("applyStauts","2");
		var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealUnitApplyCommand");
		command.setParameter("record", applyRecord);
		command.execute("update");
		if(!command.error){
			L5.Msg.alert('提示','业务已驳回！');
			init();
		}else{
			L5.Msg.alert('提示',"业务驳回时出现错误！"+command.error);
		}
	}
}
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
	command.setParameter("record", selected[0]);
	command.execute("createAndSendQualification");
	if(!command.error){
		queryDaiban();
		L5.Msg.alert('提示','成功提交至下一环节！');
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}