
function init() {
		
		if (method==null||method==""){
			L5.Msg.alert('提示',"未知的页面命令!");
			back();
			}
		else if (method=="INSERT"){
			BaseinfoPeopleDataSet.newRecord({
            peopleId: document.forms[0].peopleId.value
       		 ,familyId: document.forms[0].familyId.value});
			var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
			BaseinfoFamilyDataSet.newRecord({familyId: document.forms[0].familyId.value});	
			var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
			DependantDataset.newRecord({peopleId: document.forms[0].peopleId.value});	
			return;
		}else if (method=="UPDATE"){
			document.getElementById("peopleId").readOnly=true;
			BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="]=idField;
			BaseinfoPeopleDataSet.on("load",getValue);
			BaseinfoPeopleDataSet.load();
				
				var BptPeopleDisabilityDataSet=L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
			
		}
		function getValue() {
			//如果起先数据为空，则直接调用增加方法
			if(BaseinfoPeopleDataSet.getCount()==0){
				BaseinfoPeopleDataSet.newRecord();
				BptPeopleDisabilityDataSet.newRecord();
				return;
			}
				BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = idField;
				BptPeopleDisabilityDataSet.load();
			
		}
		L5.QuickTips.init(); 
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
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',funkction(state){
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

	//人员信息验证
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
	
	var birthday = BaseinfoPeopleRecord.get("birthday");
	if(birthday!=''&&!validateDateFormat(birthday)){
		L5.Msg.alert("提示","出生日期格式不正确！");
		return false;
	}
	//三属信息验证
	var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
	var DependantRecord=DependantDataset.getCurrent();
		DependantRecord.set("peopleId",peopleId);
	var isValidate = DependantDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	var lezswBirthday = DependantRecord.get("lezswBirthday");
	if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
		L5.Msg.alert("提示","烈士出生日期格式不正确！");
		return false;
	}
	
	var conscriptDate = DependantRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","烈士入伍时间格式不正确！");
		return false;
	}
	
	var deathDate = DependantRecord.get("deathDate");
	if(deathDate!=''&&!validateDateFormat(deathDate)){
		L5.Msg.alert("提示","烈士牺牲病故时间格式不正确！");
		return false;
	}
	
	var lezswApproveDate = DependantRecord.get("lezswApproveDate");
	if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert("提示","烈士批准时间格式不正确！");
		return false;
	}
	
	var approvalDate = DependantRecord.get("approvalDate");
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示","批准日期格式不正确！");
		return false;
	}
	
	var cancellationDate = DependantRecord.get("cancellationDate");
	if(cancellationDate!=''&&!validateDateFormat(cancellationDate)){
		L5.Msg.alert("提示","注销日期格式不正确！");
		return false;
	}
	
	var checkApproveDate = DependantRecord.get("checkApproveDate");
	if(checkApproveDate!=''&&!validateDateFormat(checkApproveDate)){
		L5.Msg.alert("提示","初审时间格式不正确！");
		return false;
	}
	
	var aduitApproveDate = DependantRecord.get("aduitApproveDate");
	if(aduitApproveDate!=''&&!validateDateFormat(aduitApproveDate)){
		L5.Msg.alert("提示","复核时间格式不正确！");
		return false;
	}
	
	var verifyApproveDate = DependantRecord.get("verifyApproveDate");
	if(verifyApproveDate!=''&&!validateDateFormat(verifyApproveDate)){
		L5.Msg.alert("提示","审批时间格式不正确！");
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
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDependantCommand");
	
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("DependantRecord", DependantRecord);
	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.execute("insert");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/cams/bpt/dependant/dependantList.jsp';
		var text="遗属人员信息表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function returnClick(){	
	var url='jsp/cams/bpt/dependant/dependantList.jsp';
	var text='基础信息_人员信息';
	L5.forward(url,text);	
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

