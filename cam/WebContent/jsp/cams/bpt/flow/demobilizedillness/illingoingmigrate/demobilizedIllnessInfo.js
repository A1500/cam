
function init() {
		DemobilizedIllnessDataset.setParameter("APPLY_ID",applyId);
		DemobilizedIllnessDataset.load();
		
}

function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if(dataset.movePrev()){
				
	  	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if(dataset.moveNext()){
	
		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;

}

function removeBptPeopleDisability() {
	var editGrid=L5.getCmp('BptPeopleDisabilityEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");				
				command.setParameter("delId", delId);
				command.execute("delete");
				BptPeopleDisabilityDataSet.remove(selected[i]);
			}
			
		}else{
			return false;
		}
	});
}

function insertClick(e){
	document.getElementById("peopleId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].peopleId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);
	
	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="]="-" ;
	BptPeopleDisabilityDataSet.load();

}
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
			var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
			var  delIds=[];
			delIds[0]= BaseinfoPeopleRecord.get("peopleId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				BaseinfoPeopleDataSet.remove(BaseinfoPeopleRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/bpt/disability/baseinfopeople_list.jsp';
				var text="用户表";
				L5.forward(url,text);
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
		else
			return;
	}
	);

}
function saveClick(){

	/*人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	var peopleId=document.getElementById("peopleId").value;
	BaseinfoPeopleRecord.set("peopleId",peopleId);
	var familyId=document.getElementById("familyId").value;
	BaseinfoPeopleRecord.set("familyId",familyId);
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	
	//家庭信息验证
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	var BaseinfoFamilyRecord=BaseinfoFamilyDataSet.getCurrent();
	BaseinfoPeopleRecord.set("familyId",familyId);
	var isValidate = BaseinfoFamilyDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}*/
	
	// 带病回乡退伍军人信息验证
	var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
	var DemobilizedIllnessRecord=DemobilizedIllnessDataset.getCurrent();
		DemobilizedIllnessRecord.set("peopleId",peopleId);
	var isValidate = DemobilizedIllnessDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessCommand");
	
	//command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("DemobilizedIllnessRecord", DemobilizedIllnessRecord);
	//command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.execute("update");
	if (!command.error) {
		//BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		//returnClick();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function returnClick(){	
	//var url='jsp/cams/bpt/dataCollection/demobilizedIllness/demobilizedIllnessList.jsp';
	//var text='带病回乡退伍军人信息';
	//L5.forward(url,text);	
	
	history.go(-1);
}

function submit() {
	var records = BptPeopleDisabilityDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleDisabilityDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undo() {
	BptPeopleDisabilityDataSet.rejectChanges();
}

