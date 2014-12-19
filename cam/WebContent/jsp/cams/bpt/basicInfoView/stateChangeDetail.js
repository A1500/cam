function init() {
		var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
		StateChangeDataset.setParameter("BPT_STATE_CHANGE.PEOPLE_ID@=",peopleId);
		StateChangeDataset.load();
		var count = StateChangeDataset.getCount();
		if(count==0){
			StateChangeDataset.newRecord();
		}
		L5.QuickTips.init(); 
}

function statePreRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['changeStatePre'];
	if(dataType=="1")
		return "受理";
	else if(dataType=="2")
		return "享受待遇";
	else if(dataType=="3")
		return "身份认定不享受待遇";
	else if(dataType=="4")
		return "停发";
	else if(dataType=="5")
		return "转移";
	else if(dataType=="6")
		return "不予认定";
	else if(dataType=="7")
		return "死亡";
	else
		return "";
}

function stateSufRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['changeStateSuf'];
	if(dataType=="1")
		return "受理";
	else if(dataType=="2")
		return "享受待遇";
	else if(dataType=="3")
		return "身份认定不享受待遇";
	else if(dataType=="4")
		return "停发";
	else if(dataType=="5")
		return "转移";
	else if(dataType=="6")
		return "不予认定";
	else if(dataType=="7")
		return "死亡";
	else
		return "";
}