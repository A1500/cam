var ifValid = "";
function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somApplyDataSet.setParameter("SORG_ID@=",sorgId);
	somApplyDataSet.load();	
	somSessionDataSet.setParameter("SORG_ID",sorgId);
	if(sorgStatus=="14" || sorgStatus=="15" || sorgStatus=="16"){
		L5.getCmp("tab").remove(1);
	}else{		
		somSessionDataSet.load();
		somSessionDataSet.on('load', function(){
			var record=somSessionDataSet.getCurrent();
			var taskCode=record.get("taskCode");
			//加载简历信息
			var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
			somResumeDataSet.setParameter("TASK_CODE@=", record.get('taskCode'));
			somResumeDataSet.load();
			var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
			somDutyDataSet.setParameter("SESSION_ID", record.get('sessionId'));
			somDutyDataSet.load();
		});
	}
}
//查看负责人
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);
	
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('peopleId')==somResumeRecord.get('peopleId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	
	var win = L5.getCmp("peopleWin");
	win.show();
}
function closeWin(){
	var win = L5.getCmp("peopleWin");
	win.setVisible(false);
}

function closeThisWindow(){
	window.close();
}