function init() {
		var PetitionDataset = L5.DatasetMgr.lookup("PetitionDataset");
		PetitionDataset.setParameter("BPT_PETITION.PEOPLE_ID@=",peopleId);
		PetitionDataset.load();
		L5.QuickTips.init(); 
}

function insert() {
	
	//状态变更中也是取的这两个字段，因此用其方法
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptStateChangeCommand");
			command.setParameter("peopleId", peopleId);
			command.execute("queryPeopleInfo");
	
		var name = command.getReturn("name");
		var idCard = command.getReturn("idCard");
		
	PetitionDataset.newRecord({name:name,idCard:idCard,objectType:objectType});
    document.getElementById("name").value = name;
	document.getElementById("idCard").value = idCard ;
	document.getElementById("objectType").value = objectType;
	PetitionDataset.moveLast();
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
				delIds[i]=selected[i].get("petitionId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPetitionCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	PetitionDataset.remove(selected[i]);
				}
				PetitionDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function save() {
	
	var PetitionDataset = L5.DatasetMgr.lookup("PetitionDataset");
	var PetitionRecord=PetitionDataset.getCurrent();
	
		//判断是保存还是修改
	var petitionId = PetitionRecord.get("petitionId");
	if(petitionId != ""){
		alert("请点击【修改】按钮保存修改内容！");
		return false;
	}
	var petitionDate = PetitionRecord.get("petitionDate");
	if(petitionDate!=''&&!validateDateFormat(petitionDate)){
		L5.Msg.alert("提示","信访时间格式不正确！");
		return false;
	}
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	
	PetitionRecord.set("peopleId",peopleId);
	PetitionRecord.set("name",name);
	PetitionRecord.set("idCard",idCard);
	PetitionRecord.set("objectType",objectType);
	
	var isValidate = PetitionDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPetitionCommand");
	command.setParameter("record", PetitionRecord);
	command.execute("insert");
	if (!command.error) {
		PetitionDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function reset() {
	PetitionDataset.rejectChanges();
}
function objectTypeRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['objectType'];
	if(dataType=="01")
		return "残疾军人";
	else if(dataType=="02")
		return "伤残国家机关工作人员";
	else if(dataType=="03")
		return "伤残人民警察";
	else if(dataType=="04")
		return "伤残民兵民工";
	else if(dataType=="05")
		return "烈士家属";
	else if(dataType=="06")
		return "因公牺牲军人家属";
	else if(dataType=="07")
		return "病故军人家属";
	else if(dataType=="08")
		return "在乡退伍红军老战士";
	else if(dataType=="09")
		return "在乡西路军红军老战士";
	else if(dataType=="10")
		return "红军失散人员";
	else if(dataType=="11")
		return "在乡复员军人";
	else if(dataType=="12")
		return "带病回乡复员军人";
	else if(dataType=="13")
		return "参战";
	else if(dataType=="14")
		return "参试";
	else
		return "";
}

