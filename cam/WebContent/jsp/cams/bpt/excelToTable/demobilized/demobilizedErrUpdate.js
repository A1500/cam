function init() {

var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	    BaseinfoPeopleDataSet.setParameter("organCode",organCode);
		BaseinfoPeopleDataSet.setParameter("makeTable","bpt_imp_demobilized_make");
		BaseinfoPeopleDataSet.setParameter("id",id);
		BaseinfoPeopleDataSet.load();

	L5.QuickTips.init();
}
function func_BankName(){
  BaseinfoPeopleDataSet.set("accountName",BaseinfoPeopleDataSet.get("name"));
}
/*
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if (dataset.movePrev()) {

		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if (dataset.moveNext()) {

		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;

}

function removeBptPeopleDisability() {
	var editGrid = L5.getCmp('BptPeopleDisabilityEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
			for (var i = 0; i < selected.length; i++) {
				var delId = selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				BptPeopleDisabilityDataSet.remove(selected[i]);
			}

		} else {
			return false;
		}
	});
}

function insertClick(e) {
	document.getElementById("peopleId").readOnly = false;
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	// 如果某必填数据为"",不再继续增加
	if (dataset.getCount() > 0 && document.forms[0].peopleId.value.trim() == "") {
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount() - 1);

	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = "-";
	BptPeopleDisabilityDataSet.load();

}
function deleteClick(e) {
	L5.MessageBox.confirm('确定', '你确定要删除吗？', function(sta) {
		if (sta == "yes") {
			var BaseinfoPeopleDataSet = L5.DatasetMgr
					.lookup("BaseinfoPeopleDataSet");
			var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
			var delIds = [];
			delIds[0] = BaseinfoPeopleRecord.get("peopleId");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				BaseinfoPeopleDataSet.remove(BaseinfoPeopleRecord);
				if (!Evt_butNext_click()) {
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示', '删除成功！');
				var url = 'jsp/bpt/disability/baseinfopeople_list.jsp';
				var text = "用户表";
				L5.forward(url, text);
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else
			return;
	});

}*/
function saveClick() {

	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.ExcelToTableCommand");
	// 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();

	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	var idCard = document.getElementById("idCard");
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	
	
	
	// 校验户口薄(行政区划)
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if (domicileCode == '') {
		L5.Msg.alert('提示', '户口薄(行政区划)不能为空！');
		return false;
	}
	
	// 校验实际居住(行政区划)
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if (apanageCode == '') {
		L5.Msg.alert('提示', '实际居住(行政区划)不能为空！');
		return false;
	}
	
	if(document.getElementById("safeguardType").value==""){
	    L5.Msg.alert("提示", "请选择医疗保障方式!");
		return false;
	}
/*		if(L5.getDom("conscriptDate")==null||L5.getDom("conscriptDate")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}*/
	
	var conscriptDate =BaseinfoPeopleRecord.get("conscriptDate");
	if(!validateDateFormat(conscriptDate))
	{
		 L5.Msg.alert('提示','入伍时间格式不正确！');
		 return false;
	}
	
	var decruitmentDate =BaseinfoPeopleRecord.get("decruitmentDate");
	if(!validateDateFormat(decruitmentDate))
	{
		 L5.Msg.alert('提示','复员时间格式不正确！');
		 return false;
	}
	var approvalDate = BaseinfoPeopleRecord.get("approvalDate");
	if(!validateDateFormat(approvalDate))
	{
		 L5.Msg.alert('提示','批准时间格式不正确！');
		 return false;
	}
	
	//校验开户银行
	var bank = BaseinfoPeopleRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = BaseinfoPeopleRecord.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = BaseinfoPeopleRecord.get("accountCode");
	if(accountCode == ''){
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}
	
	command.setParameter("makeTable","bpt_imp_demobilized_make");
	command.setParameter("record", BaseinfoPeopleRecord);
	command.execute("updateDisabilityMakeTable");
	if (!command.error) {
		L5.Msg.alert('提示', "修改成功！");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}
// 验证身份证合法性
function func_CheckIdCard() {
	idCard = document.forms[0].idCard;
	stype = document.forms[0].stype.value;
	idCardValue = idCard.value;
	if (idCardValue == null || idCardValue == "") {
		return;
	}
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	func_GetBirthday();
}
/*
*由身份证自动生成出生日期
*/
function func_GetBirthday() 
{ 
   var val=document.forms[0].idCard.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
   } 
}
/*
function submit() {
	var records = BptPeopleDisabilityDataSet.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleDisabilityDataSet.commitChanges();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function undo() {
	BptPeopleDisabilityDataSet.rejectChanges();
}
*/
function func_BelongDate(){
  var conscriptDate = BaseinfoPeopleDataSet.get("conscriptDate");
  if(conscriptDate !=''){
     if(conscriptDate>='1937-07-07'&&conscriptDate<='1945-09-02'){
         BaseinfoPeopleDataSet.set("belongDate",1);
     }else if(conscriptDate>='1945-09-03'&&conscriptDate<='1949-09-30'){
         BaseinfoPeopleDataSet.set("belongDate",2);
     }else{
         BaseinfoPeopleDataSet.set("belongDate",3);
     }
  }
}

function func_Type(){
  if(document.getElementById("domicileType").value=='1'){
     document.getElementById("work").style.display='none';
     document.getElementById("workAddress").style.display='none';
     document.getElementById("employmentCode").disabled=true;
  }else{
     document.getElementById("work").style.display='';
     document.getElementById("workAddress").style.display='';
     document.getElementById("employmentCode").disabled=false;
  }
}

function func_Close(){
	window.close();
}

