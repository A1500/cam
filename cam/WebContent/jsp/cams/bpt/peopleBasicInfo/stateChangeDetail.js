function init() {
		var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
		StateChangeDataset.setParameter("BPT_STATE_CHANGE.PEOPLE_ID@=",peopleId);
		StateChangeDataset.load();
		L5.QuickTips.init(); 
}

function insert(){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptStateChangeCommand");
		command.setParameter("peopleId", peopleId);
		command.execute("queryPeopleInfo");
	
		var name = command.getReturn("name");
		var idCard = command.getReturn("idCard");
	
		var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
		StateChangeDataset.newRecord({name:name,idCard:idCard,changeStatePre:changeStatePre});
        document.getElementById("name").value = name;
		document.getElementById("idCard").value = idCard;
		document.getElementById("changeStatePre").value = changeStatePre;
}

function save(){
	//状态变更
	var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
	var StateChangeRecord=StateChangeDataset.getCurrent();
	
	//判断是保存还是修改
	var stateChangeId = StateChangeRecord.get("stateChangeId");
	if(stateChangeId != ""){
		alert("请点击【修改】按钮保存修改内容！");
		return false;
	}
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	StateChangeRecord.set("peopleId",peopleId);
	StateChangeRecord.set("name",name);
	StateChangeRecord.set("idCard",idCard);
	StateChangeRecord.set("changeStatePre",changeStatePre);
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptStateChangeCommand");
	
	command.setParameter("StateChangeRecord", StateChangeRecord);
	command.setParameter("changeStatePre", changeStatePre);
	command.setParameter("objectType", objectType);
	command.execute("insert");
	
	if (!command.error) {
		changeStatePre = document.getElementById("changeStateSuf").value;
		StateChangeDataset.commitChanges();
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
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
		return "迁移";
	else if(dataType=="6")
		return "不予认定";
	else if(dataType=="7")
		return "死亡";
	else
		return "";
}