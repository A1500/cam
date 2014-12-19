function init() {
		 if (method=="INSERT"){
		    var dsWar=L5.DatasetMgr.lookup("dsWar");
	        dsWar.newRecord({peopleId: document.forms[0].peopleId.value});
		    
			BaseinfoPeopleDataSet.newRecord({peopleId:document.forms[0].peopleId.value,familyId: document.forms[0].familyId.value});
			
			var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
			dsWar.set("warStateCode",2);
			dsWar.set("supportPattern",1);
			var typeInfo =L5.getCmp("typeInfo");
			typeInfo.on("activate",func_BankName);
			return;
		}
		
}
function func_BankName(){
  dsWar.set("accountName",BaseinfoPeopleDataSet.get("name"));
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
function func_Close(){
	window.close();
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
				var url='jsp/bpt/dataCollection/war/bptwar_list.jsp';
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
	
	var img = document.getElementById("photoTemp").value;
	
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
	//人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp', img);
	//参战信息
	var dsWar=L5.DatasetMgr.lookup("dsWar");
	var warEntity=dsWar.getCurrent();
	//新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   warEntity.set("peopleId",peopleId);
	}else{//修改人员信息
	   warEntity.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	   peopleId = BaseinfoPeopleRecord.get("peopleId");
	   familyId = BaseinfoPeopleRecord.get("familyId");
	}
	//校验健康状况
	if(warEntity.get("healthStateCode") == ''){
		L5.Msg.alert("提示","健康状况不能为空！");
		return false;
	}
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	getCrjCnStrSpell('namebase','phoneticCode','m'); 
	var phoneticCode = document.getElementById("phoneticCode").value;
	BaseinfoPeopleRecord.set('phoneticCode', phoneticCode);
	
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
	
	if(BaseinfoPeopleDataSet.get("safeguardType") == ''){
		L5.Msg.alert("提示","医疗保障方式不能为空");
		return false;
	}
	if(BaseinfoPeopleDataSet.get("domicileType") == ''){
		L5.Msg.alert("提示","户籍类别不能为空");
		return false;
	}
	
	
	if(L5.getDom("warNo")==null||L5.getDom("warNo")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}
	
	
	var isDsValidate = dsWar.isValidate();
	if(isDsValidate != true){
		L5.Msg.alert("提示",isDsValidate);
		return false;
	}
	var approvalDate = warEntity.get("approvalDate");
	if(approvalDate!=""&&!validateDateFormat(approvalDate)){
		L5.Msg.alert('提示','批准日期格式不正确！');
		  return false;
	}
	if(approvalDate==""){
		L5.Msg.alert('提示','批准日期不能为空！');
		return false;
	}
	var conscriptcDate = warEntity.get("conscriptcDate");
	if(conscriptcDate!=''&&!validateDateFormat(conscriptcDate)){
		L5.Msg.alert('提示','入伍（参加工作）时间格式不正确！');
		  return false;
	}
	var decruitmentDate = warEntity.get("decruitmentDate");
	if(decruitmentDate!=""&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert('提示','退伍时间格式不正确！');
		  return false;
	}
	var retiredDate = warEntity.get("retiredDate");
	if(retiredDate!=""&&!validateDateFormat(retiredDate)){
		L5.Msg.alert('提示','离退休时间格式不正确！');
		  return false;
	}
	//生活补助证编号
	var stateCode = warEntity.get("warStateCode");
	if(stateCode=='2'){
	    if(warEntity.get("warNo")==''){
	      L5.Msg.alert('提示','生活补助证编号不能为空！');
		  return false;
	    }
	    
	}
	//校验开户银行
	var bank = warEntity.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = warEntity.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = warEntity.get("accountCode");
	if(accountCode == ''){
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"51",false)){
		L5.Msg.alert('提示', '该人员已经是参战人员！');
		return false;
	}
	
	command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
    command.setParameter("warEntity",warEntity);
	command.execute("insert");
	
	if (!command.error) {
	    BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
//		L5.Msg.alert('提示','保存成功！');
//		var data = new L5.Map();//alert(BaseinfoPeopleRecord.get("peopleId"));alert(BaseinfoPeopleRecord.get("familyId"));
//		data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
//		data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
//		var url='jsp/cams/bpt/dataCollection/war/bptwar_edit.jsp';
//		var text = '伤残人员信息修改';
//		L5.forward(url,text,data);
	    var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
	    window.returnValue = peopleId1+";"+familyId1;
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
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
function func_blur(){
  if(dsWar.get("forcesNo")!=''){
     document.getElementById("forcesNo").disabled=true;
  }
}
/**
 * 选择健康状况
 */
function func_HealthSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/dichealth/dichealth.jsp", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("healthStateName").value = list[1];
		dsWar.set("healthStateCode", list[0]);
	}
}
function idcardlookup(){
	L5.getCmp("imgshow").show();
	//window.open (L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?src=data:image/jpeg;base64,'+ pPrintPhotoBuffer,'身份证件',
	//'height=500,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
function idcardclose(){
	var win = L5.getCmp("imgshow");
	win.hide();
}