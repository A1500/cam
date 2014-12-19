function init() {
	var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");	
	ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
	ContentNumMaintainDataset.load();
	
	var ArchivalFondsDataset = L5.DatasetMgr.lookup("ArchivalFondsDataset");
	ArchivalFondsDataset.setParameter("DOMICILE_CODE@=",organCode);
	ArchivalFondsDataset.load();
	ArchivalFondsDataset.on("load",function(){
		var records = ArchivalFondsDataset.getAllRecords();
		if(records.length<1){
			ArchivalFondsDataset.newRecord();
		}
	});
	L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ContentNumMaintainDataset.newRecord();	
}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("contentNumId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainCommand");
			command.setParameter("delIds", delIds);
			command.execute("checkDelete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ContentNumMaintainDataset.remove(selected[i]);
				}
				var eids = command.getReturn("eid");
				if(eids!=''){
					L5.Msg.alert('提示',"目录号："+eids+"已有人员使用！请先将此目录号下的人员移除！");
					ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
					ContentNumMaintainDataset.load();
				}
				
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}

//保存全宗号
/*function saveArchivalFonds(){
	
	var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");	
	ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
	ContentNumMaintainDataset.load();
	var records = ArchivalFondsDataset.getCurrent();
	
	var archivalFondsName = document.getElementById("archivalFondsName").value;
	if(archivalFondsName==''){
		L5.Msg.alert('提示',"全宗号名称不能为空!");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptArchivalFondsNumberCommand");
	command.setParameter("organCode", organCode);
	command.setParameter("organName", organName);
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}*/

function save() {
	
	var ArchivalFondsDataset = L5.DatasetMgr.lookup("ArchivalFondsDataset");

	var archivalFondsId = ArchivalFondsDataset.get("archivalFondsId");
	if(archivalFondsId == ''){
		L5.Msg.alert('提示','请先输入并保存全宗号!');
		return false;
	}
	
	var records = ContentNumMaintainDataset.getAllChangedRecords();
	//目录号名称不能相同
	var allRecords = ContentNumMaintainDataset.getAllRecords();
	for(var i=0;i<allRecords.length;i++){
		for(var j=i+1;j<allRecords.length;j++){
			if(allRecords[i].get("contentNumName")==allRecords[j].get("contentNumName")){
				L5.Msg.alert('提示','目录号不能相同!');
				return false;
			}	
		}
	}
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ContentNumMaintainDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainCommand");
	command.setParameter("organCode", organCode);
	command.setParameter("organName", organName);
	command.setParameter("archivalFondsId", archivalFondsId);
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ContentNumMaintainDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	ContentNumMaintainDataset.rejectChanges();
}


