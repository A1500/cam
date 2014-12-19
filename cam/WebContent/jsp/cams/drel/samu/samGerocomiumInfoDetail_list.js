function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");
	samGerocomiumInfoDataSet.load();
	var samRoomInfoDataSet=L5.DatasetMgr.lookup("samRoomInfoDataSet");
	samRoomInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samRoomInfoDataSet.load();
	var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	samWorkerInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samWorkerInfoDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function queryBed(){
	var samRoomInfoDataSet=L5.DatasetMgr.lookup("samRoomInfoDataSet");
	var roomName=document.getElementById("roomName").value;
	var inuseArea=document.getElementById("inuseArea").value;
	var bedNum=document.getElementById("bedNum").value;
	var isToilet=document.getElementById("isToilet").value;
	var status=document.getElementById("status").value;
	samRoomInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samRoomInfoDataSet.setParameter("ROOM_NAME@=",roomName);
	samRoomInfoDataSet.setParameter("INUSE_AREA@=",inuseArea);
	samRoomInfoDataSet.setParameter("BED_NUM@=",bedNum);
	samRoomInfoDataSet.setParameter("IS_TOILET@=",isToilet);
	samRoomInfoDataSet.setParameter("STATUS@=",status);
	samRoomInfoDataSet.load();
}
function detailRoom(){
	var grid=L5.getCmp("gridRoom");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var roomId=records[0].get("roomId");
	var win=L5.getCmp("BedInfoWin");
	win.show(this);
	var samBedInfoDataSet=L5.DatasetMgr.lookup("samBedInfoDataSet");
	samBedInfoDataSet.setParameter("ROOM_ID@=",roomId);
	samBedInfoDataSet.load();
}
function closeWin(){
	L5.getCmp("BedInfoWin").setVisible(false);
}
function queryWorker(){
	var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	var workerName=document.getElementById("workerName").value;
	var idCard=document.getElementById("idCard").value;
	var postProperty=document.getElementById("postProperty").value;
	var workType=document.getElementById("workType").value;
	var isOnduty=document.getElementById("isOnduty").value;
	samWorkerInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samWorkerInfoDataSet.setParameter("WORKER_NAME@=",workerName);
	samWorkerInfoDataSet.setParameter("ID_CARD@=",idCard);
	samWorkerInfoDataSet.setParameter("POST_PROPERTY@=",postProperty);
	samWorkerInfoDataSet.setParameter("WORK_TYPE@=",workType);
	samWorkerInfoDataSet.setParameter("IS_ONDUTY@=",isOnduty);
	samWorkerInfoDataSet.load();
}
function detailWorker(){
	var grid=L5.getCmp("gridWorker");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var workerId= records[0].get("workerId");
	var samWorkerInfoDataSet=L5.DatasetMgr.lookup("samWorkerInfoDataSet");
	samWorkerInfoDataSet.setParameter("WORKER_ID@=",workerId);
	samWorkerInfoDataSet.load();
}