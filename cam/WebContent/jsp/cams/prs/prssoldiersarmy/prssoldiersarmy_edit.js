function init() {
   if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	else if(method=="INSERT"){
		prssoldiersArmyDataset.newRecord();
	}
	else if (method=="UPDATE"){
		prssoldiersArmyDataset.setParameter("SOLDIERS_ID",idField);
		prssoldiersArmyDataset.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	L5.QuickTips.init(); 
}

function save(){

	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	var records = prssoldiersArmyDataset.getCurrent()
	var valid = prssoldiersArmyDataset.isValidate();
		
	if(valid !== true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.prs.prssoldiersarmy.cmd.PrsSoldiersArmyCommand"); 
	command.setParameter("records",records);
	if(method=="INSERT"){
	}else if(method =="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function back()
{	
 	history.go(-1);
}
