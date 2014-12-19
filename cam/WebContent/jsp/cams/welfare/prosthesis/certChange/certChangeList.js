function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("applyStauts","0");
	daiBanDataset.setParameter("applyType","3");
	daiBanDataset.load();
	var yiBanDataset = L5.DatasetMgr.lookup("yiBanDataset");
	yiBanDataset.setParameter("applyStauts","3");
	yiBanDataset.setParameter("applyType","3");
	yiBanDataset.load();
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName").value;
	daiBanDataset.setParameter("applyStauts","0");
	daiBanDataset.setParameter("applyType","3");
	daiBanDataset.setParameter("companyName",'%'+queryCompanyName+'%');
	daiBanDataset.load();
}
function queryYiban(){
	var yiBanDataset = L5.DatasetMgr.lookup("yiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName1").value;
	yiBanDataset.setParameter("applyStauts","3");
	yiBanDataset.setParameter("applyType","3");
	yiBanDataset.setParameter("companyName",'%'+queryCompanyName+'%');
	yiBanDataset.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/prosthesis/certChange/tasklist/certChangeAddList.jsp';
	var text = '换证信息采集';
	L5.forward(url,text,data);
	
}
function del(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var taskCode=selected[0].get("TASK_CODE");
			//业务信息删除
			//apply表信息
			var ApplyDataset = L5.DatasetMgr.lookup("ApplyDataset");
			ApplyDataset.setParameter("TASK_CODE@=",taskCode);
			ApplyDataset.load
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
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
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
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/welfare/prosthesis/certChange/info/fitCertChangeEdit1.jsp';
	var text = '换证信息采集';
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
	var url='jsp/cams/welfare/prosthesis/certChange/info/fitCertChangeDetail1.jsp';
	var text = '换证信息采集';
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
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/detail/prosthesisapply1Detail.jsp';
	var text = '换证信息采集';
	L5.forward(url,text,data);
}
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
	command.setParameter("record", selected[0]);
	command.execute("createAndSendCertChange");
	if(!command.error){
		queryDaiban();
		L5.Msg.alert('提示','成功提交至下一环节！');
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}